// import 'dart:developer';
//
// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:foto_tidy/common/app_color/app_colors.dart';
// import 'package:foto_tidy/common/app_images/app_images.dart';
// import 'package:foto_tidy/common/widgets/custom_button.dart';
//
// import 'package:get/get.dart';
// import 'package:pin_code_fields/pin_code_fields.dart';
//
// import '../../../../common/app_text_style/styles.dart';
// import '../../../../common/helper/custom_filter_chip.dart';
// import '../../../../common/helper/gallery_item.dart';
// import '../../../../common/size_box/custom_sizebox.dart';
// import '../../gallery/controllers/gallery_controller.dart';
//
// class HomeView extends StatefulWidget {
//   const HomeView({super.key,});
//
//   @override
//   State<HomeView> createState() => _HomeViewState();
// }
//
// class _HomeViewState extends State<HomeView> {
//   final galleryController = Get.put(GalleryController());
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: AppColors.background,
//       appBar: AppBar(
//         backgroundColor: AppColors.background,
//         title: Image.asset(
//           AppImages.logo,
//           scale: 4,
//           height: 44.h,
//           width: 78.w,
//         ),
//         actions: [
//           GestureDetector(
//             onTap: () {},
//             child: CircleAvatar(
//               radius: 20,
//               backgroundImage:
//                   CachedNetworkImageProvider(AppImages.profileImage),
//             ),
//           ),
//           sw20,
//         ],
//       ),
//       body: Column(
//         mainAxisAlignment: MainAxisAlignment.start,
//         children: [
//           sh12,
//           Padding(
//             padding: EdgeInsets.symmetric(horizontal: 20.w),
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Text(
//                   'Organize Your Photos',
//                   style: h2,
//                 ),
//                 sh8,
//                 Text(
//                   'Take or browse photos to get started',
//                   style: h4,
//                 ),
//                 sh12,
//                 CustomButton(
//                   text: 'Take Photo',
//                   onPressed: () {
//                     //Get.to(() => CameraView(cameras: widget.cameras!));
//                   },
//                   gradientColors: AppColors.buttonColor,
//                   borderRadius: 12,
//                   height: 40,
//                 ),
//                 sh8,
//                 CustomButton(
//                   text: 'Browse Photos',
//                   onPressed: () {},
//                   borderColor: AppColors.borderColor,
//                   borderRadius: 12,
//                   textColor: AppColors.black,
//                   height: 40,
//                 ),
//               ],
//             ),
//           ),
//           sh16,
//           Padding(
//             padding: EdgeInsets.symmetric(horizontal: 20.w),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Text(
//                   'Gallery',
//                   style: h3,
//                 ),
//                 GestureDetector(
//                   onTap: () {},
//                   child: Text(
//                     'View All',
//                     style: h5.copyWith(color: AppColors.blue),
//                   ),
//                 )
//               ],
//             ),
//           ),
//           sh12,
//           SizedBox(
//             height: 35.h,
//             child: ListView.builder(
//               scrollDirection: Axis.horizontal,
//               padding: EdgeInsets.symmetric(horizontal: 20.w),
//               itemCount: galleryController.categories.length,
//               itemBuilder: (context, index) {
//                 final category = galleryController.categories[index];
//                 return Obx(() => CustomFilterChip(
//                       text: category,
//                       isSelected:
//                           galleryController.selectedCategory.value == category,
//                       onTap: () => galleryController.selectCategory(category),
//                     ));
//               },
//             ),
//           ),
//           sh12,
//           Expanded(
//             child: galleryController.isGalleryLocked.value
//                 ? _buildLockedGallery()
//                 : _buildGalleryGrid(),
//           )
//         ],
//       ),
//     );
//   }
//
//   /// Locked gallery view
//   Widget _buildLockedGallery() {
//     return Padding(
//       padding: EdgeInsets.symmetric(horizontal: 20.w),
//       child: SingleChildScrollView(
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: [
//             Image.asset(
//               AppImages.changePassPro,
//               scale: 4,
//             ),
//             sh12,
//             Text(
//               'Enter PIN to Unlock',
//               style: h2.copyWith(fontWeight: FontWeight.w700),
//             ),
//             sh12,
//             Text(
//               'Please enter your 6-digit PIN to continue',
//               style: h4,
//             ),
//             sh12,
//             PinCodeTextField(
//               length: 6,
//               obscureText: false,
//               keyboardType: TextInputType.number,
//               animationType: AnimationType.fade,
//               pinTheme: PinTheme(
//                 shape: PinCodeFieldShape.underline,
//                 borderRadius: BorderRadius.circular(8),
//                 fieldHeight: 40,
//                 fieldWidth: 40,
//                 // Reduce the width slightly for the gap
//                 activeColor: AppColors.white,
//                 activeFillColor: AppColors.white,
//                 inactiveColor: AppColors.borderColor,
//                 inactiveFillColor: AppColors.white,
//                 selectedColor: AppColors.blue,
//                 selectedFillColor: AppColors.white,
//               ),
//               animationDuration: const Duration(milliseconds: 300),
//               backgroundColor: AppColors.transparent,
//               cursorColor: AppColors.blue,
//               enablePinAutofill: true,
//               enableActiveFill: true,
//               onCompleted: (v) {},
//               onChanged: (value) {},
//               beforeTextPaste: (text) {
//                 log("Allowing to paste $text");
//                 return true;
//               },
//               appContext: context,
//             ),
//             sh20,
//             CustomButton(
//               text: 'Submit',
//               onPressed: () {},
//               gradientColors: AppColors.buttonColor,
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   /// Unlocked gallery grid view
//   Widget _buildGalleryGrid() {
//     return GridView.builder(
//       padding: EdgeInsets.only(left: 20.w, right: 20.w, bottom: 116.h),
//       gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//         crossAxisCount: 2,
//         crossAxisSpacing: 10.w,
//         mainAxisSpacing: 10.h,
//         childAspectRatio: 1,
//       ),
//       itemCount: galleryController.galleryImages.length,
//       itemBuilder: (context, index) {
//         return GalleryItem(
//           imageUrl: galleryController.galleryImages[index],
//           isFavorite: true,
//           isProUser: true,
//           onFavoriteToggle: () {},
//         );
//       },
//     );
//   }
// }

import 'dart:developer';
import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:foto_tidy/app/modules/dashboard/views/dashboard_view.dart';
import 'package:foto_tidy/app/modules/gallery/views/gallery_view.dart';
import 'package:foto_tidy/app/modules/home/controllers/home_controller.dart';
import 'package:foto_tidy/common/app_color/app_colors.dart';
import 'package:foto_tidy/common/app_images/app_images.dart';
import 'package:foto_tidy/common/widgets/custom_button.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import '../../../../common/app_text_style/styles.dart';
import '../../../../common/helper/custom_filter_chip.dart';
import '../../../../common/helper/gallery_item.dart';
import '../../../../common/size_box/custom_sizebox.dart';
import '../../gallery/controllers/gallery_controller.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final homeController = Get.put(HomeController());
  final galleryController = Get.put(GalleryController());

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
          sh12,
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Organize Your Photos',
                  style: h2,
                ),
                sh8,
                Text(
                  'Take or browse photos to get started',
                  style: h4,
                ),
                sh12,
                CustomButton(
                  text: 'Take Photo',
                  onPressed: homeController.takePhoto,
                  gradientColors: AppColors.buttonColor,
                  borderRadius: 12,
                  height: 40,
                ),
                sh8,
                CustomButton(
                  text: 'Browse Photos',
                  onPressed: () {},
                  borderColor: AppColors.borderColor,
                  borderRadius: 12,
                  textColor: AppColors.black,
                  height: 40,
                ),
              ],
            ),
          ),
          sh16,
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
                  onTap: () {
                    Get.to(() => GalleryView());
                  },
                  child: Text(
                    'View All',
                    style: h5.copyWith(color: AppColors.blue),
                  ),
                )
              ],
            ),
          ),
          sh12,
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
                      isSelected:
                          galleryController.selectedCategory.value == category,
                      onTap: () => galleryController.selectCategory(category),
                    ));
              },
            ),
          ),
          sh12,
          Expanded(
            child: galleryController.isGalleryLocked.value
                ? _buildLockedGallery()
                : _buildGalleryGrid(),
          )
        ],
      ),
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
            sh12,
            PinCodeTextField(
              length: 6,
              obscureText: false,
              keyboardType: TextInputType.number,
              animationType: AnimationType.fade,
              pinTheme: PinTheme(
                shape: PinCodeFieldShape.underline,
                borderRadius: BorderRadius.circular(8),
                fieldHeight: 40,
                fieldWidth: 40,
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
              onCompleted: (pin) {
                // if (pin == "123456") {
                //   galleryController.unlockGallery();
                // } else {
                //   Get.snackbar('Invalid PIN', 'Please enter the correct PIN');
                // }
              },
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
        childAspectRatio: 1,
      ),
      itemCount: galleryController.galleryImages.length,
      itemBuilder: (context, index) {
        return GalleryItem(
          imageUrl: galleryController.galleryImages[index],
          isFavorite: true,
          isProUser: galleryController.isProUser.value,
          onFavoriteToggle: () {},
        );
      },
    );
  }
}

