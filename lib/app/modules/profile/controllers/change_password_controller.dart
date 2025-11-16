import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../common/app_color/app_colors.dart';
import '../../../../common/app_constant/app_constant.dart';
import '../../../../common/helper/local_store.dart';
import '../../../data/api.dart';
import '../../../data/base_client.dart';
import '../../auth/login/views/login_view.dart';

class ChangePasswordController extends GetxController {
  var isLoading = false.obs;
  var isCurrentPasswordVisible = false.obs;
  var isNewPasswordVisible = false.obs;

  final TextEditingController currentPassTEController = TextEditingController();
  final TextEditingController newPassTEController = TextEditingController();
  final TextEditingController confirmPassTEController = TextEditingController();

  void toggleCurrentPasswordVisibility() {
    isCurrentPasswordVisible.toggle();
  }

  void toggleNewPasswordVisibility() {
    isNewPasswordVisible.toggle();
  }

  ///change password
  Future changePassword({
    required BuildContext context,
  }) async {
    // if (newPassTEController.text.trim() !=
    //     confirmPassTEController.text.trim()) {
    //   kSnackBar(
    //       message: 'New Password & Confirm password not match',
    //       bgColor: AppColors.orange);
    //   return;
    // }
    if (currentPassTEController.text.trim().isEmpty ||
        currentPassTEController.text.length < 6) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Current Password must be at least 6 characters"),
          backgroundColor: AppColors.orange,
        ),
      );
      return;
    }

    if (newPassTEController.text.trim().isEmpty ||
        newPassTEController.text.length < 6) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("New Password must be at least 6 characters"),
          backgroundColor: AppColors.orange,
        ),
      );

      return;
    }

    // if (confirmPassTEController.text.trim().isEmpty ||
    //     confirmPassTEController.text.length < 6) {
    //   kSnackBar(
    //       message: 'Confirm Password must be at least 6 characters',
    //       bgColor: AppColors.orange);
    //   return;
    // }

    try {
      debugPrint("Change Password");
      final token =
          LocalStorage.getData(key: AppConstant.accessToken)?.toString() ?? "";
      isLoading(true);
      var map = {
        "oldPassword": currentPassTEController.text.trim(),
        "newPassword": newPassTEController.text.trim(),
      };

      var headers = {
        'Content-Type': 'application/json',
        'Authorization': token,
      };

      dynamic responseBody = await BaseClient.handleResponse(
        await BaseClient.postRequest(
          api: Api.changePassword,
          body: jsonEncode(map),
          headers: headers,
        ),
      );

      if (responseBody["success"] == true) {
        LocalStorage.removeData(key: AppConstant.accessToken);
        Get.offAll(() => LoginView());
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(responseBody["message"]),
            backgroundColor: AppColors.orange,
          ),
        );
      }
    } catch (e) {
      debugPrint("Catch Error:::::: $e");
    } finally {
      isLoading(false);
    }
  }
}
