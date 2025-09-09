import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:foto_tidy/common/app_images/app_images.dart';
import 'package:foto_tidy/common/app_text_style/styles.dart';
import 'package:foto_tidy/common/size_box/custom_sizebox.dart';
import 'package:foto_tidy/common/widgets/custom_button.dart';
import 'package:foto_tidy/common/widgets/custom_textfield.dart';
import 'package:get/get.dart';

import '../../../../common/app_color/app_colors.dart';
import '../controllers/tags_controller.dart';

class TagsView extends StatefulWidget {
  const TagsView({super.key});

  @override
  State<TagsView> createState() => _TagsViewState();
}

class _TagsViewState extends State<TagsView> {
  final TagsController tagsController = Get.put(TagsController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Tags',
              style: appBarStyle,
            ),
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
        return ListView.builder(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
          itemCount: tagsController.tags.length,
          itemBuilder: (context, index) {
            final tag = tagsController.tags[index];
            return Container(
              margin: EdgeInsets.only(bottom: 12.h),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: AppColors.borderColor),
                color: AppColors.white,
              ),
              child: ListTile(
                title: Text(tag),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Image.asset(AppImages.editCircle, scale: 4),
                    sw16,
                    GestureDetector(
                      onTap: () => _showDeleteTagDialog(context,tag),
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

  void _showAddTagDialog(BuildContext context) {
    final TextEditingController tagController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          title: Text('Add Tag', style: appBarStyle),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Tag Name',style: h4,),
              sh8,
              CustomTextField(
                controller: tagController,
                hintText: "Enter Tag Name",
                borderRadius: 8,
              ),
            ],
          ),
          actions: [
            CustomButton(
              text: "Add",
              onPressed: () {
                tagsController.addTag(tagController.text);
                Get.back(); // close dialog
              },
              borderRadius: 12,
              gradientColors: AppColors.buttonColor,
            ),
          ],
        );
      },
    );
  }

  void _showDeleteTagDialog(BuildContext context,String tag) {
    Get.dialog(
      Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        child: Padding(
          padding: EdgeInsets.all(20.w),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(
                AppImages.logoutBig,
                height: 60.h,
                width: 60.w,
              ),
              sh16,
              Text('Delete Tag?',style: h3,),
              Text(
                "Are you sure you want to delete this item? This action cannot be undone.",
                textAlign: TextAlign.center,
                style: h3.copyWith(fontWeight: FontWeight.w500),
              ),
              sh20,
              CustomButton(
                text: "Delete",
                borderRadius: 12,
                backgroundColor: AppColors.red,
                textColor: AppColors.white,
                onPressed: () {
                  tagsController.tags.remove(tag);
                  Get.back();
                },
              ),
              sh12,
              CustomButton(
                text: "Cancel",
                borderRadius: 12,
                backgroundColor: AppColors.silver,
                textColor: AppColors.black,
                onPressed: () {
                  Get.back();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

}
