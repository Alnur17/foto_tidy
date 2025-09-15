import 'package:flutter/material.dart';
import 'package:foto_tidy/app/modules/auth/forgot_password/views/reset_success_view.dart';

import 'package:get/get.dart';
import '../../../../../common/app_color/app_colors.dart';
import '../../../../../common/app_images/app_images.dart';
import '../../../../../common/app_text_style/styles.dart';
import '../../../../../common/size_box/custom_sizebox.dart';
import '../../../../../common/widgets/custom_background_color.dart';
import '../../../../../common/widgets/custom_button.dart';
import '../../../../../common/widgets/custom_textfield.dart';

class SetNewPasswordView extends GetView {
  const SetNewPasswordView({super.key});

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
                    ),),
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
                CustomTextField(
                  hintText: '**********',
                  sufIcon: Image.asset(
                    AppImages.eyeClose,
                    scale: 4,
                  ),
                ),
                sh16,
                Text(
                  'Re-type New Password',
                  style: h4,
                ),
                sh12,
                CustomTextField(
                  sufIcon: Image.asset(
                    AppImages.eyeClose,
                    scale: 4,
                  ),
                  hintText: '**********',
                ),
                sh16,
                CustomButton(
                  text: 'Save changes',
                  onPressed: () {
                    Get.offAll(() => ResetSuccessView());
                  },
                  imageAssetPath: AppImages.arrowRightNormal,
                  gradientColors: AppColors.buttonColor,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
