import 'package:flutter/material.dart';
import 'package:foto_tidy/app/modules/home/model/notifications_model.dart';
import 'package:get/get.dart';

import '../../../../common/app_color/app_colors.dart';
import '../../../../common/app_constant/app_constant.dart';
import '../../../../common/helper/local_store.dart';
import '../../../data/api.dart';
import '../../../data/base_client.dart';

class NotificationsController extends GetxController {
  var isLoading = false.obs;
  var notificationsList = <NotificationDatum>[].obs;

  Future<void> fetchNotifications(context) async {
    try {
      isLoading(true);
      String accessToken =
          LocalStorage.getData(key: AppConstant.accessToken)?.toString() ?? "";
      if (accessToken.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("User not authenticated"),
            backgroundColor: AppColors.green,
          ),
        );

        return;
      }
      var response = await BaseClient.getRequest(
        api: Api.notification,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': accessToken,
        },
      );

      var data = await BaseClient.handleResponse(response);
      if (data != null && data['success'] == true) {
        var model = NotificationsModel.fromJson(data);
        notificationsList.value = model.data;
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(data['message'] ?? 'Failed to load notifications'),
            backgroundColor: AppColors.red,
          ),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('$e'),
          backgroundColor: AppColors.orange,
        ),
      );
    } finally {
      isLoading(false);
    }
  }

}
