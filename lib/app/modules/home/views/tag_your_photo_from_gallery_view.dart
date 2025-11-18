// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:foto_tidy/app/modules/home/views/photo_saved_successfully_view.dart';
// import 'package:foto_tidy/common/app_text_style/styles.dart';
// import 'package:get/get.dart';
//
// import '../../../../common/app_color/app_colors.dart';
// import '../../../../common/app_images/app_images.dart';
// import '../../../../common/helper/custom_filter_chip.dart';
// import '../../../../common/size_box/custom_sizebox.dart';
// import '../../../../common/widgets/custom_button.dart';
// import '../../gallery/controllers/gallery_controller.dart';
// import '../../tags/controllers/tags_controller.dart';
//
// class TagYourPhotoFromGalleryView extends StatelessWidget {
//   final List<dynamic> uploadedFiles;
//
//   TagYourPhotoFromGalleryView({
//     required this.uploadedFiles,
//     super.key,
//   });
//
//   final galleryController = Get.find<GalleryController>();
//   final tagsController = Get.find<TagsController>();
//
//   /// Reactive index for selected image
//   final RxInt selectedIndex = 0.obs;
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: AppColors.mainColor,
//       appBar: AppBar(
//         title: Text('Tag Your Photo', style: appBarStyle),
//         backgroundColor: AppColors.mainColor,
//         centerTitle: true,
//       ),
//       body: Padding(
//         padding: EdgeInsets.symmetric(horizontal: 20.w),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             /// TOP HORIZONTAL IMAGE LIST
//             SizedBox(
//               height: 80.h,
//               child: ListView.builder(
//                   scrollDirection: Axis.horizontal,
//                   itemCount: uploadedFiles.length,
//                   itemBuilder: (context, index) {
//                     final fileUrl = uploadedFiles[index]["url"];
//
//                     return Obx(
//                       () {
//                         return GestureDetector(
//                           onTap: () => selectedIndex.value = index,
//                           child: Padding(
//                             padding: EdgeInsets.only(right: 10.w),
//                             child: Container(
//                               width: 80.w,
//                               decoration: BoxDecoration(
//                                 borderRadius: BorderRadius.circular(16).r,
//                                 color: AppColors.silver,
//                                 border: Border.all(
//                                   color: selectedIndex.value == index
//                                       ? AppColors.orange
//                                       : Colors.transparent,
//                                   width: 2,
//                                 ),
//                               ),
//                               child: ClipRRect(
//                                 borderRadius: BorderRadius.circular(8).r,
//                                 child: Image.network(
//                                   fileUrl,
//                                   fit: BoxFit.cover,
//                                 ),
//                               ),
//                             ),
//                           ),
//                         );
//                       },
//                     );
//                   }),
//             ),
//
//             sh12,
//
//             /// MAIN IMAGE PREVIEW
//             Obx(() {
//               return Container(
//                 height: 300.h,
//                 width: Get.width,
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(16).r,
//                   color: AppColors.silver,
//                 ),
//                 child: ClipRRect(
//                   borderRadius: BorderRadius.circular(16).r,
//                   child: Image.network(
//                     uploadedFiles[selectedIndex.value]["url"],
//                     fit: BoxFit.cover,
//                   ),
//                 ),
//               );
//             }),
//
//             sh20,
//             Text('Choose Tag', style: h3),
//             sh12,
//
//             /// TAG SELECTION
//             Wrap(
//               spacing: 10.w,
//               runSpacing: 10.h,
//               children: tagsController.allTagsList.map((category) {
//                 return Obx(
//                   () => CustomFilterChip(
//                     text: category.title ?? '',
//                     isSelected: galleryController.selectedCategory.value ==
//                         category.title,
//                     onTap: () {
//                       galleryController.selectCategory(
//                         category.id.toString(),
//                         category.title ?? '',
//                       );
//                     },
//                   ),
//                 );
//               }).toList(),
//             ),
//
//             sh20,
//
//             /// APPLY TO ALL
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Text('Apply to all photos', style: h5),
//                 Image.asset(AppImages.toggle, scale: 4),
//               ],
//             ),
//
//             sh20,
//
//             /// SAVE BUTTON
//             CustomButton(
//               text: 'Save All Photos',
//               onPressed: () {
//                 if (galleryController.selectedCategory.value.isNotEmpty) {
//                   Get.to(() => PhotoSavedSuccessfullyView());
//                 } else {
//                   Get.snackbar('No Category', 'Please select a category');
//                 }
//               },
//               gradientColors: AppColors.buttonColor,
//               borderRadius: 12,
//               height: 40.h,
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }


