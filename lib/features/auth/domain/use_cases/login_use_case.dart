import 'package:task_manager/features/auth/domain/repositories/auth_repository.dart';

class LoginUseCase {
  final AuthRepository repository;

  LoginUseCase({required this.repository});

  Future<Map<String, dynamic>> call(String username, String password) async {
    return await repository.login(username, password);
  }
}
