import 'package:dio/dio.dart';
import 'package:task_manager/core/constants/app_constants.dart';

class AuthRemoteDataSource {
  final Dio _dio = Dio();

  AuthRemoteDataSource() {
    _dio.options.baseUrl = 'https://dummyjson.com';
    _dio.options.headers = {
      'Content-Type': 'application/json',
    };

    _dio.interceptors
        .add(LogInterceptor(responseBody: true, requestBody: true));
  }

  Future<Map<String, dynamic>> login(String username, String password) async {
    try {
      final response = await _dio.post(
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
