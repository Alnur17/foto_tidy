import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:foto_tidy/common/widgets/custom_loader.dart';

import 'package:get/get.dart';

import '../../../../common/app_color/app_colors.dart';
import '../../../../common/app_images/app_images.dart';
import '../../../../common/app_text_style/styles.dart';
import '../../../../common/size_box/custom_sizebox.dart';
import '../../../../common/widgets/custom_button.dart';
import '../../../../common/widgets/custom_circular_container.dart';
import '../../../../common/widgets/custom_textfield.dart';
import '../controllers/gallery_lock_controller.dart';

class CreateLockView extends StatefulWidget {
  const CreateLockView({super.key});

  @override
  State<CreateLockView> createState() => _CreateLockViewState();
}

class _CreateLockViewState extends State<CreateLockView> {
  final galleryLockController = Get.find<GalleryLockController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.mainColor,
      appBar: AppBar(
        backgroundColor: AppColors.mainColor,
        title: Text(
          'Create Pin',
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
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            sh60,
            Center(
              child: Image.asset(
                AppImages.changePassPro,
                scale: 4,
              ),
            ),
            sh12,
            Align(
              alignment: Alignment.center,
              child: Text(
                'Please enter your 4-digit PIN to continue',
                style: h5,
              ),
            ),
            sh12,
            Text(
              'Pin',
              style: h3,
            ),
            sh8,
            Obx(
              () => CustomTextField(
                controller: galleryLockController.setPinTEController,
                borderRadius: 12,
                hintText: '*********',
                sufIcon: GestureDetector(
                  onTap: () => galleryLockController.togglePinPasswordVisibility(),
                  child: Image.asset(
                    galleryLockController.isPinPasswordVisible.value
                        ? AppImages.eyeOpen
                        : AppImages.eyeClose,
                    scale: 4,
                  ),
                ),
                obscureText: !galleryLockController.isPinPasswordVisible.value,
              ),
            ),
            sh30,
            Obx(
              () => galleryLockController.isLoading.value
                  ? CustomLoader(color: AppColors.white)
                  : CustomButton(
                      borderRadius: 12,
                      text: 'Submit',
                      onPressed: () {
                        galleryLockController.setGalleryLockKey(
                            galleryLockController.setPinTEController.text,
                            context);
                      },
                      gradientColors: AppColors.buttonColor,
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
