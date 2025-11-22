import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../common/app_color/app_colors.dart';
import '../../../../../common/app_images/app_images.dart';
import '../../../../../common/app_text_style/styles.dart';
import '../../../../../common/widgets/custom_circular_container.dart';
import 'package:foto_tidy/common/helper/notification_card.dart';

import '../controllers/notifications_controller.dart';

class NotificationsView extends StatelessWidget {
  const NotificationsView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(NotificationsController());

    // Fetch on screen open
    Future.microtask(() => controller.fetchNotifications(context));

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        elevation: 0,
        title: Text("Notifications", style: h2),
        centerTitle: true,
        leading: Padding(
          padding: const EdgeInsets.only(left: 12),
          child: CustomCircularContainer(
            imagePath: AppImages.back,
            onTap: () => Get.back(),
            padding: 2,
          ),
        ),
      ),

      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        if (controller.notificationsList.isEmpty) {
          return const Center(
            child: Text(
              "No Notifications Found",
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
          );
        }

        return ListView.builder(
          padding: const EdgeInsets.symmetric(vertical: 16),
          itemCount: controller.notificationsList.length,
          itemBuilder: (context, index) {
            final item = controller.notificationsList[index];

            return NotificationCard(
              title: item.message ?? "No Title",
              subtitle: item.description ?? "",
              iconPath: AppImages.notificationTwo,
            );
          },
        );
      }),
    );
  }
}
