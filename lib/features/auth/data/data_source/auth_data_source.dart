import 'package:dio/dio.dart';

class AuthRemoteDataSource {
  final Dio dio;

  AuthRemoteDataSource({Dio? dio}) : dio = dio ?? Dio() {
    this.dio.options.baseUrl = 'https://dummyjson.com';
    this.dio.options.headers = {
      'Content-Type': 'application/json',
    };

    this
        .dio
        .interceptors
        .add(LogInterceptor(responseBody: true, requestBody: true));
  }

  Future<Map<String, dynamic>> login(String username, String password) async {
    try {
      final response = await dio.post(
        '/auth/login',
        data: {
          'username': username,
          'password': password,
        },
      );

      if (response.statusCode == 200) {
        return response.data;
      } else {
        throw Exception(
            'Failed to login with status code: ${response.statusCode}');
      }
    } on DioException catch (e) {
      throw Exception('Dio Error: ${e.message}');
    }
  }
}
