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
import '../controllers/forgot_password_controller.dart';

class ForgotPasswordView extends StatefulWidget {
  const ForgotPasswordView({super.key});

  @override
  State<ForgotPasswordView> createState() => _ForgotPasswordViewState();
}

class _ForgotPasswordViewState extends State<ForgotPasswordView> {
  final ForgotPasswordController forgotPasswordController =
      Get.put(ForgotPasswordController());

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
                  'Lost your Password?',
                  style: h2.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),
                sh12,
                Text(
                  'We will send the OTP code to your email for security in forgetting your password',
                  style: h5.copyWith(color: AppColors.grey),
                ),
                sh30,
                Text(
                  'Email',
                  style: h4,
                ),
                sh8,
                CustomTextField(
                  controller: forgotPasswordController.emailTEController,
                  hintText: 'Enter your email',
                ),
                sh30,
                Obx(
                  () {
                    return forgotPasswordController.isLoading.value == true
                        ? CustomLoader(color: AppColors.white)
                        : CustomButton(
                            text: 'Send Code',
                            onPressed: () {
                              forgotPasswordController.forgotPassword(
                                email: forgotPasswordController
                                    .emailTEController.text
                                    .trim(),
                              );
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
