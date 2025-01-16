import 'package:dio/dio.dart';

class NetworkUtils {
  static Future<bool> isConnected() async {
    try {
      final response = await Dio().get('https://www.google.com');
      return response.statusCode == 200;
    } catch (e) {
      return false;
    }
  }
}
