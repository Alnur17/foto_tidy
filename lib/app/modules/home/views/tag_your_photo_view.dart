import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:foto_tidy/app/modules/tags/controllers/tags_controller.dart';

import 'package:get/get.dart';

import '../../../../common/app_color/app_colors.dart';
import '../../../../common/app_text_style/styles.dart';
import '../../../../common/helper/custom_filter_chip.dart';
import '../../../../common/size_box/custom_sizebox.dart';
import '../../../../common/widgets/custom_button.dart';
import '../../gallery/controllers/gallery_controller.dart';

class TagYourPhotoView extends StatefulWidget {
  final String imagePath;

  const TagYourPhotoView({super.key, required this.imagePath});

  @override
  State<TagYourPhotoView> createState() => _TagYourPhotoViewState();
}

class _TagYourPhotoViewState extends State<TagYourPhotoView> {
  final galleryController = Get.find<GalleryController>();
  final tagsController = Get.find<TagsController>();

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
            // Save button
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
                // final payload = uploadedFiles.map((file) {
                //   return {
                //     "tag": selectedTagId,
                //     "image": file["url"],
                //     "fileSize": file["size"] ?? 0.0,
                //   };
                // }).toList();

                /// 💥 Upload now
              //  await galleryController.uploadBatchPhotos(payload, context);

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

