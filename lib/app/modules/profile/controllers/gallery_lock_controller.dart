import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:foto_tidy/app/modules/dashboard/views/dashboard_view.dart';
import 'package:get/get.dart';
import '../../../../common/app_color/app_colors.dart';
import '../../../../common/app_constant/app_constant.dart';
import '../../../../common/helper/local_store.dart';
import '../../../data/api.dart';
import '../../../data/base_client.dart';
import '../views/success_view.dart';

class GalleryLockController extends GetxController {
  var isLoading = false.obs;

  final TextEditingController setPinTEController = TextEditingController();
  final TextEditingController submitPinTEController = TextEditingController();
  final TextEditingController oldPinTEController = TextEditingController();
  final TextEditingController newPinTEController = TextEditingController();

  Future<void> setGalleryLockKey(String key, BuildContext context) async {
    try {
      isLoading(true);

      String accessToken =
          LocalStorage.getData(key: AppConstant.accessToken)?.toString() ?? "";

      if (accessToken.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("User not authenticated"),
            backgroundColor: AppColors.red,
          ),
        );
        return;
      }

      final body = {
        "key": key.trim(),
      };

      var headers = {
        "Accept": "application/json",
        "Authorization": accessToken,
      };

      var response = await BaseClient.postRequest(
        api: Api.setGalleryLock,
        body: body,
        headers: headers,
      );

      var data = await BaseClient.handleResponse(response);

      if (data != null && data["success"] == true) {
        Get.off(()=> SuccessView());
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(data["message"] ?? "Lock set successfully"),
            backgroundColor: AppColors.green,
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(data["message"] ?? "Failed to set lock"),
            backgroundColor: AppColors.red,
          ),
        );
      }
    } catch (e) {
      debugPrint("Error: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Something went wrong"),
          backgroundColor: AppColors.red,
        ),
      );
    } finally {
      isLoading(false);
    }
  }

  Future<void> unlockGalleryLockKey(String key, BuildContext context) async {
    try {
      isLoading(true);

      String accessToken =
          LocalStorage.getData(key: AppConstant.accessToken)?.toString() ?? "";

      if (accessToken.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("User not authenticated"),
            backgroundColor: AppColors.red,
          ),
        );
        return;
      }

      final body = {
        "key": key.trim(),
      };

      var headers = {
        "Accept": "application/json",
        "Authorization": accessToken,
      };

      var response = await BaseClient.postRequest(
        api: Api.unlockGallery,
        body: body,
        headers: headers,
      );

      var data = await BaseClient.handleResponse(response);

      if (data != null && data["success"] == true) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(data["message"] ?? "Unlock successfully"),
            backgroundColor: AppColors.green,
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(data["message"] ?? "Failed to unlock"),
            backgroundColor: AppColors.red,
          ),
        );
      }
    } catch (e) {
      debugPrint("Error: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Something went wrong"),
          backgroundColor: AppColors.red,
        ),
      );
    } finally {
      isLoading(false);
    }
  }

  // ============================
  // CHANGE EXISTING GALLERY LOCK
  // ============================
  Future<void> changeGalleryLockKey(BuildContext context) async {
    try {
      isLoading(true);

      String accessToken =
          LocalStorage.getData(key: AppConstant.accessToken)?.toString() ?? "";

      if (accessToken.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("User not authenticated"),
            backgroundColor: AppColors.red,
          ),
        );
        return;
      }

      final body = jsonEncode({
        "oldKey": oldPinTEController.text.trim(),
        "newKey": newPinTEController.text.trim(),
      });

      final headers = {
        "Content-Type": "application/json",
        "Authorization": accessToken,
      };

      var response = await BaseClient.postRequest(
        api: Api.changeGalleryLock,
        body: body,
        headers: headers,
      );

      var data = await BaseClient.handleResponse(response);

      if (data != null && data["success"] == true) {
        Get.off(() => SuccessView());
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(data["message"] ?? "PIN changed successfully"),
            backgroundColor: AppColors.green,
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(data["message"] ?? "Failed to change PIN"),
            backgroundColor: AppColors.red,
          ),
        );
      }
    } catch (e) {
      debugPrint("Error: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Something went wrong"),
          backgroundColor: AppColors.red,
        ),
      );
    } finally {
      isLoading(false);
    }
  }

  // ============================
  // DELETE EXISTING GALLERY LOCK
  // ===========================
  Future<void> deleteGalleryLockKey(BuildContext context) async {
    try {
      isLoading(true);

      String accessToken =
          LocalStorage.getData(key: AppConstant.accessToken)?.toString() ?? "";

      if (accessToken.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("User not authenticated"),
            backgroundColor: AppColors.red,
          ),
        );
        return;
      }

      final headers = {
        "Content-Type": "application/json",
        "Authorization": accessToken,
      };

      var response = await BaseClient.postRequest(
        api: Api.deleteGalleryLock,
        headers: headers,
      );

      var data = await BaseClient.handleResponse(response);

      if (data != null && data["success"] == true) {
        Get.off(() => DashboardView());
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(data["message"] ?? "PIN deleted successfully"),
            backgroundColor: AppColors.green,
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(data["message"] ?? "Failed to delete PIN"),
            backgroundColor: AppColors.red,
          ),
        );
      }
    } catch (e) {
      debugPrint("Error: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Something went wrong"),
          backgroundColor: AppColors.red,
        ),
      );
    } finally {
      isLoading(false);
    }
  }
}
