import 'package:flutter/material.dart';

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

class SetNewPasswordView extends GetView {
  SetNewPasswordView({super.key});

  final ForgotPasswordController forgotPasswordController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomBackgroundColor(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
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
                  ),
                ),
                sh12,
                Text(
                  'Set new password',
                  style: h2.copyWith(fontWeight: FontWeight.w700),
                ),
                sh12,
                Text(
                  'Enter your new password and make sure you remember it',
                  style: h5.copyWith(color: AppColors.grey),
                ),
                sh16,
                Text(
                  'New password',
                  style: h4,
                ),
                sh12,
                Obx(() {
                  return CustomTextField(
                    controller:
                        forgotPasswordController.newPasswordTEController,
                    hintText: '**********',
                    sufIcon: GestureDetector(
                      onTap: () {
                        forgotPasswordController.togglePasswordVisibility();
                      },
                      child: Image.asset(
                        forgotPasswordController.isPasswordVisible.value
                            ? AppImages.eyeOpen
                            : AppImages.eyeClose,
                        scale: 4,
                      ),
                    ),
                    obscureText:
                        !forgotPasswordController.isPasswordVisible.value,
                  );
                }),
                sh16,
                Text(
                  'Re-type New Password',
                  style: h4,
                ),
                sh12,
                Obx(() {
                  return CustomTextField(
                    controller:
                    forgotPasswordController.confirmNewPasswordTEController,
                    sufIcon: GestureDetector(
                      onTap: () {
                        forgotPasswordController.togglePasswordVisibility1();
                      },
                      child: Image.asset(
                        forgotPasswordController.isConfirmPasswordVisible.value
                            ? AppImages.eyeOpen
                            : AppImages.eyeClose,
                        scale: 4,
                      ),
                    ),
                    obscureText: !forgotPasswordController
                        .isConfirmPasswordVisible.value,
                    hintText: '**********',
                  );
                }),
                sh16,
                Obx(
                      () {
                    return forgotPasswordController.isLoading.value == true
                        ? CustomLoader(color: AppColors.white)
                        : CustomButton(
                      text: 'Save Changes',
                      // Dynamic translation for "Save changes"
                      onPressed: () {
                        forgotPasswordController.resetPass(email: forgotPasswordController.emailTEController.text.trim());
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
