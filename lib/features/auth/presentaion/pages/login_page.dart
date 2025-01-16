import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:task_manager/component/custom_button.dart';
import 'package:task_manager/component/custom_image_handler.dart';
import 'package:task_manager/component/text_field_component.dart';
import 'package:task_manager/core/constants/app_images.dart';
import 'package:task_manager/core/utils/app_colors.dart';
import 'package:task_manager/features/auth/presentaion/bloc/auth/auth_bloc.dart';
import 'package:task_manager/features/task/presentaion/pages/task_page.dart';

class LoginPage extends StatelessWidget {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthLoading) {
            const Center(child: CircularProgressIndicator());
          }
          if (state is AuthSuccess) {
            Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (context) => TaskPage()));
          } else if (state is AuthFailure) {
            Fluttertoast.showToast(
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              backgroundColor: AppColors.redAlertColor,
              msg: "Username or Password is wrong",
            );
          }
        },
        builder: (context, state) {
          return SingleChildScrollView(
            child: Column(
              children: [
                60.verticalSpace,
                const CustomImageHandler(
                  AppImages.login,
                ),
                20.verticalSpace,
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        TextFieldComponent(
                          validator: (value) =>
                              value!.isEmpty ? 'Username is required' : null,
                          hint: 'Username',
                          controller: _usernameController,
                        ),
                        20.verticalSpace,
                        TextFieldComponent(
                          hint: 'Password',
                          validator: (value) =>
                              value!.isEmpty ? 'Password is required' : null,
                          controller: _passwordController,
                          hasShowPasswordIcon: true,
                        ),
                        40.verticalSpace,
                        state is AuthLoading
                            ? const CircularProgressIndicator(
                                color: AppColors.primaryColor,
                              )
                            : CustomButton(
                                text: 'Login',
                                onTap: () {
                                  if (_formKey.currentState!.validate()) {
                                    context.read<AuthBloc>().add(
                                          LoginEvent(
                                            username: _usernameController.text,
                                            password: _passwordController.text,
                                          ),
                                        );
                                  }
                                },
                              ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
