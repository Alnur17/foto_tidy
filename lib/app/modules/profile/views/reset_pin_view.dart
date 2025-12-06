import 'package:flutter/material.dart';
import 'package:foto_tidy/common/widgets/custom_loader.dart';

import 'package:get/get.dart';

import '../../../../common/app_color/app_colors.dart';
import '../../../../common/app_images/app_images.dart';
import '../../../../common/app_text_style/styles.dart';
import '../../../../common/size_box/custom_sizebox.dart';
import '../../../../common/widgets/custom_background_color.dart';
import '../../../../common/widgets/custom_button.dart';
import '../../../../common/widgets/custom_textfield.dart';
import '../controllers/gallery_lock_controller.dart';

class ResetPinView extends StatefulWidget {
  const ResetPinView({super.key});

  @override
  State<ResetPinView> createState() => _ResetPinViewState();
}

class _ResetPinViewState extends State<ResetPinView> {
  final galleryLockController = Get.find<GalleryLockController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomBackgroundColor(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                sh60,
                GestureDetector(
                    onTap: () {
                      Get.back();
                    },
                    child: Image.asset(
                      AppImages.back,
                      scale: 4,
                    )),
                sh12,
                Center(
                    child: Image.asset(
                  AppImages.changePassPro,
                  scale: 4,
                )),
                sh16,
                Text(
                  'Old Pin',
                  style: h4,
                ),
                sh12,
                Obx(
                  () => CustomTextField(
                    controller: galleryLockController.oldPinTEController,
                    hintText: '**********',
                    sufIcon: GestureDetector(
                      onTap: () => galleryLockController
                          .toggleOldPinPasswordVisibility(),
                      child: Image.asset(
                        galleryLockController.isOldPinPasswordVisible.value
                            ? AppImages.eyeOpen
                            : AppImages.eyeClose,
                        scale: 4,
                      ),
                    ),
                    obscureText:
                        !galleryLockController.isOldPinPasswordVisible.value,
                  ),
                ),
                sh16,
                Text(
                  'New Pin',
                  style: h4,
                ),
                sh12,
                Obx(
                  () => CustomTextField(
                    controller: galleryLockController.newPinTEController,
                    sufIcon: GestureDetector(
                      onTap: () => galleryLockController
                          .toggleNewPinPasswordVisibility(),
                      child: Image.asset(
                        galleryLockController.isNewPinPasswordVisible.value
                            ? AppImages.eyeOpen
                            : AppImages.eyeClose,
                        scale: 4,
                      ),
                    ),
                    obscureText:
                        !galleryLockController.isNewPinPasswordVisible.value,
                    hintText: '**********',
                  ),
                ),
                sh16,
                Obx(
                  () => galleryLockController.isLoading.value
                      ? CustomLoader(color: AppColors.white)
                      : CustomButton(
                          text: 'Save changes',
                          onPressed: () {
                            galleryLockController.changeGalleryLockKey(context);
                          },
                          imageAssetPath: AppImages.arrowRightNormal,
                          gradientColors: AppColors.buttonColor,
                        ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
