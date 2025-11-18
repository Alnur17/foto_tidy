import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:foto_tidy/app/modules/profile/controllers/profile_controller.dart';
import 'package:foto_tidy/app/modules/profile/views/create_lock_view.dart';
import 'package:foto_tidy/app/modules/profile/views/reset_pin_view.dart';
import 'package:foto_tidy/common/app_color/app_colors.dart';
import 'package:foto_tidy/common/app_images/app_images.dart';
import 'package:foto_tidy/common/app_text_style/styles.dart';
import 'package:foto_tidy/common/widgets/custom_button.dart';

import 'package:get/get.dart';

import '../../../../common/size_box/custom_sizebox.dart';
import '../../../../common/widgets/custom_circular_container.dart';
import '../../../../common/widgets/popup_helper.dart';

class GalleryLockView extends GetView {
  GalleryLockView({super.key});

  final ProfileController profileController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.mainColor,
      appBar: AppBar(
        backgroundColor: AppColors.mainColor,
        title: Text(
          'Gallery Lock',
          style: appBarStyle,
        ),
        leading: Padding(
          padding: EdgeInsets.only(left: 12.w),
          child: CustomCircularContainer(
            imagePath: AppImages.back,
            onTap: () {
              Get.back();
            },
            padding: 2,
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20).r,
        child: profileController.profileData.value?.data?.isGalleryLock == false
            ? Column(
                children: [
                  sh116,
                  Image.asset(
                    AppImages.changePassPro,
                    scale: 4,
                  ),
                  sh20,
                  Align(
                    alignment: Alignment.center,
                    child: Text(
                      'Create Lock (First-Time Setup)',
                      style: h3.copyWith(fontSize: 20.sp),
                    ),
                  ),
                  sh20,
                  CustomButton(
                    text: 'Create Lock (First-Time Setup)',
                    onPressed: () {
                      Get.to(()=> CreateLockView());
                    },
                    gradientColors: AppColors.buttonColor,
                    borderRadius: 12,
                  ),
                ],
              )
            : Column(
                children: [
                  sh116,
                  Image.asset(
                    AppImages.changePassPro,
                    scale: 4,
                  ),
                  sh20,
                  Align(
                    alignment: Alignment.center,
                    child: Text(
                      'Gallery lock',
                      style: h3.copyWith(fontSize: 20.sp),
                    ),
                  ),
                  sh20,
                  CustomButton(
                    text: 'Reset Lock',
                    centerImageWithText: true,
                    imageAssetPath: AppImages.lock,
                    onPressed: () {
                      Get.to(()=> ResetPinView());
                    },
                    gradientColors: AppColors.buttonColor,
                    borderRadius: 12,
                  ),
                  sh12,
                  CustomButton(
                    text: 'Delete',
                    centerImageWithText: true,
                    imageAssetPath: AppImages.delete,
                    onPressed: () {
                      PopupHelper.showConfirmationDialog(
                        title: "Remove Lock?",
                        description:
                            "Your device will no longer be protected with a lock",
                        confirmText: "Confirm",
                        icon: AppImages.logoutBig,
                        onConfirm: () {},
                      );
                    },
                    backgroundColor: Colors.red[50],
                    borderRadius: 12,
                    textColor: AppColors.red,
                  ),
                ],
              ),
      ),
    );
  }
}
