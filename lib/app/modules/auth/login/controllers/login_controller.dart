import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../common/app_color/app_colors.dart';
import '../../../../../common/app_constant/app_constant.dart';
import '../../../../../common/helper/local_store.dart';
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
        String message = responseBody['message'] ?? "Unknown error";
        bool success = responseBody['success'] ?? false;

        if (success) {
          // Only read token if success == true
          String accessToken =
              responseBody['data']?['accessToken'] ?? "";

          LocalStorage.saveData(
              key: AppConstant.accessToken,
              data: accessToken
          );

          ScaffoldMessenger.of(Get.context!).showSnackBar(
            SnackBar(
              content: Text(message),
              backgroundColor: AppColors.green,
            ),
          );

          Get.offAll(() => DashboardView());
        } else {
          // Show API error message
          ScaffoldMessenger.of(Get.context!).showSnackBar(
            SnackBar(
              content: Text(message),
              backgroundColor: AppColors.red,
            ),
          );
        }
      }

  //   } catch (e) {
  //     debugPrint("Catch Error:::::: $e");
  //
  //     // Try to extract message from error JSON if possible
  //     try {
  //       var err = jsonDecode(e.toString());
  //       String apiMessage = err['message'] ?? e.toString();
  //
  //       ScaffoldMessenger.of(Get.context!).showSnackBar(
  //         SnackBar(
  //           content: Text(apiMessage),
  //           backgroundColor: AppColors.red,
  //         ),
  //       );
  //     } catch (_) {
  //       // fallback
  //       ScaffoldMessenger.of(Get.context!).showSnackBar(
  //         SnackBar(
  //           content: Text(e.toString()),
  //           backgroundColor: AppColors.red,
  //         ),
  //       );
  //     }
  //   } finally {
  //     isLoading(false);
  //   }
  // }

  // Future userLogin({
  //   required String email,
  //   required String password,
  // }) async
  // {
  //   try {
  //     isLoading(true);
  //     var map = {
  //       "email": email.toLowerCase().trim(),
  //       "password": password,
  //     };
  //
  //     var headers = {
  //       'Accept': 'application/json',
  //       'Content-Type': 'application/json',
  //     };
  //
  //     dynamic responseBody = await BaseClient.handleResponse(
  //       await BaseClient.postRequest(
  //           api: Api.login, body: jsonEncode(map), headers: headers),
  //     );
  //     if (responseBody != null) {
  //       String message = responseBody['message'].toString();
  //
  //       bool success = responseBody['success'];
  //       String accessToken = responseBody['data']['accessToken'].toString();
  //
  //       LocalStorage.saveData(key: AppConstant.accessToken, data: accessToken);
  //       ScaffoldMessenger.of(Get.context!).showSnackBar(
  //         SnackBar(
  //           content: Text(message),
  //           backgroundColor: AppColors.green,
  //         ),
  //       );
  //
  //       if (success == true) {
  //         Get.offAll(() => DashboardView());
  //       } else {
  //         ScaffoldMessenger.of(Get.context!).showSnackBar(
  //           SnackBar(
  //             content: Text(message),
  //             backgroundColor: AppColors.red,
  //           ),
  //         );
  //       }
  //       isLoading(false);
  //     }
    } catch (e) {
      debugPrint("Catch Error:::::: $e");
      ScaffoldMessenger.of(Get.context!).showSnackBar(
        SnackBar(
          content: Text("$e"),
          backgroundColor: AppColors.red,
        ),
      );
    } finally {
      isLoading(false);
    }
  }
}
