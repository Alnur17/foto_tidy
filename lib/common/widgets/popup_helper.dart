
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../app_color/app_colors.dart';
import '../app_text_style/styles.dart';
import '../size_box/custom_sizebox.dart';
import 'custom_button.dart';

class PopupHelper {
  static void showCustomPopup({
    required String title,
    required String description,
    required String iconPath,
    String primaryButtonText = "OK",
    VoidCallback? onPrimaryPressed,
    String? secondaryButtonText,
    VoidCallback? onSecondaryPressed,
  }) {
    Get.dialog(
      Dialog(
        backgroundColor: AppColors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(iconPath, scale: 4),
              sh16,
              Text(
                title,
                style: h2,
                textAlign: TextAlign.center,
              ),
              sh8,
              Text(
                description,
                textAlign: TextAlign.center,
                style: h4.copyWith(
                  fontWeight: FontWeight.w400,
                  color: AppColors.greyMedium,
                ),
              ),
              sh20,
              CustomButton(
                text: primaryButtonText,
                gradientColors: AppColors.buttonColor,
                borderRadius: 12,
                onPressed: () {
                  Get.back();
                  if (onPrimaryPressed != null) {
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      onPrimaryPressed();
                    });
                  }
                },
              ),

              if (secondaryButtonText != null) ...[
                sh12,
                CustomButton(
                  text: secondaryButtonText,
                  borderRadius: 12,
                  backgroundColor: AppColors.silver,
                  textColor: AppColors.black,
                  onPressed: () {
                    Get.back();
                    if (onSecondaryPressed != null) {
                      WidgetsBinding.instance.addPostFrameCallback((_) {
                        onSecondaryPressed();
                      });
                    }
                  },
                ),

              ],
            ],
          ),
        ),
      ),
    );
  }

  static void showConfirmationDialog({
    required String title,
    required String description,
    required String confirmText,
    required VoidCallback onConfirm,
    String cancelText = "Cancel",
    VoidCallback? onCancel,
    String? icon,
    Color confirmColor = AppColors.red,
    Color cancelColor = AppColors.silver,
  }) {
    Get.dialog(
      Dialog(
        backgroundColor: AppColors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        child: Padding(
          padding: EdgeInsets.all(20.w),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (icon != null) ...[
                Image.asset(
                  icon,
                  height: 60,
                  width: 60,
                ),
                sh16,
              ],
              Text(
                title,
                style: h2,
                textAlign: TextAlign.center,
              ),
              Text(
                description,
                textAlign: TextAlign.center,
                style: h3.copyWith(fontWeight: FontWeight.w500),
              ),
              sh20,
              CustomButton(
                text: confirmText,
                borderRadius: 12,
                backgroundColor: confirmColor,
                textColor: AppColors.white,
                onPressed: () {
                  Get.back();
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    onConfirm();
                  });
                },

              ),
              sh12,
              if (onCancel != null) ...[
                sh12,
                CustomButton(
                  text: cancelText,
                  borderRadius: 12,
                  backgroundColor: cancelColor,
                  textColor: AppColors.black,
                  onPressed: () {
                    Get.back();
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      onCancel();
                    });
                                    },

                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

}
