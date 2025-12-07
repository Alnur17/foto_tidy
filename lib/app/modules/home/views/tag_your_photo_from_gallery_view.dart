import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:foto_tidy/common/app_text_style/styles.dart';
import 'package:foto_tidy/common/widgets/custom_loader.dart';
import 'package:get/get.dart';

import '../../../../common/app_color/app_colors.dart';
import '../../../../common/app_images/app_images.dart';
import '../../../../common/helper/custom_filter_chip.dart';
import '../../../../common/size_box/custom_sizebox.dart';
import '../../../../common/widgets/custom_button.dart';
import '../../gallery/controllers/gallery_controller.dart';
import '../../profile/controllers/profile_controller.dart';
import '../../services/auth_service.dart';
import '../../services/drive_service.dart';
import '../../tags/controllers/tags_controller.dart';

class TagYourPhotoFromGalleryView extends StatelessWidget {
  final List<dynamic> uploadedFiles;

  TagYourPhotoFromGalleryView({
    required this.uploadedFiles,
    super.key,
  });

  final galleryController = Get.find<GalleryController>();
  final tagsController = Get.find<TagsController>();
  final ProfileController profileController = Get.find();

  /// Reactive index for selected image preview
  final RxInt selectedIndex = 0.obs;
  final RxBool uploadToGoogleDrive = false.obs;

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
                  final isSelected = galleryController.selectedCategory.value ==
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
            Obx(() {
              final data = profileController.profileData.value?.data;

              bool isProUser = data?.isActiveSubscription == true ||
                  data?.isEnabledFreeTrial == true;

              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Checkbox(
                        activeColor: AppColors.orange,
                        value: uploadToGoogleDrive.value,
                        onChanged: (value) {
                          if (isProUser) {
                            // Allow changing value
                            uploadToGoogleDrive.value = value ?? false;
                          } else {
                            // Free user — show snackbar, DO NOT change checkbox
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  "This feature is available for Pro users only.",
                                ),
                                backgroundColor: AppColors.orange,
                              ),
                            );
                          }
                        },
                      ),
                      sw8,
                      const Text('Upload to Google Drive'),
                    ],
                  ),
                  sw5,
                  Image.asset(AppImages.drive, scale: 5),
                ],
              );
            }),

            sh20,

            /// --------------------------
            /// SAVE BUTTON
            /// --------------------------
            Obx(
              () => galleryController.isLoading.value
                  ? CustomLoader(color: AppColors.white)
                  : CustomButton(
                      text: 'Save All Photos',
                      onPressed: () async {
                        if (galleryController.selectedCategory.value.isEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                  'Please select a category before saving photos'),
                              backgroundColor: AppColors.orange,
                            ),
                          );
                          return;
                        }

                        final selectedTagId = tagsController.getTagIdByTitle(
                            galleryController.selectedCategory.value);

                        if (selectedTagId == null) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                  'Invalid tag selected. Please select a valid tag.'),
                              backgroundColor: AppColors.red,
                            ),
                          );
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
                        await galleryController.uploadBatchPhotos(
                            payload, context);

                        /// 💥 Optional Google Drive upload
                        if (uploadToGoogleDrive.value) {
                          try {
                            final AuthService auth = AuthService();
                            final driveService = DriveService();

                            /// Sign in if not already
                            await auth.signIn();

                            for (var file in uploadedFiles) {
                              final fileUrl = file["url"] as String;

                              /// Download the file temporarily
                              final tempFile =
                                  await galleryController.downloadFile(fileUrl);

                              /// Upload to Google Drive
                              final uploaded =
                                  await driveService.uploadFile(tempFile);

                              print("Uploaded to Drive: ${uploaded.id}");
                            }

                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                    'Photos uploaded to Google Drive successfully'),
                                backgroundColor: AppColors.green,
                              ),
                            );
                          } catch (e) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                    'Failed to upload to Google Drive: $e'),
                                backgroundColor: AppColors.red,
                              ),
                            );
                          }
                        }
                      },
                      gradientColors: AppColors.buttonColor,
                      borderRadius: 12,
                      height: 40.h,
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
