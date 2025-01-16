import 'package:task_manager/features/auth/data/data_source/auth_data_source.dart';
import 'package:task_manager/features/auth/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;

  AuthRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Map<String, dynamic>> login(String username, String password) async {
    return await remoteDataSource.login(username, password);
  }
}
