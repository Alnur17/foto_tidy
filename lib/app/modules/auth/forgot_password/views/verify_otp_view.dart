import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import '../../../../../common/app_color/app_colors.dart';
import '../../../../../common/app_images/app_images.dart';
import '../../../../../common/app_text_style/styles.dart';
import '../../../../../common/size_box/custom_sizebox.dart';
import '../../../../../common/widgets/custom_background_color.dart';
import '../../../../../common/widgets/custom_button.dart';
import '../../../../../common/widgets/custom_loader.dart';
import '../controllers/forgot_password_controller.dart';

class VerifyOtpView extends StatefulWidget {
  final bool isSignupVerify;
  final String email;

  const VerifyOtpView({
    super.key,
    required this.isSignupVerify,
    required this.email,
  });

  @override
  State<VerifyOtpView> createState() => _VerifyOtpViewState();
}

class _VerifyOtpViewState extends State<VerifyOtpView> {
  final forgotPassController = Get.put(ForgotPasswordController());

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
                  controller: forgotPassController.otpTEController,
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
                Obx(() {
                  return forgotPassController.isResendLoading.value == true
                      ? CircularProgressIndicator(
                          color: AppColors.blueTurquoise,
                        )
                      : forgotPassController.countdown.value > 0
                          ? Text(
                              'Resend code in ${forgotPassController.countdown.value}s',
                              style: h3,
                            )
                          : GestureDetector(
                              onTap: forgotPassController.countdown.value == 0
                                  ? () {
                                      forgotPassController.reSendOtp();
                                    }
                                  : null,
                              child: Text(
                                'Resend code',
                                style:
                                    h3.copyWith(color: AppColors.blueTurquoise),
                              ),
                            );
                }),
                sh30,
                Obx(() {
                  return forgotPassController.isLoading.value == true
                      ? CustomLoader(color: AppColors.white)
                      : CustomButton(
                          text: 'Verify',
                          onPressed: () {
                            forgotPassController.verifyOtp(isSignupVerify: widget.isSignupVerify);
                          },
                          imageAssetPath: AppImages.arrowRightNormal,
                          gradientColors: AppColors.buttonColor,
                        );
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
