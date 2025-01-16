import 'package:flutter_test/flutter_test.dart';
import 'package:task_manager/features/auth/data/model/user_model.dart';

void main() {
  group('UserModel', () {
    test('should create a UserModel from JSON', () {
      final Map<String, dynamic> json = {
        'id': 1,
        'username': 'test_user',
        'email': 'test@example.com',
      };

      final userModel = UserModel.fromJson(json);

      expect(userModel.id, 1);
      expect(userModel.username, 'test_user');
      expect(userModel.email, 'test@example.com');
    });

    test('should throw an exception if the JSON is missing required fields',
        () {
      final Map<String, dynamic> json = {};

      expect(() => UserModel.fromJson(json), throwsA(isA<TypeError>()));
    });
  });
}
