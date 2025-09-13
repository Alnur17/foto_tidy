// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:get/get.dart';
//
// import '../../../../common/app_color/app_colors.dart';
// import '../../../../common/app_text_style/styles.dart';
// import '../../../../common/app_images/app_images.dart';
// import '../../../../common/helper/custom_filter_chip.dart';
// import '../../../../common/helper/gallery_item.dart';
// import '../../../../common/size_box/custom_sizebox.dart';
// import '../../../../common/widgets/custom_button.dart';
// import '../controllers/gallery_controller.dart';
//
// class GalleryView extends StatefulWidget {
//   const GalleryView({super.key});
//
//   @override
//   State<GalleryView> createState() => _GalleryViewState();
// }
//
// class _GalleryViewState extends State<GalleryView> {
//   final galleryController = Get.put(GalleryController());
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: AppColors.background,
//       appBar: AppBar(
//         elevation: 0,
//         backgroundColor: AppColors.background,
//         title: Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             Text('Gallery', style: appBarStyle),
//             CustomButton(
//               text: 'Filter Photos',
//               onPressed: () {},
//               backgroundColor: AppColors.white,
//               borderRadius: 8,
//               borderColor: AppColors.borderColor,
//               width: 125.w,
//               height: 30.h,
//               textStyle: h5,
//               padding: EdgeInsets.symmetric(horizontal: 8),
//               imageAssetPath: AppImages.filter,
//             ),
//           ],
//         ),
//       ),
//       body: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           sh8,
//           // Filter Chips
//           SizedBox(
//             height: 35.h,
//             child: ListView.builder(
//               scrollDirection: Axis.horizontal,
//               padding: EdgeInsets.symmetric(horizontal: 20.w),
//               itemCount: galleryController.categories.length,
//               itemBuilder: (context, index) {
//                 final category = galleryController.categories[index];
//                 return Obx(() => CustomFilterChip(
//                   text: category,
//                   isSelected: galleryController.selectedCategory.value == category,
//                   onTap: () => galleryController.selectCategory(category),
//                 ));
//               },
//             ),
//           ),
//           sh12,
//           // Storage Info
//           Padding(
//             padding: EdgeInsets.symmetric(horizontal: 20.w),
//             child: Text(
//               "Storage Used: 420 MB / 500 MB",
//               style:
//                   h5.copyWith(color: Colors.red, fontWeight: FontWeight.w500),
//             ),
//           ),
//           sh12,
//           // Gallery Grid
//           Expanded(
//             child: GridView.builder(
//               padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 8.h),
//               gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                 crossAxisCount: 2,
//                 crossAxisSpacing: 10.w,
//                 mainAxisSpacing: 10.h,
//                 childAspectRatio: 0.9,
//               ),
//               itemCount: galleryController.galleryImages.length,
//               itemBuilder: (context, index) {
//                 return GalleryItem(
//                     imageUrl: galleryController.galleryImages[index]);
//               },
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../../../../common/app_color/app_colors.dart';
import '../../../../common/app_text_style/styles.dart';
import '../../../../common/app_images/app_images.dart';
import '../../../../common/helper/custom_filter_chip.dart';
import '../../../../common/helper/gallery_item.dart';
import '../../../../common/size_box/custom_sizebox.dart';
import '../../../../common/widgets/custom_button.dart';
import '../controllers/gallery_controller.dart';

class GalleryView extends StatefulWidget {
  const GalleryView({super.key});

  @override
  State<GalleryView> createState() => _GalleryViewState();
}

class _GalleryViewState extends State<GalleryView> {
  final galleryController = Get.put(GalleryController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppColors.background,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Gallery', style: appBarStyle),
            CustomButton(
              text: 'Filter Photos',
              onPressed: () {},
              backgroundColor: AppColors.white,
              borderRadius: 8,
              borderColor: AppColors.borderColor,
              width: 125.w,
              height: 30.h,
              textStyle: h5,
              padding: EdgeInsets.symmetric(horizontal: 8),
              imageAssetPath: AppImages.filter,
            ),
          ],
        ),
      ),
      body: Obx(() {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            sh8,
            // Filter Chips
            SizedBox(
              height: 35.h,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                itemCount: galleryController.categories.length,
                itemBuilder: (context, index) {
                  final category = galleryController.categories[index];
                  return Obx(() => CustomFilterChip(
                        text: category,
                        isSelected: galleryController.selectedCategory.value ==
                            category,
                        onTap: () => galleryController.selectCategory(category),
                      ));
                },
              ),
            ),
            sh12,

            // Storage Info (show only if NOT Pro user)
            galleryController.isProUser.value == true
                ? SizedBox.shrink()
                : Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    child: Text(
                      "Storage Used: 420 MB / 500 MB",
                      style: h5.copyWith(
                        color: Colors.red,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
            sh12,

            // Gallery section
            Expanded(
              child: galleryController.isGalleryLocked.value
                  ? _buildLockedGallery()
                  : _buildGalleryGrid(),
            ),
          ],
        );
      }),
    );
  }

  /// Locked gallery view
  Widget _buildLockedGallery() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            sh116,
            Image.asset(
              AppImages.changePassPro,
              scale: 4,
            ),
            sh12,
            Text(
              'Enter PIN to Unlock',
              style: h2.copyWith(fontWeight: FontWeight.w700),
            ),
            sh12,
            Text(
              'Please enter your 6-digit PIN to continue',
              style: h4,
            ),
            const SizedBox(height: 30),
            PinCodeTextField(
              length: 6,
              obscureText: false,
              keyboardType: TextInputType.number,
              animationType: AnimationType.fade,
              pinTheme: PinTheme(
                shape: PinCodeFieldShape.underline,
                borderRadius: BorderRadius.circular(8),
                fieldHeight: 60,
                fieldWidth: 50,
                // Reduce the width slightly for the gap
                activeColor: AppColors.white,
                activeFillColor: AppColors.white,
                inactiveColor: AppColors.borderColor,
                inactiveFillColor: AppColors.white,
                selectedColor: AppColors.blue,
                selectedFillColor: AppColors.white,
              ),
              animationDuration: const Duration(milliseconds: 300),
              backgroundColor: AppColors.transparent,
              cursorColor: AppColors.blue,
              enablePinAutofill: true,
              enableActiveFill: true,
              onCompleted: (v) {},
              onChanged: (value) {},
              beforeTextPaste: (text) {
                log("Allowing to paste $text");
                return true;
              },
              appContext: context,
            ),
            sh20,
            CustomButton(
              text: 'Submit',
              onPressed: () {},
              gradientColors: AppColors.buttonColor,
            ),
          ],
        ),
      ),
    );
  }

  /// Unlocked gallery grid view
  Widget _buildGalleryGrid() {
    return GridView.builder(
      padding: EdgeInsets.only(left: 20.w, right: 20.w, bottom: 116.h),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 10.w,
        mainAxisSpacing: 10.h,
        childAspectRatio: 0.9,
      ),
      itemCount: galleryController.galleryImages.length,
      itemBuilder: (context, index) {
        return GalleryItem(
          imageUrl: galleryController.galleryImages[index],
          isFavorite: false,
          onFavoriteToggle: () {},
        );
      },
    );
  }
}
