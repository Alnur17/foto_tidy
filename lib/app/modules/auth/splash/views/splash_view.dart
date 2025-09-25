import 'package:flutter/material.dart';
import 'package:foto_tidy/common/widgets/custom_background_color.dart';

import 'package:get/get.dart';

import '../../../../../common/app_images/app_images.dart';
import '../../onboarding/views/onboarding_view.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3), () {
      Get.to(
            () => OnboardingView(),
        transition: Transition.rightToLeft,
        duration: Duration(milliseconds: 1000),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomBackgroundColor(
        child: Image.asset(
          AppImages.logoMain,
          scale: 4,
        ),
      ),
    );
  }
}