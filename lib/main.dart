import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:task_manager/features/auth/data/data_source/auth_data_source.dart';
import 'package:task_manager/features/auth/data/repositories/auth_repositories_impl.dart';
import 'package:task_manager/features/auth/presentaion/bloc/auth/auth_bloc.dart';
import 'package:task_manager/features/auth/presentaion/pages/login_page.dart';
import 'package:task_manager/features/task/data/data_sources/task_local_data_source.dart';
import 'package:task_manager/features/task/data/data_sources/task_remote_data_source.dart';
import 'package:task_manager/features/task/data/repositories/task_repositories_impl.dart';
import 'package:task_manager/features/task/domain/use_cases/add_task_use_case.dart';
import 'package:task_manager/features/task/domain/use_cases/delele_task_use_case.dart';
import 'package:task_manager/features/task/domain/use_cases/get_task_use_case.dart';
import 'package:task_manager/features/task/domain/use_cases/update_task_use_case.dart';
import 'package:task_manager/features/task/presentaion/bloc/task_bloc.dart';

import 'features/auth/domain/use_cases/login_use_case.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      builder: (context, child) => MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (_) => AuthBloc(
              loginUseCase: LoginUseCase(
                repository: AuthRepositoryImpl(
                  remoteDataSource: AuthRemoteDataSource(),
                ),
              ),
            ),
          ),
          BlocProvider(
            create: (_) => AuthBloc(
              loginUseCase: LoginUseCase(
                repository: AuthRepositoryImpl(
                  remoteDataSource: AuthRemoteDataSource(),
                ),
              ),
            ),
          ),
          BlocProvider(
            create: (_) => TaskBloc(
                getTasksUseCase: GetTasksUseCase(
                    repository: TaskRepositoryImpl(
                        localDataSource: TaskLocalDataSource(),
                        remoteDataSource: TaskRemoteDataSource())),
                addTaskUseCase: AddTaskUseCase(
                    repository: TaskRepositoryImpl(
                        localDataSource: TaskLocalDataSource(),
                        remoteDataSource: TaskRemoteDataSource())),
                updateTaskUseCase: UpdateTaskUseCase(
                    repository: TaskRepositoryImpl(
                        localDataSource: TaskLocalDataSource(),
                        remoteDataSource: TaskRemoteDataSource())),
                deleteTaskUseCase: DeleteTaskUseCase(
                    repository: TaskRepositoryImpl(
                        localDataSource: TaskLocalDataSource(),
                        remoteDataSource: TaskRemoteDataSource()))),
          ),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          home: LoginPage(),
        ),
      ),
    );
  }
}