class CameraReviewScreen extends StatelessWidget {
  final String imagePath;

  const CameraReviewScreen({super.key, required this.imagePath});

  @override
  Widget build(BuildContext context) {
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
            height: Get.height * 0.8.h,
            width: Get.width,
            errorBuilder: (context, error, stackTrace) => const Center(
              child: Text('Failed to load image'),
            ),
          ),
          sh20,
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: CustomButton(
              text: 'Next',
              onPressed: () {
                Get.to(() => TagPhotoScreen(imagePath: imagePath));
              },
              gradientColors: AppColors.buttonColor,
              borderRadius: 12,
              height: 40,
            ),
          ),
        ],
      ),
    );
  }
}

class TagPhotoScreen extends StatefulWidget {
  final String imagePath;

  const TagPhotoScreen({super.key, required this.imagePath});

  @override
  State<TagPhotoScreen> createState() => _TagPhotoScreenState();
}

class _TagPhotoScreenState extends State<TagPhotoScreen> {
  final galleryController = Get.find<GalleryController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.mainColor,
      appBar: AppBar(
        title: Text('Tag Your Photo', style: appBarStyle),
        backgroundColor: AppColors.mainColor,
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Column(
          children: [
            // Image display
            Container(
              height: 300.h,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16).r,
                color: AppColors.silver,
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16).r,
                child: Image.file(
                  File(widget.imagePath),
                  fit: BoxFit.cover,
                  width: Get.width,
                  errorBuilder: (context, error, stackTrace) => const Center(
                    child: Text('Failed to load image'),
                  ),
                ),
              ),
            ),
            sh20,
            // Category selection
            Wrap(
              spacing: 10.w,
              runSpacing: 10.h,
              children: galleryController.categories.map((category) {
                return Obx(
                  () => CustomFilterChip(
                    text: category,
                    isSelected:
                        galleryController.selectedCategory.value == category,
                    onTap: () {
                      galleryController.selectCategory(
                          category); // Update category using GetX
                    },
                  ),
                );
              }).toList(),
            ),
            sh20,
            // Save button
            CustomButton(
              text: 'Save All Photos',
              onPressed: () {
                if (galleryController.selectedCategory.value != null) {
                  Get.to(() =>
                      SaveConfirmationScreen(imagePath: widget.imagePath));
                } else {
                  Get.snackbar('No Category', 'Please select a category');
                }
              },
              gradientColors: AppColors.buttonColor,
              borderRadius: 12,
              height: 40,
            ),
          ],
        ),
      ),
    );
  }
}

class SaveConfirmationScreen extends StatelessWidget {
  final String imagePath;

  const SaveConfirmationScreen({super.key, required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.mainColor,
      appBar: AppBar(
        title: Text('Photo saved',style: appBarStyle,),
        backgroundColor: AppColors.mainColor,
        automaticallyImplyLeading: false,
      ),
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
