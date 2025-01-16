import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';
import 'package:task_manager/features/auth/data/data_source/auth_data_source.dart';

void main() {
  late Dio dio;
  late DioAdapter dioAdapter;
  late AuthRemoteDataSource authRemoteDataSource;

  setUp(() {
    dio = Dio();
    dioAdapter = DioAdapter(dio: dio);
    dio.options.baseUrl = 'https://dummyjson.com';
    dio.httpClientAdapter = dioAdapter;

    authRemoteDataSource = AuthRemoteDataSource()
      ..dio.httpClientAdapter = dioAdapter;
  });

  group('AuthRemoteDataSource Login', () {
    const username = 'testuser';
    const password = 'testpassword';
    const loginEndpoint = '/auth/login';

    test('should return user data when login is successful', () async {
      final mockResponse = {
        'id': 1,
        'username': 'testuser',
        'email': 'testuser@example.com',
        'token': 'abcd1234'
      };

      dioAdapter.onPost(
        loginEndpoint,
        data: {'username': username, 'password': password},
        (server) => server.reply(200, mockResponse),
      );

      final result = await authRemoteDataSource.login(username, password);

      expect(result, mockResponse);
    });

    test('should throw an exception when login fails with non-200 status code',
        () async {
      dioAdapter.onPost(
        loginEndpoint,
        data: {'username': username, 'password': password},
        (server) => server.reply(401, {'message': 'Invalid credentials'}),
      );

      expect(
        () => authRemoteDataSource.login(username, password),
        throwsException,
      );
    });

    test('should throw an exception when a Dio error occurs', () async {
      dioAdapter.onPost(
        loginEndpoint,
        data: {'username': username, 'password': password},
        (server) => server.throws(
          500,
          DioException(
            requestOptions: RequestOptions(path: loginEndpoint),
            error: 'Server error',
          ),
        ),
      );

      expect(
        () => authRemoteDataSource.login(username, password),
        throwsException,
      );
    });
  });
}
