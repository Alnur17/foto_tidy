import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';

import '../../../../common/app_color/app_colors.dart';
import '../../../../common/app_images/app_images.dart';
import '../../../../common/app_text_style/styles.dart';
import '../../../../common/size_box/custom_sizebox.dart';
import '../../../../common/widgets/custom_button.dart';
import '../../dashboard/views/dashboard_view.dart';

class PhotoSavedSuccessfullyView extends StatelessWidget {
  //final String imagePath;

  //const PhotoSavedSuccessfullyView({super.key, required this.imagePath});
  const PhotoSavedSuccessfullyView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.mainColor,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              AppImages.success,
              scale: 4,
            ),
            sh20,
            Text(
              'Photo saved successfully!',
              style: h3,
            ),
            sh20,
            CustomButton(
              text: 'Back to Homepage',
              onPressed: () {
                Get.offAll(() => DashboardView());
              },
              borderColor: AppColors.orange,
              textColor: AppColors.orange,
            ),
          ],
        ),
      ),
    );
  }
}
