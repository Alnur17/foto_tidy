import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:foto_tidy/app/modules/auth/forgot_password/views/set_new_password_view.dart';

import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import '../../../../../common/app_color/app_colors.dart';
import '../../../../../common/app_images/app_images.dart';
import '../../../../../common/app_text_style/styles.dart';
import '../../../../../common/size_box/custom_sizebox.dart';
import '../../../../../common/widgets/custom_background_color.dart';
import '../../../../../common/widgets/custom_button.dart';

class VerifyOtpView extends GetView {
  const VerifyOtpView({super.key});

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
                  'OTP Verification',
                  style: h2.copyWith(fontWeight: FontWeight.w700),
                ),
                sh12,
                Text(
                  'Enter 6-digit Code',
                  style: h4,
                ),
                sh8,
                Text(
                  'Your code was sent to your given email',
                  style: h5.copyWith(color: AppColors.grey),
                ),
                const SizedBox(height: 30),
                PinCodeTextField(
                  length: 6,
                  obscureText: false,
                  keyboardType: TextInputType.number,
                  animationType: AnimationType.fade,
                  pinTheme: PinTheme(
                    shape: PinCodeFieldShape.underline,
                    borderRadius: BorderRadius.circular(8),
                    fieldHeight: 60,
                    fieldWidth: 50,
                    // Reduce the width slightly for the gap
                    activeColor: AppColors.white,
                    activeFillColor: AppColors.white,
                    inactiveColor: AppColors.borderColor,
                    inactiveFillColor: AppColors.white,
                    selectedColor: AppColors.blue,
                    selectedFillColor: AppColors.white,
                  ),
                  animationDuration: const Duration(milliseconds: 300),
                  backgroundColor: AppColors.transparent,
                  cursorColor: AppColors.blue,
                  enablePinAutofill: true,
                  enableActiveFill: true,
                  onCompleted: (v) {},
                  onChanged: (value) {},
                  beforeTextPaste: (text) {
                    log("Allowing to paste $text");
                    return true;
                  },
                  appContext: context,
                ),
                sh20,
                Row(
                  children: [
                    Text(
                      'Resent Code',
                      style: h5,
                    ),
                    sw5,
                    Text(
                      '59s',
                      style: h4.copyWith(color: Colors.cyan),
                    )
                  ],
                ),
                sh30,
                CustomButton(
                  text: 'Verify',
                  onPressed: () {
                    Get.to(() => const SetNewPasswordView());
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
