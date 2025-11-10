import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../common/app_color/app_colors.dart';
import '../../../../../common/app_constant/app_constant.dart';
import '../../../../../common/helper/local_store.dart';
import '../../../../../common/widgets/custom_snackbar.dart';
import '../../../../data/api.dart';
import '../../../../data/base_client.dart';
import '../../../dashboard/views/dashboard_view.dart';

class LoginController extends GetxController {
  var isLoading = false.obs;

  var isPasswordVisible = false.obs;
  var isCheckboxVisible = false.obs;

  // Method to toggle password visibility
  void togglePasswordVisibility() {
    isPasswordVisible.toggle();
  }

  void toggleCheckboxVisibility() {
    isCheckboxVisible.toggle();
  }

  Future userLogin({
    required String email,
    required String password,
  }) async {
    try {
      isLoading(true);
      var map = {
        "email": email.toLowerCase().trim(),
        "password": password,
      };

      var headers = {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
      };

      dynamic responseBody = await BaseClient.handleResponse(
        await BaseClient.postRequest(
            api: Api.login, body: jsonEncode(map), headers: headers),
      );
      if (responseBody != null) {
        String message = responseBody['message'].toString();

        bool success = responseBody['success'];
        String accessToken = responseBody['data']['accessToken'].toString();

        LocalStorage.saveData(key: AppConstant.accessToken, data: accessToken);

        kSnackBar(message: message, bgColor: AppColors.green);

        if (success == true) {
          Get.offAll(() => DashboardView());
        } else {
          kSnackBar(message: message, bgColor: AppColors.red);
        }
        isLoading(false);
      }
    } catch (e) {
      debugPrint("Catch Error:::::: $e");
      kSnackBar(message: 'Invalid email or password.', bgColor: AppColors.red);
    } finally {
      isLoading(false);
    }
  }
}
