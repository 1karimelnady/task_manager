import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:task_manager/component/custom_image_handler.dart';
import 'package:task_manager/core/constants/app_images.dart';
import 'package:task_manager/core/utils/app_colors.dart';
import 'package:task_manager/features/auth/presentaion/pages/login_page.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Future.delayed(Duration(seconds: 2), () {
      SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
      SystemChrome.setSystemUIOverlayStyle(
          SystemUiOverlayStyle(statusBarColor: Colors.transparent));
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (_) => LoginPage()));
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      // appBar: AppBar(
      //   automaticallyImplyLeading: false,
      //   backgroundColor: AppColors.whiteColor,
      //   elevation: 1,
      //   centerTitle: true,
      //   title: Text(
      //     "Welcome to  Task Manager",
      //     style: TextStyle(fontSize: 19, fontWeight: FontWeight.normal),
      //   ),
      // ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Center(
              child: const CustomImageHandler(
                AppImages.splash,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