import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:foto_tidy/common/app_text_style/styles.dart';
import 'package:get/get.dart';

import '../../../../common/app_color/app_colors.dart';
import '../../../../common/helper/custom_filter_chip.dart';
import '../../../../common/size_box/custom_sizebox.dart';
import '../../../../common/widgets/custom_button.dart';
import '../../gallery/controllers/gallery_controller.dart';
import '../../tags/controllers/tags_controller.dart';

class TagYourPhotoFromGalleryView extends StatelessWidget {
  final List<dynamic> uploadedFiles;

  TagYourPhotoFromGalleryView({
    required this.uploadedFiles,
    super.key,
  });

  final galleryController = Get.find<GalleryController>();
  final tagsController = Get.find<TagsController>();

  /// Reactive index for selected image preview
  final RxInt selectedIndex = 0.obs;

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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// --------------------------
            /// TOP HORIZONTAL IMAGE LIST
            /// --------------------------
            SizedBox(
              height: 80.h,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: uploadedFiles.length,
                itemBuilder: (context, index) {
                  final fileUrl = uploadedFiles[index]["url"];

                  return Obx(() {
                    return GestureDetector(
                      onTap: () => selectedIndex.value = index,
                      child: Padding(
                        padding: EdgeInsets.only(right: 10.w),
                        child: Container(
                          width: 80.w,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16).r,
                            color: AppColors.silver,
                            border: Border.all(
                              color: selectedIndex.value == index
                                  ? AppColors.orange
                                  : Colors.transparent,
                              width: 2,
                            ),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(8).r,
                            child: Image.network(
                              fileUrl,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                    );
                  });
                },
              ),
            ),

            sh12,

            /// --------------------------
            /// MAIN IMAGE PREVIEW
            /// --------------------------
            Obx(() {
              return Container(
                height: 300.h,
                width: Get.width,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16).r,
                  color: AppColors.silver,
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16).r,
                  child: Image.network(
                    uploadedFiles[selectedIndex.value]["url"],
                    fit: BoxFit.cover,
                  ),
                ),
              );
            }),

            sh20,

            Text('Choose Tag', style: h3),
            sh12,

            /// --------------------------
            /// TAG SELECTION
            /// --------------------------
            Wrap(
              spacing: 10.w,
              runSpacing: 10.h,
              children: tagsController.allTagsList.map((category) {
                return Obx(() {
                  final isSelected =
                      galleryController.selectedCategory.value ==
                          (category.title ?? '');

                  return CustomFilterChip(
                    text: category.title ?? '',
                    isSelected: isSelected,
                    onTap: () {
                      galleryController.selectCategory(
                        category.id.toString(),
                        category.title ?? '',
                      );
                    },
                  );
                });
              }).toList(),
            ),

            sh20,

            /// --------------------------
            /// APPLY TO ALL
            /// --------------------------
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //   children: [
            //     Text('Apply to all photos', style: h5),
            //     Image.asset(AppImages.toggle, scale: 4),
            //   ],
            // ),

            sh20,

            /// --------------------------
            /// SAVE BUTTON
            /// --------------------------
            CustomButton(
              text: 'Save All Photos',
              onPressed: () async {
                if (galleryController.selectedCategory.value.isEmpty) {
                  Get.snackbar('No Category', 'Please select a category');
                  return;
                }

                final selectedTagId =
                tagsController.getTagIdByTitle(galleryController.selectedCategory.value);

                if (selectedTagId == null) {
                  Get.snackbar('Error', 'Invalid tag selected');
                  return;
                }

                /// 💥 Build dynamic payload
                final payload = uploadedFiles.map((file) {
                  return {
                    "tag": selectedTagId,
                    "image": file["url"],
                    "fileSize": file["size"] ?? 0.0,
                  };
                }).toList();

                /// 💥 Upload now
                await galleryController.uploadBatchPhotos(payload, context);

              },
              gradientColors: AppColors.buttonColor,
              borderRadius: 12,
              height: 40.h,
            ),
          ],
        ),
      ),
    );
  }
}
