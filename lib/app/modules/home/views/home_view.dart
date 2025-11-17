// import 'dart:developer';
// import 'dart:io';
// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:foto_tidy/app/modules/gallery/views/gallery_view.dart';
// import 'package:foto_tidy/app/modules/home/controllers/home_controller.dart';
// import 'package:foto_tidy/app/modules/home/views/browse_photos_view.dart';
// import 'package:foto_tidy/app/modules/profile/controllers/profile_controller.dart';
// import 'package:foto_tidy/app/modules/profile/views/profile_view.dart';
// import 'package:foto_tidy/app/modules/tags/controllers/tags_controller.dart';
// import 'package:foto_tidy/common/app_color/app_colors.dart';
// import 'package:foto_tidy/common/app_images/app_images.dart';
// import 'package:foto_tidy/common/widgets/custom_button.dart';
// import 'package:get/get.dart';
// import 'package:pin_code_fields/pin_code_fields.dart';
// import '../../../../common/app_text_style/styles.dart';
// import '../../../../common/helper/custom_filter_chip.dart';
// import '../../../../common/helper/gallery_item.dart';
// import '../../../../common/size_box/custom_sizebox.dart';
// import '../../gallery/controllers/gallery_controller.dart';
//
// class HomeView extends StatefulWidget {
//   const HomeView({super.key});
//
//   @override
//   State<HomeView> createState() => _HomeViewState();
// }
//
// class _HomeViewState extends State<HomeView> {
//   final homeController = Get.put(HomeController());
//   final galleryController = Get.put(GalleryController());
//   final profileController = Get.put(ProfileController());
//   final tagsController = Get.put(TagsController());
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
//             onTap: () {
//               Get.to(() => ProfileView(
//                     showBackButton: true,
//                   ));
//             },
//             child: Obx(() {
//               final imagePath = profileController.profileImageUrl.value;
//               return CircleAvatar(
//                 radius: 20,
//                 backgroundColor: AppColors.whiteDark,
//                 child: ClipRRect(
//                   borderRadius: BorderRadius.circular(20),
//                   child: imagePath.startsWith("http")
//                       ? CachedNetworkImage(
//                           imageUrl: imagePath,
//                           height: Get.height.h,
//                           width: Get.width.w,
//                           fit: BoxFit.cover,
//                           placeholder: (context, url) => const Center(
//                             child: CircularProgressIndicator(
//                               color: AppColors.orange,
//                             ),
//                           ),
//                           errorWidget: (context, url, error) => const Icon(
//                             Icons.error,
//                             color: Colors.red,
//                           ),
//                         )
//                       : Image.file(
//                           File(imagePath),
//                           height: Get.height.h,
//                           width: Get.width.w,
//                           fit: BoxFit.cover,
//                         ),
//                 ),
//               );
//             }),
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
//                   onPressed: homeController.takePhoto,
//                   gradientColors: AppColors.buttonColor,
//                   borderRadius: 12,
//                   height: 40,
//                   centerImageWithText: true,
//                   imageAssetPath: AppImages.camera,
//                 ),
//                 sh8,
//                 CustomButton(
//                   text: 'Browse Photos',
//                   onPressed: () {
//                     Get.to(()=> BrowsePhotosView());
//                     // PopupHelper.showCustomPopupForImageUpload(
//                     //   title: 'Upload your image',
//                     //   description: 'Drag and drop or browse to choose a file',
//                     //   iconPath: AppImages.uploadImage,
//                     //   onPrimaryPressed: () {
//                     //     homeController.pickImage();
//                     //   },
//                     //   primaryButtonText: 'Choose File',
//                     //   footerText: 'PNG, JPG up to 10MB',
//                     // );
//                   },
//                   borderColor: AppColors.borderColor,
//                   borderRadius: 12,
//                   textColor: AppColors.black,
//                   height: 40,
//                   centerImageWithText: true,
//                   imageAssetPath: AppImages.browsePhotos,
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
//                   onTap: () {
//                     Get.to(() => GalleryView());
//                   },
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
//             child: Obx(() {
//               final tags = tagsController.allTagsList;
//               final selected = galleryController.selectedCategory.value;
//               final isLoading = tagsController.isLoading.value; // Add loading flag in controller if missing
//
//               if (isLoading) {
//                 return Center(
//                   child: SizedBox(
//                     width: 24.w,
//                     height: 24.w,
//                     child: CircularProgressIndicator(strokeWidth: 2, color: AppColors.orange),
//                   ),
//                 );
//               }
//
//               if (tags.isEmpty) {
//                 return Center(
//                   child: Text(
//                     "No tags available",
//                     style: h5.copyWith(color: AppColors.grey),
//                   ),
//                 );
//               }
//
//               return ListView.builder(
//                 scrollDirection: Axis.horizontal,
//                 padding: EdgeInsets.symmetric(horizontal: 20.w),
//                 itemCount: tags.length,
//                 itemBuilder: (context, index) {
//                   final tag = tags[index];
//                   final tagName = tag.title ?? '';
//                   final isSelected = selected == tagName;
//
//                   return Padding(
//                     padding: EdgeInsets.only(right: 8.w),
//                     child: CustomFilterChip(
//                       text: tagName,
//                       isSelected: isSelected,
//                       onTap: () {
//                         if (isSelected) {
//                           galleryController.selectedCategory.value = '';
//                           galleryController.filterGalleryByTag('');
//                         } else {
//                           galleryController.selectedCategory.value = tagName;
//                           galleryController.filterGalleryByTag(tagName);
//                         }
//                       },
//                     ),
//                   );
//                 },
//               );
//             }),
//           ),
//           sh12,
//
//           // Storage Info (show only if NOT Pro user)
//           profileController.profileData.value?.data?.isActiveSubscription ==
//               true
//               ? SizedBox.shrink()
//               : Padding(
//             padding: EdgeInsets.symmetric(horizontal: 20.w),
//             child: Text(
//               "Storage Used: ${profileController.profileData.value?.data?.freeStorage} MB / ${profileController.profileData.value?.data?.storageLimit} MB",
//               style: h5.copyWith(
//                 color: AppColors.black,
//                 fontWeight: FontWeight.w500,
//               ),
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
//               onCompleted: (pin) {
//                 // if (pin == "123456") {
//                 //   galleryController.unlockGallery();
//                 // } else {
//                 //   Get.snackbar('Invalid PIN', 'Please enter the correct PIN');
//                 // }
//               },
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
//           isFavorite: false,
//           isProUser: galleryController.isProUser.value,
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
import 'package:foto_tidy/app/modules/gallery/views/gallery_view.dart';
import 'package:foto_tidy/app/modules/home/controllers/home_controller.dart';
import 'package:foto_tidy/app/modules/home/views/browse_photos_view.dart';
import 'package:foto_tidy/app/modules/home/views/notifications_view.dart';
import 'package:foto_tidy/app/modules/profile/controllers/profile_controller.dart';
import 'package:foto_tidy/app/modules/tags/controllers/tags_controller.dart';
import 'package:foto_tidy/common/app_color/app_colors.dart';
import 'package:foto_tidy/common/app_images/app_images.dart';
import 'package:foto_tidy/common/widgets/custom_button.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import '../../../../common/app_text_style/styles.dart';
import '../../../../common/helper/custom_filter_chip.dart';
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
  final profileController = Get.put(ProfileController());
  final tagsController = Get.put(TagsController());

  @override
  void initState() {
    super.initState();
    _loadInitialData();
  }

  Future<void> _loadInitialData() async {
    await profileController.fetchProfile();
    await galleryController.fetchMyGallery();
  }

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
            onTap: () {
              Get.to(()=> NotificationsView());
            },
            child: Image.asset(AppImages.notification,scale: 4,color: AppColors.black,),
          ),
          // GestureDetector(
          //   onTap: () {
          //     Get.to(() => ProfileView(
          //       showBackButton: true,
          //     ));
          //   },
          //   child: Obx(() {
          //     final imagePath = profileController.profileImageUrl.value;
          //     return CircleAvatar(
          //       radius: 20,
          //       backgroundColor: AppColors.whiteDark,
          //       child: ClipRRect(
          //         borderRadius: BorderRadius.circular(20),
          //         child: imagePath.startsWith("http")
          //             ? CachedNetworkImage(
          //           imageUrl: imagePath,
          //           height: Get.height.h,
          //           width: Get.width.w,
          //           fit: BoxFit.cover,
          //           placeholder: (context, url) => const Center(
          //             child: CircularProgressIndicator(
          //               color: AppColors.orange,
          //             ),
          //           ),
          //           errorWidget: (context, url, error) => const Icon(
          //             Icons.error,
          //             color: Colors.red,
          //           ),
          //         )
          //             : Image.file(
          //           File(imagePath),
          //           height: Get.height.h,
          //           width: Get.width.w,
          //           fit: BoxFit.cover,
          //         ),
          //       ),
          //     );
          //   }),
          // ),
          sw20,
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
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
                  centerImageWithText: true,
                  imageAssetPath: AppImages.camera,
                ),
                sh8,
                CustomButton(
                  text: 'Browse Photos',
                  onPressed: () {
                    Get.to(() => BrowsePhotosView());
                  },
                  borderColor: AppColors.borderColor,
                  borderRadius: 12,
                  textColor: AppColors.black,
                  height: 40,
                  centerImageWithText: true,
                  imageAssetPath: AppImages.browsePhotos,
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
            child: Obx(() {
              final tags = tagsController.allTagsList;
              final selected = galleryController.selectedCategory.value;
              final isLoading = tagsController.isLoading.value;

              if (isLoading) {
                return Center(
                  child: SizedBox(
                    width: 24.w,
                    height: 24.w,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      color: AppColors.orange,
                    ),
                  ),
                );
              }

              if (tags.isEmpty) {
                return Center(
                  child: Text(
                    "No tags available",
                    style: h5.copyWith(color: AppColors.grey),
                  ),
                );
              }

              return ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                itemCount: tags.length,
                itemBuilder: (context, index) {
                  final tag = tags[index];
                  final tagName = tag.title ?? '';
                  final tagId = tag.id?.toString() ?? '';
                  final isSelected = selected == tagName;

                  return Padding(
                    padding: EdgeInsets.only(right: 8.w),
                    child: CustomFilterChip(
                      text: tagName,
                      isSelected: isSelected,
                      onTap: () {
                        galleryController.selectCategory(tagId, tagName);
                      },
                    ),
                  );
                },
              );
            }),
          ),
          sh12,

          /// ---------- STORAGE INFO (Only for Free Users) ----------
          Obx(() {
            final data = profileController.profileData.value?.data;
            if (data == null) return SizedBox();
            if (data.isActiveSubscription == true)
              return const SizedBox.shrink();
            return Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Text(
                "Storage Used: ${data.freeStorage ?? 0} MB / ${data.storageLimit ?? 0} MB",
                style: h5.copyWith(
                  color: AppColors.black,
                  fontWeight: FontWeight.w500,
                ),
              ),
            );
          }),

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
              onCompleted: (pin) {},
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

  Widget _buildGalleryGrid() {
    return Obx(() {
      if (galleryController.isLoading.value) {
        return const Center(
          child: CircularProgressIndicator(color: AppColors.orange),
        );
      }

      if (galleryController.galleryList.isEmpty) {
        return Center(
          child: Text(
            "No gallery items found",
            style: h4.copyWith(color: AppColors.grey),
          ),
        );
      }

      return GridView.builder(
        padding: EdgeInsets.only(left: 20.w, right: 20.w, bottom: 116.h),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 10.w,
          mainAxisSpacing: 10.h,
          childAspectRatio: 1,
        ),
        itemCount: galleryController.galleryList.length,
        itemBuilder: (context, index) {
          final item = galleryController.galleryList[index];
          final imageUrl = item.image ?? '';

          return Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: AppColors.white,
              boxShadow: [
                BoxShadow(
                  color: AppColors.grey.withOpacity(0.2),
                  blurRadius: 4,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: imageUrl.isNotEmpty
                  ? CachedNetworkImage(
                      imageUrl: imageUrl,
                      fit: BoxFit.cover,
                      placeholder: (context, url) => const Center(
                        child: CircularProgressIndicator(
                          color: AppColors.orange,
                        ),
                      ),
                      errorWidget: (context, url, error) => Center(
                        child: Text(
                          item.tag?.title ?? 'Untitled',
                          style: h5.copyWith(color: AppColors.grey),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    )
                  : Center(
                      child: Text(
                        item.tag?.title ?? 'Untitled',
                        style: h5.copyWith(color: AppColors.grey),
                        textAlign: TextAlign.center,
                      ),
                    ),
            ),
          );
        },
      );
    });
  }
}
