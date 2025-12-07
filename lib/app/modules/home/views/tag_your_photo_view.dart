import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:foto_tidy/app/modules/tags/controllers/tags_controller.dart';

import 'package:get/get.dart';

import '../../../../common/app_color/app_colors.dart';
import '../../../../common/app_images/app_images.dart';
import '../../../../common/app_text_style/styles.dart';
import '../../../../common/helper/custom_filter_chip.dart';
import '../../../../common/size_box/custom_sizebox.dart';
import '../../../../common/widgets/custom_button.dart';
import '../../../../common/widgets/custom_loader.dart';
import '../../gallery/controllers/gallery_controller.dart';
import '../../profile/controllers/profile_controller.dart';
import '../../services/auth_service.dart';
import '../../services/drive_service.dart';

class TagYourPhotoView extends StatefulWidget {
  final Map<String, dynamic> imagePath;

  const TagYourPhotoView({super.key, required this.imagePath});

  @override
  State<TagYourPhotoView> createState() => _TagYourPhotoViewState();
}

class _TagYourPhotoViewState extends State<TagYourPhotoView> {
  final galleryController = Get.find<GalleryController>();
  final tagsController = Get.find<TagsController>();
  final ProfileController profileController = Get.find();


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
            // Image display
            Container(
              height: 300.h,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16).r,
                color: AppColors.silver,
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16).r,
                child: Image.network(
                  widget.imagePath["url"],
                  fit: BoxFit.cover,
                  width: Get.width,
                  errorBuilder: (context, error, stackTrace) => const Center(
                    child: Text('Failed to load image'),
                  ),
                ),
              ),
            ),
            sh20,
            Text('Choose Tag', style: h3),
            sh12,
            // Category selection
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
            // Save button
        Obx(
              () => galleryController.isLoading.value
              ? CustomLoader(color: AppColors.white)
              :CustomButton(
              text: 'Save All Photos',
              onPressed: () async {
                if (galleryController.selectedCategory.value.isEmpty) {
                  Get.snackbar('No Category', 'Please select a category');
                  return;
                }

                final selectedTagId = tagsController
                    .getTagIdByTitle(galleryController.selectedCategory.value);

                if (selectedTagId == null) {
                  Get.snackbar('Error', 'Invalid tag selected');
                  return;
                }

                /// 💥 Upload now
                await galleryController.uploadSinglePhoto(
                  tag: selectedTagId,
                  imageUrl: widget.imagePath['url'],
                  fileSize: widget.imagePath["size"] ?? 0.0,
                  context: context,
                );

                /// 💥 Optional Google Drive upload
                if (uploadToGoogleDrive.value) {
                  try {
                    final AuthService auth = AuthService();
                    final driveService = DriveService();

                    /// Sign in if not already
                    await auth.signIn();


                      final fileUrl = widget.imagePath["url"] as String;

                      /// Download the file temporarily
                      final tempFile =
                      await galleryController.downloadFile(fileUrl);

                      /// Upload to Google Drive
                      final uploaded =
                      await driveService.uploadFile(tempFile);

                      print("Uploaded to Drive: ${uploaded.id}");


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
