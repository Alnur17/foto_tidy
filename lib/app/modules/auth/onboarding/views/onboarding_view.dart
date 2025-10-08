import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:foto_tidy/app/modules/auth/login/views/login_view.dart';
import 'package:foto_tidy/common/app_color/app_colors.dart';
import 'package:foto_tidy/common/app_images/app_images.dart';
import 'package:foto_tidy/common/size_box/custom_sizebox.dart';
import 'package:foto_tidy/common/widgets/custom_background_image.dart';
import 'package:foto_tidy/common/widgets/custom_button.dart';
import 'package:get/get.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../../../../../common/app_constant/app_constant.dart';
import '../../../../../common/helper/local_store.dart';
import '../../../../../common/widgets/onboarding_page.dart';
import '../controllers/onboarding_controller.dart';

class OnboardingView extends StatefulWidget {
  const OnboardingView({super.key});

  @override
  State<OnboardingView> createState() => _OnboardingViewState();
}

class _OnboardingViewState extends State<OnboardingView> {
  final _controller = Get.put(OnboardingController());

  final _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.mainColor,
      body: CustomBackgroundImage(
        child: Column(
          children: [
            Expanded(
              child: PageView(
                controller: _pageController,
                onPageChanged: (pageIndex) {
                  _controller.updatePage(pageIndex); // Update page index
                },
                children: [
                  OnboardingPage(
                    title: "FotoTidy - Find Any Photo In Seconds",
                    description:
                        "No more endless scrolling – FotoTidy lets you tag and organize your pictures instantly so you can retrieve them anytime, stress-free.",
                    image: AppImages.onboardingImageOne,
                  ),
                  OnboardingPage(
                    title: "Goodbye Chaos , Hello Clarity",
                    description:
                        "Turn your messy camera roll into a perfectly organized photo library – so every memory is right where you need it.",
                    image: AppImages.onboardingImageTwo,
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 20.w,
                vertical: 20.h,
              ),
              child: Column(
                children: [
                  SmoothPageIndicator(
                    controller: _pageController,
                    count: 2,
                    effect: WormEffect(
                      dotColor: AppColors.grey,
                      activeDotColor: AppColors.orange,
                      dotHeight: 10,
                      dotWidth: 10,
                    ),
                  ),
                  sh20,
                  CustomButton(
                    text: 'Get Started',
                    onPressed: () {
                      LocalStorage.saveData(key: AppConstant.onboardingDone, data: "onboardingDone");
                      Get.to(()=> LoginView());
                    },
                    gradientColors: AppColors.buttonColor,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
