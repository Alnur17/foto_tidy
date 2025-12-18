import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';

import '../../../../../common/app_color/app_colors.dart';
import '../../../../../common/app_images/app_images.dart';
import '../../../../../common/app_text_style/styles.dart';
import '../../../../../common/size_box/custom_sizebox.dart';
import '../../../../../common/widgets/custom_background_color.dart';
import '../../../../../common/widgets/custom_button.dart';
import '../../../../../common/widgets/custom_loader.dart';
import '../../../../../common/widgets/custom_textfield.dart';
import '../controllers/sign_up_controller.dart';

class SignUpView extends StatefulWidget {
  const SignUpView({super.key});

  @override
  State<SignUpView> createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView> {
  final SignUpController signUpController = Get.put(SignUpController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomBackgroundColor(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                sh60,
                GestureDetector(
                    onTap: () {
                      Get.back();
                    },
                    child: Image.asset(
                      AppImages.back,
                      scale: 4,
                    )),
                sh12,
                Text(
                  'Create Your Account',
                  style: h2.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),
                sh12,
                Text(
                  'It is quick and easy to create your account',
                  style: h4,
                ),
                sh40,
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Name', style: h4),
                    sh8,
                    CustomTextField(
                      controller: signUpController.nameTEController,
                      hintText: 'Enter your name',
                      containerColor: AppColors.white,
                    ),
                    sh12,
                    Text('Email', style: h4),
                    sh8,
                    CustomTextField(
                      controller: signUpController.emailTEController,
                      hintText: 'Your email',
                      containerColor: AppColors.white,
                    ),
                    sh12,
                    Text('Password', style: h4),
                    sh8,
                    Obx(() {
                      return CustomTextField(
                        controller: signUpController.passwordTEController,
                        sufIcon: GestureDetector(
                          onTap: () {
                            signUpController.togglePasswordVisibility();
                          },
                          child: Image.asset(
                            signUpController.isPasswordVisible.value
                                ? AppImages.eyeOpen
                                : AppImages.eyeClose,
                            scale: 4,
                          ),
                        ),
                        obscureText: !signUpController.isPasswordVisible.value,
                        hintText: '**********',
                        containerColor: AppColors.white,
                      );
                    }),
                    sh12,
                    Text('Confirm Password', style: h4),
                    sh8,
                    Obx(() {
                      return CustomTextField(
                        controller: signUpController.confirmPassTEController,
                        sufIcon: GestureDetector(
                          onTap: () {
                            signUpController.toggleConfirmPasswordVisibility();
                          },
                          child: Image.asset(
                            signUpController.isConfirmPasswordVisible.value
                                ? AppImages.eyeOpen
                                : AppImages.eyeClose,
                            scale: 4,
                          ),
                        ),
                        obscureText:
                            !signUpController.isConfirmPasswordVisible.value,
                        hintText: '**********',
                        containerColor: AppColors.white,
                      );
                    }),
                  ],
                ),
                sh24,
                Obx(
                  () {
                    return signUpController.isLoading.value == true
                        ? CustomLoader(color: AppColors.white)
                        : CustomButton(
                            text: 'Create Account',
                            onPressed: () {
                              signUpController.registerUser();
                            },
                            imageAssetPath: AppImages.arrowRightNormal,
                            gradientColors: AppColors.buttonColor,
                          );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
