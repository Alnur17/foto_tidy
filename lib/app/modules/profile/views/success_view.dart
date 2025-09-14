import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:foto_tidy/app/modules/dashboard/views/dashboard_view.dart';

import 'package:get/get.dart';

import '../../../../common/app_color/app_colors.dart';
import '../../../../common/app_images/app_images.dart';
import '../../../../common/app_text_style/styles.dart';
import '../../../../common/size_box/custom_sizebox.dart';
import '../../../../common/widgets/custom_background_color.dart';
import '../../../../common/widgets/custom_button.dart';

class SuccessView extends GetView {
  const SuccessView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.transparent,
      body: CustomBackgroundColor(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                AppImages.verifySuccess,
                scale: 4,
              ),
              sh16,
              Text(
                'Success',
                style: h2,
              ),
              sh20,
              CustomButton(
                text: 'Back to Home',
                onPressed: () {
                  Get.offAll(()=> DashboardView());
                },
                borderColor: AppColors.orange,
                textStyle: h3.copyWith(color: AppColors.orange),
                //gradientColors: AppColors.buttonColor,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
