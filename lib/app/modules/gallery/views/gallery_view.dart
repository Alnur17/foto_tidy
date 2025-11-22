// import 'dart:developer';
//
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:foto_tidy/app/modules/profile/controllers/profile_controller.dart';
// import 'package:foto_tidy/app/modules/tags/controllers/tags_controller.dart';
// import 'package:get/get.dart';
// import 'package:pin_code_fields/pin_code_fields.dart';
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
//   final profileController = Get.put(ProfileController());
//   final TagsController tagsController = Get.find();
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
//       body: Obx(() {
//         return Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             sh8,
//             // Filter Chips (Dynamic from TagsController)
//             SizedBox(
//               height: 35.h,
//               child: Obx(() {
//                 final tags = tagsController.allTagsList;
//                 final selected = galleryController.selectedCategory.value;
//                 final isLoading = tagsController.isLoading.value;
//
//                 if (isLoading) {
//                   return Center(
//                     child: SizedBox(
//                       width: 24.w,
//                       height: 24.w,
//                       child: CircularProgressIndicator(
//                           strokeWidth: 2, color: AppColors.orange),
//                     ),
//                   );
//                 }
//
//                 if (tags.isEmpty) {
//                   return Center(
//                     child: Text(
//                       "No tags available",
//                       style: h5.copyWith(color: AppColors.grey),
//                     ),
//                   );
//                 }
//
//                 return ListView.builder(
//                   scrollDirection: Axis.horizontal,
//                   padding: EdgeInsets.symmetric(horizontal: 20.w),
//                   itemCount: tags.length,
//                   itemBuilder: (context, index) {
//                     final tag = tags[index];
//                     final tagName = tag.title ?? '';
//                     final isSelected = selected == tagName;
//
//                     return Padding(
//                       padding: EdgeInsets.only(right: 8.w),
//                       child: CustomFilterChip(
//                         text: tagName,
//                         isSelected: isSelected,
//                         onTap: () {
//                           if (isSelected) {
//                             galleryController.selectCategory('');
//                           } else {
//                             galleryController.selectCategory(tagName);
//                           }
//                         },
//                       ),
//                     );
//                   },
//                 );
//               }),
//             ),
//
//             sh12,
//
//             // Storage Info (show only if NOT Pro user)
//             profileController.profileData.value?.data?.isActiveSubscription ==
//                     true
//                 ? SizedBox.shrink()
//                 : Padding(
//                     padding: EdgeInsets.symmetric(horizontal: 20.w),
//                     child: Text(
//                       "Storage Used: ${profileController.profileData.value?.data?.freeStorage} MB / ${profileController.profileData.value?.data?.storageLimit} MB",
//                       style: h5.copyWith(
//                         color: AppColors.black,
//                         fontWeight: FontWeight.w500,
//                       ),
//                     ),
//                   ),
//             sh12,
//
//             // Gallery section
//             Expanded(
//               child: galleryController.isGalleryLocked.value
//                   ? _buildLockedGallery()
//                   : _buildGalleryGrid(),
//             ),
//           ],
//         );
//       }),
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
//             sh116,
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
//             const SizedBox(height: 30),
//             PinCodeTextField(
//               length: 6,
//               obscureText: false,
//               keyboardType: TextInputType.number,
//               animationType: AnimationType.fade,
//               pinTheme: PinTheme(
//                 shape: PinCodeFieldShape.underline,
//                 borderRadius: BorderRadius.circular(8),
//                 fieldHeight: 60,
//                 fieldWidth: 50,
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
//         childAspectRatio: 0.9,
//       ),
//       itemCount: galleryController.galleryList.length,
//       itemBuilder: (context, index) {
//         return GalleryItem(
//           imageUrl: galleryController.galleryList.first.image ?? '',
//           isFavorite: false,
//           onFavoriteToggle: () {},
//         );
//       },
//     );
//   }
// }

import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:foto_tidy/app/modules/profile/controllers/profile_controller.dart';
import 'package:foto_tidy/app/modules/tags/controllers/tags_controller.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import '../../../../common/app_color/app_colors.dart';
import '../../../../common/app_text_style/styles.dart';
import '../../../../common/app_images/app_images.dart';
import '../../../../common/helper/custom_filter_chip.dart';
import '../../../../common/helper/gallery_item.dart';
import '../../../../common/size_box/custom_sizebox.dart';
import '../../../../common/widgets/custom_button.dart';
import '../../profile/controllers/favorite_controller.dart';
import '../controllers/gallery_controller.dart';

class GalleryView extends StatefulWidget {
  const GalleryView({super.key});

  @override
  State<GalleryView> createState() => _GalleryViewState();
}

