import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:lottie/lottie.dart';
import 'package:taskati/core/constants/app_images.dart';
import 'package:taskati/core/functions/navigator.dart';
import 'package:taskati/core/services/local_storage.dart';
import 'package:taskati/core/utils/text_styles.dart';
import 'package:taskati/features/Home/pages/home_page.dart';
import 'package:taskati/features/intro/pages/upload_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    String? isFirstTime = LocalStorage.getData(LocalStorage.name);
    Future.delayed(const Duration(seconds: 5), () {
      if (isFirstTime != null) {
        context.pushReplacement(const HomePage());
      } else {
        context.pushReplacement(const UploadScreen());
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Lottie.asset(AppImages.logo, width: 300, height: 300),
            const SizedBox(height: 20),
            Text(
              'Taskati',
              style: AppTextStyles.title(context, fontWeight: FontWeight.w500),
            ),
            Gap(15),
            Text(
              'It\'s time to get organized',
              style: AppTextStyles.subtitle(context),
            ),
          ],
        ),
      ),
    );
  }
}
