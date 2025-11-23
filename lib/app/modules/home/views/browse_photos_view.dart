import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:foto_tidy/app/modules/profile/views/subscription_view.dart';
import 'package:foto_tidy/common/app_color/app_colors.dart';
import 'package:foto_tidy/common/app_images/app_images.dart';
import 'package:foto_tidy/common/widgets/custom_button.dart';
import 'package:foto_tidy/common/widgets/custom_loader.dart';
import 'package:get/get.dart';
import '../../../../common/app_text_style/styles.dart';
import '../../../../common/size_box/custom_sizebox.dart';
import '../controllers/home_controller.dart';

class BrowsePhotosView extends StatefulWidget {
  const BrowsePhotosView({super.key});

  @override
  State<BrowsePhotosView> createState() => _BrowsePhotosViewState();
}

class _BrowsePhotosViewState extends State<BrowsePhotosView> {
  // Initialize the HomeController
  final HomeController homeController = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        scrolledUnderElevation: 0,
        title: Text('Browse Photos'),
      ),
      body: Padding(
        padding: EdgeInsets.all(20).r,
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Use Obx to reactively update the UI based on state changes
              Obx(() {
                if (homeController.selectedImages.isEmpty) {
                  return _buildInitialUploadView(homeController, context);
                } else if (homeController.selectedImages.length < 5) {
                  return _buildImageListView(homeController, context);
                } else {
                  return _buildLimitReachedView(homeController, context);
                }
              }),
            ],
          ),
        ),
      ),
    );
  }

  // Initial upload view when no images are selected
  Widget _buildInitialUploadView(
      HomeController homeController, BuildContext context) {
    return Container(
      width: Get.width.w,
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.borderColor),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
            AppImages.uploadImage,
            scale: 4,
          ),
          sh12,
          Text(
            "Upload your image",
            style: h3,
          ),
          sh12,
          Text(
            "Drag and drop or browse to choose a file",
            style: h5,
            textAlign: TextAlign.center,
          ),
          sh16,
          CustomButton(
            text: 'Chose File',
            onPressed: () {
              homeController.pickImages(context: context);
            },
            gradientColors: AppColors.buttonColor,
            borderRadius: 12,
          ),
          sh16,
          Text(
            'PNG, JPG up to 10MB',
            style: h5,
          ),
        ],
      ),
    );
  }

  // View showing the list of selected images and allowing removal
  Widget _buildImageListView(
      HomeController homeController, BuildContext context) {
    return Column(
      children: [
        _buildInitialUploadView(homeController, context),
        sh12,
        // List of selected images
        ...homeController.selectedImages.map((image) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 12).r,
            child: Container(
              width: Get.width.w,
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: AppColors.borderColor),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(image.name), // Display image name
                  GestureDetector(
                      onTap: () {
                        homeController.removeImage(image); // Remove the image
                      },
                      child: Image.asset(
                        AppImages.delete,
                        scale: 4,
                      )),
                ],
              ),
            ),
          );
        }).toList(),
        sh16,
        Obx(() => homeController.isLoading.value == true
            ? CustomLoader(color: AppColors.white)
            : CustomButton(
                text: 'Next',
                onPressed: () {
                  homeController.uploadMultiplePhoto(context: context);
                },
                gradientColors: AppColors.buttonColor,
                borderRadius: 12,
              )),
      ],
    );
  }

  // View when the image limit (5) is reached
  Widget _buildLimitReachedView(homeController, BuildContext context) {
    return Column(
      children: [
        homeController.isSubscribed.value == true
            ? _buildInitialUploadView(homeController, context)
            : Container(
                width: Get.width.w,
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: AppColors.borderColor),
                ),
                child: Column(
                  children: [
                    Image.asset(
                      AppImages.changePassPro,
                      scale: 4,
                    ),
                    sh16,
                    Text("Update Pro to Add More", style: h3),
                    sh12,
                    Text(
                      'Stay organized with unlimited photo uploads.',
                      style: h5.copyWith(color: AppColors.grey),
                      textAlign: TextAlign.center,
                    ),
                    sh8,
                    CustomButton(
                      text: 'Upgrade to Pro',
                      onPressed: () {
                        Get.to(() => SubscriptionView());
                      },
                      gradientColors: AppColors.buttonColor,
                      borderRadius: 12,
                    ),
                  ],
                ),
              ),
        sh20,
        Obx(
          () => homeController.isLoading.value == true
              ? CustomLoader(color: AppColors.white)
              : CustomButton(
                  text: 'Next',
                  onPressed: () {
                    homeController.uploadMultiplePhoto(context: context);
                  },
                  gradientColors: AppColors.buttonColor,
                  borderRadius: 12,
                ),
        ),

        sh20,
        // List of selected images
        ...homeController.selectedImages.map((image) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 12).r,
            child: Container(
              width: Get.width.w,
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: AppColors.borderColor),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(image.name), // Display image name
                  GestureDetector(
                      onTap: () {
                        homeController.removeImage(image); // Remove the image
                      },
                      child: Image.asset(
                        AppImages.delete,
                        scale: 4,
                      )),
                ],
              ),
            ),
          );
        }).toList(),
        // sh16,
      ],
    );
  }
}