class _GalleryViewState extends State<GalleryView> {
  final profileController = Get.put(ProfileController());
  final tagsController = Get.find<TagsController>();
  final galleryController = Get.put(GalleryController());
  final favoriteController = Get.put(FavoriteController());

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
              padding: const EdgeInsets.symmetric(horizontal: 8),
              imageAssetPath: AppImages.filter,
            ),
          ],
        ),
      ),
      body: Obx(() {
        if (galleryController.isLoading.value) {
          return const Center(
            child: CircularProgressIndicator(color: AppColors.orange),
          );
        }

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            sh8,

            /// ---------- TAG FILTER CHIP SECTION ----------
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
                        // onTap: () {
                        //   final matchedPhoto = galleryController.galleryList.firstWhereOrNull(
                        //         (item) => item.tag?.title?.toLowerCase().trim() ==
                        //         tagName.toLowerCase().trim(),
                        //   );
                        //
                        //   final galleryTagId = matchedPhoto?.tag?.id?.toString();
                        //
                        //   if (galleryTagId != null) {
                        //     galleryController.selectCategory(galleryTagId, tagName);
                        //   } else {
                        //     kSnackBar(
                        //       message: 'No photos found for this tag',
                        //       bgColor: AppColors.orange,
                        //     );
                        //   }
                        // },
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
            profileController.profileData.value?.data?.isActiveSubscription ==
                    true
                ? const SizedBox.shrink()
                : Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    child: Text(
                      "Storage Used: ${profileController.profileData.value?.data?.freeStorage} MB / ${profileController.profileData.value?.data?.storageLimit} MB",
                      style: h5.copyWith(
                        color: AppColors.black,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),

            sh12,

            /// ---------- GALLERY SECTION ----------
            Expanded(
              child: profileController.profileData.value?.data?.isGalleryLock ==
                      true
                  ? _buildLockedGallery()
                  : _buildGalleryGrid(),
            ),
          ],
        );
      }),
    );
  }

  /// Locked gallery (PIN entry)
  Widget _buildLockedGallery() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          sh116,
          Image.asset(AppImages.changePassPro, scale: 4),
          sh12,
          Text('Enter PIN to Unlock',
              style: h2.copyWith(fontWeight: FontWeight.w700)),
          sh12,
          Text('Please enter your 4-digit PIN to continue', style: h4),
          const SizedBox(height: 30),
          PinCodeTextField(
            controller: galleryController.pinTEController,
            length: 4,
            keyboardType: TextInputType.number,
            animationType: AnimationType.fade,
            pinTheme: PinTheme(
              shape: PinCodeFieldShape.underline,
              borderRadius: BorderRadius.circular(8),
              fieldHeight: 60,
              fieldWidth: 50,
              activeColor: AppColors.white,
              inactiveColor: AppColors.borderColor,
              selectedColor: AppColors.blue,
            ),
            animationDuration: const Duration(milliseconds: 300),
            backgroundColor: AppColors.transparent,
            cursorColor: AppColors.blue,
            enablePinAutofill: true,
            enableActiveFill: true,
            onCompleted: (v) => log("PIN entered: $v"),
            onChanged: (_) {},
            appContext: context,
          ),
          sh20,
          CustomButton(
            text: 'Submit',
            onPressed: () {
              galleryController.setGalleryLockAPI(
                  galleryController.pinTEController.text.toString().trim());
            },
            gradientColors: AppColors.buttonColor,
          ),
        ],
      ),
    );
  }

  /// Unlocked gallery grid view
  Widget _buildGalleryGrid() {
    final gallery = galleryController.galleryList;

    final isProUser =
        profileController.profileData.value?.data?.isActiveSubscription ??
            false;

    if (gallery.isEmpty) {
      return Center(
        child: Text(
          "No gallery images found",
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
        childAspectRatio: 0.9,
      ),
      itemCount: gallery.length,
      itemBuilder: (context, index) {
        final item = gallery[index];
        final isFav = RxBool(item.isFavorite ?? false);
        return GalleryItem(
          isProUser: isProUser,
          imageUrl: item.image ?? '',
          isFavorite: item.isFavorite ?? false,
          onFavoriteToggle: () async {
            final userId = profileController.profileData.value?.data?.id ?? "";
            final photoId = item.id ?? "";

            if (userId.isEmpty || photoId.isEmpty) {
              print("❌ Missing userId or photoId");
              return;
            }

            // -------- INSTANT UI UPDATE --------
            isFav.value = !isFav.value;

            // -------- API CALL --------
            if (isFav.value) {
              await favoriteController.addFavorite(
                userId: userId,
                photoId: photoId,
              );
            } else {
              await favoriteController.removeFavorite(photoId: photoId);
            }

            // -------- OPTIONAL REFRESH --------
            await galleryController.fetchMyGallery();
          },
        );
      },
    );
  }
}
