import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../common/app_color/app_colors.dart';
import '../../../../../common/app_constant/app_constant.dart';
import '../../../../../common/helper/local_store.dart';
import '../../../../../common/widgets/custom_snackbar.dart';
import '../../../../data/api.dart';
import '../../../../data/base_client.dart';
import '../../login/views/login_view.dart';
import '../views/reset_success_view.dart';
import '../views/set_new_password_view.dart';
import '../views/verify_otp_view.dart';

class ForgotPasswordController extends GetxController {
  var isLoading = false.obs;
  var isResendLoading = false.obs;
  var isPasswordVisible = false.obs;
  var isConfirmPasswordVisible = false.obs;

  Rx<int> countdown = 59.obs;

  final TextEditingController emailTEController = TextEditingController();
  final TextEditingController otpTEController = TextEditingController();
  final TextEditingController newPasswordTEController = TextEditingController();
  final TextEditingController confirmNewPasswordTEController =
  TextEditingController();

  Timer? timer;

  void togglePasswordVisibility() {
    isPasswordVisible.toggle();
  }

  void togglePasswordVisibility1() {
    isConfirmPasswordVisible.toggle();
  }

  @override
  void onInit() {
    super.onInit();
    startCountdown();
  }

  @override
  void onClose() {
    super.onClose();
    timer?.cancel(); // Cancel the timer when the controller is disposed
  }

  // Countdown timer logic
  void startCountdown() {
    timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (countdown.value > 0) {
        countdown.value--;
      } else {
        timer.cancel();
      }
    });
  }

  Future forgotPassword({
    required String email,
  }) async {
    try {
      isLoading(true);
      var map = <String, dynamic>{};
      map['email'] = email;

      var headers = {
        'Content-Type': 'application/json',
      };
      dynamic responseBody = await BaseClient.handleResponse(
        await BaseClient.postRequest(
          api: Api.forgotPassword,
          body: jsonEncode(map),
          headers: headers,
        ),
      );

      if (responseBody != null) {
        String message = responseBody['message'].toString();
        kSnackBar(message: message, bgColor: AppColors.green);

        String verifyToken = responseBody['data']['verifyToken'].toString();
        LocalStorage.saveData(key: AppConstant.verifyToken, data: verifyToken);

        if (Get.currentRoute != '/VerifyOtpView') {
          Get.to(() => VerifyOtpView(isSignupVerify: false, email: email));
        }
      } else {
        throw 'Forgot Password Failed!';
      }
    } catch (e) {
      debugPrint("Catch Error:::::: $e");
      kSnackBar(message: e.toString(), bgColor: AppColors.orange);
    } finally {
      isLoading(false);
    }
  }

  /// OTP verification
  Future verifyOtp({required bool isSignupVerify}) async {
    try {
      isLoading(true);

      // Retrieve OTP token and verify token
      String otpToken = LocalStorage.getData(key: AppConstant.otpToken).toString();
      String verifyToken = LocalStorage.getData(key: AppConstant.verifyToken).toString();
      debugPrint("Otp Token: $otpToken");
      debugPrint("Verify Token: $verifyToken");

      // Ensure OTP is not empty
      if (otpTEController.text.isEmpty) {
        Get.snackbar('Error', 'Please enter OTP');
        return;
      }

      final map = {
        'otp': otpTEController.text,
      };

      print('OTP Map: $map'); // For debugging

      final headers = {
        'Authorization': isSignupVerify == true ? otpToken : verifyToken,
        'Content-Type': 'application/json',
      };

      print("This is headers $headers");
      // Send the OTP to the server for verification
      dynamic responseBody = await BaseClient.handleResponse(
        await BaseClient.postRequest(
          api: Api.otpVerify,
          body: jsonEncode(map),
          headers: headers,
        ),
      );

      // Check if the response body is null
      if (responseBody == null) {
        throw 'No response from server';
      }

      // Log the response data for debugging
      debugPrint('OTP Verification Response: $responseBody');

      // Safely extract the message, provide a fallback if null
      final String message = responseBody['message']?.toString() ?? 'Unknown error';
      kSnackBar(message: message, bgColor: AppColors.green);

      // Ensure 'data' and 'accessToken' are available, and handle null values gracefully
      if (responseBody != null) {
        final String accessToken = responseBody['data']['accessToken'].toString();
        if (accessToken.isNotEmpty) {
          LocalStorage.saveData(key: AppConstant.accessToken, data: accessToken);

          // Navigate based on the signup verification flag
          Get.to(() => isSignupVerify ? const LoginView() : SetNewPasswordView());
          otpTEController.clear();
        } else {
          kSnackBar(message: 'Access token missing', bgColor: AppColors.orange);
        }
      } else {
        kSnackBar(message: 'Data or access token missing in response', bgColor: AppColors.orange);
      }

      isLoading(false);
    } catch (e) {
      // Log the error to console for debugging
      debugPrint("Error during OTP verification: $e");
      // Show an error message in a snackbar
      kSnackBar(message: 'Error: ${e.toString()}', bgColor: AppColors.orange);
    } finally {
      isLoading(false);
    }
  }

  /// Resend OTP
  Future reSendOtp() async {
    try {
      isResendLoading(true);
      var map = <String, dynamic>{};
      map['email'] = emailTEController.text.trim();

      var headers = {
        'Content-Type': 'application/json',
      };
      dynamic responseBody = await BaseClient.handleResponse(
        await BaseClient.postRequest(
            api: Api.reSendOtp, body: jsonEncode(map), headers: headers),
      );

      if (responseBody != null) {
        String message = responseBody['message'].toString();
        kSnackBar(message: message, bgColor: AppColors.green);

        String otpToken = responseBody['data']['token'].toString();
        LocalStorage.saveData(key: AppConstant.otpToken, data: otpToken);
      } else {
        throw 'Failed to resend OTP';
      }
    } catch (e) {
      debugPrint("Catch Error:::::: $e");
    } finally {
      isResendLoading(false);
    }
  }

  Future resetPass({required String email}) async {
    if (newPasswordTEController.text.trim() !=
        confirmNewPasswordTEController.text.trim()) {
      kSnackBar(message: 'Passwords do not match', bgColor: AppColors.orange);
      return;
    }
    try {
      isLoading(true);

      String accessToken = LocalStorage.getData(key: AppConstant.accessToken);

      var map = <String, dynamic>{};
      map['email'] = email;
      map['newPassword'] = newPasswordTEController.text.trim();
      map['confirmPassword'] = confirmNewPasswordTEController.text.trim();

      var headers = {
        'Authorization': accessToken,
        'Content-Type': 'application/json',
      };
      dynamic responseBody = await BaseClient.handleResponse(
        await BaseClient.postRequest(
          api: Api.resetPassword,
          body: jsonEncode(map),
          headers: headers,
        ),
      );

      if (responseBody != null) {
        String message = responseBody['message'].toString();
        kSnackBar(message: message, bgColor: AppColors.green);

        Get.offAll(() => ResetSuccessView());
      } else {
        throw 'Failed to reset password';
      }
    } catch (e) {
      debugPrint("Catch Error:::::: $e");
    } finally {
      isLoading(false);
    }
  }
}
