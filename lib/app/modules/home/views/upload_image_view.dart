import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';

import '../../../../common/app_color/app_colors.dart';
import '../../../../common/app_text_style/styles.dart';
import '../../../../common/size_box/custom_sizebox.dart';
import '../../../../common/widgets/custom_button.dart';
import '../../../../common/widgets/custom_loader.dart';
import '../controllers/home_controller.dart';

class UploadImageView extends StatelessWidget {
  final String imagePath;

  const UploadImageView({super.key, required this.imagePath});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<HomeController>();
    return Scaffold(
      backgroundColor: AppColors.mainColor,
      appBar: AppBar(
        title: Text(
          'Upload Image',
          style: appBarStyle,
        ),
        backgroundColor: AppColors.white,
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Image.file(
            File(imagePath),
            fit: BoxFit.contain,
            //height: Get.height * 0.8.h,
            width: Get.width,
            errorBuilder: (context, error, stackTrace) => const Center(
              child: Text('Failed to load image'),
            ),
          ),
          sh20,
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Obx(
              () => controller.isLoading.value
                  ? CustomLoader(color: AppColors.white)
                  : CustomButton(
                      text: 'Next',
                      onPressed: () async {
                        controller.uploadSinglePhoto(
                            imagePath: imagePath, context: context);
                      },
                      gradientColors: AppColors.buttonColor,
                      borderRadius: 12,
                      height: 40,
                    ),
            ),
          ),
        ],
      ),
    );
  }
}
