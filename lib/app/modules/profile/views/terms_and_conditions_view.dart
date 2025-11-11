import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';

import '../../../../../common/app_color/app_colors.dart';
import '../../../../../common/app_images/app_images.dart';
import '../../../../../common/app_text_style/styles.dart';
import '../controllers/settings_controller.dart';

class TermsAndConditionsView extends GetView {
  const TermsAndConditionsView({super.key});

  @override
  Widget build(BuildContext context) {
    final SettingsController settingsController =
    Get.put(SettingsController());
    return Scaffold(
      backgroundColor: AppColors.mainColor,
      appBar: AppBar(
        backgroundColor: AppColors.mainColor,
        scrolledUnderElevation: 0,
        title: Text(
          'Terms and Conditions',
          style: titleStyle,
        ),
        leading: GestureDetector(
          onTap: () {
            Get.back();
          },
          child: Image.asset(
            AppImages.back,
            scale: 4,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20).r,
        child: Obx(() {
          if (settingsController.isLoading.value) {
            return Center(
                child: CircularProgressIndicator(
                  color: AppColors.orange,
                ));
          } else if (settingsController.errorMessage.isNotEmpty) {
            return Center(
              child: Text(
                settingsController.errorMessage.value,
                style: h4.copyWith(fontSize: 14, color: AppColors.red),
              ),
            );
          } else {
            return SingleChildScrollView(
              child: Html(
                data: settingsController.getTermsConditions.value,
                style: {
                  "*": Style(
                    backgroundColor: AppColors.mainColor,
                  ),
                },
              ),
            );
          }
        }),
      ),
    );
  }
}