import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:foto_tidy/common/app_images/app_images.dart';
import 'package:foto_tidy/common/app_text_style/styles.dart';
import 'package:foto_tidy/common/size_box/custom_sizebox.dart';
import 'package:foto_tidy/common/widgets/custom_button.dart';
import 'package:foto_tidy/common/widgets/custom_textfield.dart';
import 'package:get/get.dart';
import '../../../../common/app_color/app_colors.dart';
import '../../../../common/widgets/popup_helper.dart';
import '../controllers/tags_controller.dart';

class TagsView extends StatefulWidget {
  const TagsView({super.key});

  @override
  State<TagsView> createState() => _TagsViewState();
}

class _TagsViewState extends State<TagsView> {
  final TagsController tagsController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Tags', style: appBarStyle),
            CustomButton(
              text: 'Add Tag',
              onPressed: () => _showAddTagDialog(context),
              imageAssetPath: AppImages.add,
              width: 130.w,
              height: 38.h,
              gradientColors: AppColors.buttonColor,
            ),
          ],
        ),
      ),
      body: Obx(() {
        if (tagsController.isLoading.value) {
          return const Center(
              child: CircularProgressIndicator(
                color: AppColors.orange,
              ));
        }

        final tags = tagsController.allTagsList;

        if (tags.isEmpty) {
          return const Center(child: Text("No tags found"));
        }

        return ListView.builder(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
          itemCount: tags.length,
          itemBuilder: (context, index) {
            final tag = tags[index];
            return Container(
              margin: EdgeInsets.only(bottom: 12.h),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: AppColors.borderColor),
                color: AppColors.white,
              ),
              child: ListTile(
                title: Text(tag.title ?? ''),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    GestureDetector(
                      onTap: () =>
                          _showEditTagDialog(context, tag.title ?? '', index),
                      child: Image.asset(AppImages.editCircle, scale: 4),
                    ),
                    sw16,
                    GestureDetector(
                      onTap: () => PopupHelper.showConfirmationDialog(
                        title: 'Where to go?',
                        description:
                        'Do you want to transfer photos before delete this tag?',
                        confirmText: 'Transfer File',
                        onConfirm: () =>
                            _showTransferPhotoDialog(context, tag.title ?? ''),
                        confirmColor: AppColors.green,
                        cancelText: 'Continue deleting',
                        onCancel: () =>
                            _showDeleteTagDialog(context, tag.title ?? ''),
                        cancelColor: AppColors.red,
                      ),
                      child: Image.asset(AppImages.deleteCircle, scale: 4),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      }),
    );
  }

  /// Dialog to add a tag
  void _showAddTagDialog(BuildContext context) {
    final TextEditingController tagController = TextEditingController();

    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: AppColors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Add Tag', style: appBarStyle),
              CloseButton(onPressed: () => Navigator.pop(context)),
            ],
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Tag Name', style: h4),
              sh8,
              CustomTextField(
                controller: tagController,
                hintText: "Enter Tag Name",
                borderRadius: 8,
              ),
            ],
          ),
          actions: [
            Obx(() {
              return CustomButton(
                text: tagsController.isLoading.value ? "Adding..." : "Add",
                onPressed: tagsController.isLoading.value
                    ? () {}
                    : () async {
                  final title = tagController.text.trim();
                  if (title.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text("Please enter a tag name"),
                        backgroundColor: AppColors.orange,
                      ),
                    );
                    return;
                  }

                  final success = await tagsController.addTags(
                      title: title, context: context);

                  if (success) {
                    Navigator.pop(context);
                  }
                },
                borderRadius: 12,
                gradientColors: AppColors.buttonColor,
              );
            }),
          ],
        );
      },
    );
  }

  /// Delete confirmation dialog
  void _showDeleteTagDialog(BuildContext context, String tagName) {
    final tag =
    tagsController.allTagsList.firstWhere((t) => t.title == tagName);

    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          backgroundColor: AppColors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: Padding(
            padding: EdgeInsets.all(20.w),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset(AppImages.deleteCircle, height: 60.h, width: 60.w),
                sh16,
                Text('Delete Tag?', style: h3),
                Text(
                  "Are you sure you want to delete the tag '$tagName'? This action cannot be undone.",
                  textAlign: TextAlign.center,
                  style: h4.copyWith(fontWeight: FontWeight.w500),
                ),
                sh20,
                Obx(() {
                  return CustomButton(
                    text: tagsController.isLoading.value ? "Deleting..." : "Delete",
                    backgroundColor: AppColors.red,
                    textColor: AppColors.white,
                    borderRadius: 12,
                    onPressed: tagsController.isLoading.value
                        ? () {}
                        : () async {
                      bool success = await tagsController.deleteTag(
                          tagId: tag.id.toString(), context: context);

                      if (success) {
                        Navigator.pop(context);
                      }
                    },
                  );
                }),
                sh12,
                CustomButton(
                  text: "Cancel",
                  borderRadius: 12,
                  backgroundColor: AppColors.silver,
                  textColor: AppColors.black,
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  /// Edit dialog
  void _showEditTagDialog(BuildContext context, String oldTag, int index) {
    final tag = tagsController.allTagsList[index];
    final TextEditingController tagController =
    TextEditingController(text: oldTag);

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: AppColors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          title: Text('Edit Tag', style: appBarStyle),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Tag Name', style: h4),
              sh8,
              CustomTextField(
                controller: tagController,
                hintText: "Enter Tag Name",
                borderRadius: 8,
              ),
            ],
          ),
          actions: [
            Obx(() {
              return CustomButton(
                text: tagsController.isLoading.value ? "Updating..." : "Update",
                onPressed: tagsController.isLoading.value
                    ? () {}
                    : () async {
                  final newTitle = tagController.text.trim();
                  if (newTitle.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text("Please enter a tag name"),
                        backgroundColor: AppColors.orange,
                      ),
                    );
                    return;
                  }

                  await tagsController.editTag(
                    tagId: tag.id ?? '',
                    title: newTitle,
                    context: context,
                  );

                  Navigator.pop(context);
                },
                borderRadius: 12,
                gradientColors: AppColors.buttonColor,
              );
            }),
          ],
        );
      },
    );
  }

  /// Transfer Photo dialog
  void _showTransferPhotoDialog(BuildContext context, String currentTag) {
    final RxString selectedTag = ''.obs;
    final tags = tagsController.allTagsList.map((e) => e.title ?? '').toList();

    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return Dialog(
          backgroundColor: AppColors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.r),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 20.h),
            child: Obx(() {
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.asset(
                    AppImages.transferFile,
                    height: 60.h,
                    width: 60.w,
                  ),
                  SizedBox(height: 12.h),
                  Text(
                    "Transfer photo",
                    style: h3.copyWith(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8.h),
                  Text(
                    "Select tag for transfer this photos",
                    textAlign: TextAlign.center,
                    style: h4.copyWith(
                      color: AppColors.grey,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: 20.h),
                  Wrap(
                    spacing: 8.w,
                    runSpacing: 10.h,
                    alignment: WrapAlignment.center,
                    children: tags.map((tag) {
                      final isSelected = selectedTag.value == tag;
                      return GestureDetector(
                        onTap: () => selectedTag.value = tag,
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 14.w,
                            vertical: 8.h,
                          ),
                          decoration: BoxDecoration(
                            color:
                            isSelected ? AppColors.orange : AppColors.silver,
                            borderRadius: BorderRadius.circular(20.r),
                          ),
                          child: Text(
                            tag,
                            style: TextStyle(
                              color:
                              isSelected ? AppColors.white : AppColors.black,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                  SizedBox(height: 24.h),
                  Row(
                    children: [
                      Expanded(
                        child: CustomButton(
                          text: "Cancel",
                          onPressed: () => Navigator.pop(context),
                          borderRadius: 12,
                          backgroundColor: AppColors.silver,
                          textColor: AppColors.black,
                          height: 44.h,
                        ),
                      ),
                      SizedBox(width: 12.w),
                      Expanded(
                        child: CustomButton(
                          text: "Confirmed",
                          onPressed: () {
                            if (selectedTag.value.isEmpty) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content:
                                  Text("Please select a tag to transfer"),
                                  backgroundColor: AppColors.orange,
                                ),
                              );
                              return;
                            }
                            Navigator.pop(context);
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                    "Photos transferred to ${selectedTag.value} successfully"),
                                backgroundColor: AppColors.green,
                              ),
                            );
                          },
                          borderRadius: 12,
                          backgroundColor: AppColors.green,
                          textColor: AppColors.white,
                          height: 44.h,
                        ),
                      ),
                    ],
                  ),
                ],
              );
            }),
          ),
        );
      },
    );
  }
}

