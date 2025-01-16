import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:task_manager/features/auth/data/data_source/auth_data_source.dart';
import 'package:task_manager/features/auth/data/repositories/auth_repositories_impl.dart';

class MockAuthRemoteDataSource extends Mock implements AuthRemoteDataSource {}

void main() {
  late AuthRepositoryImpl authRepository;
  late MockAuthRemoteDataSource mockAuthRemoteDataSource;

  setUp(() {
    mockAuthRemoteDataSource = MockAuthRemoteDataSource();
    authRepository =
        AuthRepositoryImpl(remoteDataSource: mockAuthRemoteDataSource);
  });

  group('AuthRepositoryImpl', () {
    const username = 'testUser';
    const password = 'testPassword';
    final Map<String, dynamic> mockResponse = {
      'token': '12345',
      'user': {'id': 1, 'username': 'testUser', 'email': 'test@example.com'}
    };

    test('should return login data when login is successful', () async {
      when(mockAuthRemoteDataSource.login(username, password))
          .thenAnswer((_) async => mockResponse);

      final result = await authRepository.login(username, password);

      expect(result, mockResponse);
      verify(mockAuthRemoteDataSource.login(username, password)).called(1);
    });

    test('should throw an exception when login fails', () async {
      when(mockAuthRemoteDataSource.login(username, password))
          .thenThrow(Exception('Login failed'));

      expect(() async => await authRepository.login(username, password),
          throwsA(isA<Exception>()));
      verify(mockAuthRemoteDataSource.login(username, password)).called(1);
    });
  });
}
