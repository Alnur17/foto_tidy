import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:foto_tidy/common/app_color/app_colors.dart';
import 'package:foto_tidy/common/app_images/app_images.dart';
import 'package:foto_tidy/common/widgets/custom_button.dart';

import 'package:get/get.dart';

import '../../../../common/app_text_style/styles.dart';
import '../../../../common/size_box/custom_sizebox.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        title: Image.asset(
          AppImages.logo,
          scale: 4,
          height: 44.h,
          width: 78.w,
        ),
        actions: [
          GestureDetector(
            onTap: () {},
            child: CircleAvatar(
              radius: 20,
              backgroundImage:
                  CachedNetworkImageProvider(AppImages.profileImage),
            ),
          ),
          sw20,
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          sh20,
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Organize Your Photos',
                  style: h2,
                ),
                sh10,
                Text(
                  'Take or browse photos to get started',
                  style: h4,
                ),
                sh16,
                CustomButton(
                  text: 'Take Photo',
                  onPressed: () {},
                  gradientColors: AppColors.buttonColor,
                  borderRadius: 12,
                ),
                sh12,
                CustomButton(
                  text: 'Browse Photos',
                  onPressed: () {},
                  borderColor: AppColors.borderColor,
                  borderRadius: 12,
                  textColor: AppColors.black,
                ),
              ],
            ),
          ),
          sh20,
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Gallery',
                  style: h3,
                ),
                GestureDetector(
                  onTap: () {},
                  child: Text(
                    'View All',
                    style: h5.copyWith(color: AppColors.blue),
                  ),
                )
              ],
            ),
          ),
          sh12,
        ],
      ),
    );
  }
}
