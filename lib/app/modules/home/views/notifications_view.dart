import 'package:flutter/material.dart';
import 'package:foto_tidy/common/helper/notification_card.dart';

import 'package:get/get.dart';

import '../../../../../common/app_color/app_colors.dart';
import '../../../../../common/app_images/app_images.dart';
import '../../../../../common/app_text_style/styles.dart';
import '../../../../../common/widgets/custom_circular_container.dart';

class NotificationsView extends GetView {
  const NotificationsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        scrolledUnderElevation: 0,
        elevation: 0,
        title: Text(
          'Notifications',
          style: h2,
        ),
        centerTitle: true,
        leading: Padding(
          padding: const EdgeInsets.only(left: 12),
          child: CustomCircularContainer(
            imagePath: AppImages.back,
            onTap: () {
              Get.back();
            },
            padding: 2,
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.only(top: 16,bottom: 16),
              itemCount: 30,
              itemBuilder: (context, index) {
                return NotificationCard(
                  title: "Subscription Confirmed",
                  subtitle: "Your subscription has been confirmed",
                  iconPath: AppImages.notificationTwo,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}