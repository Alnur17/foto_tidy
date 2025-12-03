import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../common/app_color/app_colors.dart';
import '../../../../../common/app_constant/app_constant.dart';
import '../../../../../common/helper/local_store.dart';
import '../../../../data/api.dart';
import '../../../../data/base_client.dart';
import '../../forgot_password/views/verify_otp_view.dart';

class SignUpController extends GetxController {
  var isLoading = false.obs;
  var isPasswordVisible = false.obs;
  var isConfirmPasswordVisible = false.obs;

  final TextEditingController nameTEController = TextEditingController();
  final TextEditingController emailTEController = TextEditingController();
  final TextEditingController passwordTEController = TextEditingController();
  final TextEditingController confirmPassTEController = TextEditingController();

  void togglePasswordVisibility() => isPasswordVisible.toggle();

  void toggleConfirmPasswordVisibility() => isConfirmPasswordVisible.toggle();

  Future<void> registerUser() async {
    try {
      isLoading(true);

      // Validate password length
      if (passwordTEController.text.trim().length < 6) {
        ScaffoldMessenger.of(Get.context!).showSnackBar(
          SnackBar(
            content: Text('Password must be at least 6 characters'),
            backgroundColor: AppColors.orange,
          ),
        );
        return;
      }

      // Check if passwords match
      if (passwordTEController.text.trim() !=
          confirmPassTEController.text.trim()) {
        ScaffoldMessenger.of(Get.context!).showSnackBar(
          SnackBar(
            content: Text('Passwords do not match'),
            backgroundColor: AppColors.orange,
          ),
        );
        return;
      }

      final body = {
        "name": nameTEController.text.trim(),
        "email": emailTEController.text.trim(),
        "password": passwordTEController.text.trim(),
      };

      final header = {
        "Content-Type": "application/json",
      };

      final response = await BaseClient.postRequest(
        api: Api.register,
        body: jsonEncode(body),
        headers: header,
      );

      final data = await BaseClient.handleResponse(response);
      debugPrint('Response data: $data');

      if (data != null && data['success'] == true) {
        String otpToken = data['data']['otpToken']['token']?.toString() ?? '';

        // Save OTP token using LocalStorage
        LocalStorage.saveData(key: AppConstant.otpToken, data: otpToken);
        Get.to(
              () => VerifyOtpView(
            isSignupVerify: true,
            email: emailTEController.text.trim(),
          ),
        );
      } else {
        ScaffoldMessenger.of(Get.context!).showSnackBar(
          SnackBar(
            content: Text(data?['message'] ?? 'Failed to signup'),
            backgroundColor: AppColors.red,
          ),
        );
      }
    } catch (e) {
      // Log the error and display the error message
      debugPrint("Signup error: $e");
      ScaffoldMessenger.of(Get.context!).showSnackBar(
        SnackBar(
          content: Text('An error occurred during signup: $e'),
          backgroundColor: AppColors.red,
        ),
      );
    } finally {
      isLoading(false);
    }
  }
}
