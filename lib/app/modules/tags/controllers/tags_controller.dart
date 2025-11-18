import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:foto_tidy/app/modules/profile/controllers/profile_controller.dart';
import 'package:foto_tidy/app/modules/profile/views/subscription_view.dart';
import 'package:foto_tidy/common/app_images/app_images.dart';
import 'package:foto_tidy/common/widgets/popup_helper.dart';
import 'package:get/get.dart';

import '../../../../common/app_color/app_colors.dart';
import '../../../../common/app_constant/app_constant.dart';
import '../../../../common/helper/local_store.dart';
import '../../../../common/widgets/custom_snackbar.dart';
import '../../../data/api.dart';
import '../../../data/base_client.dart';
import '../model/all_tags_model.dart';

class TagsController extends GetxController {
  var isLoading = false.obs;
  var tags = <String>[].obs;
  var allTagsList = <TagsDatum>[].obs;
  final ProfileController profileController = Get.find();

  @override
  void onInit() {
    super.onInit();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      fetchAllTags();
    });
  }
  bool addTag(String tagName) {
    if (tagName.trim().isNotEmpty) {
      if (tags.length >= 5) {
        PopupHelper.showCustomPopup(
          title: 'Unlock Unlimited Tags',
          description:
              'Go Pro to add more than 5 tag.Organize your photos better with unlimited tags. Upgrade to Pro for advanced features!',
          iconPath: AppImages.crownCircle,
          onPrimaryPressed: () {
            Get.back();
            Get.to(() => SubscriptionView());
          },
          primaryButtonText: 'Upgrade to Pro',
          onSecondaryPressed: () {
            Get.back();
          },
          secondaryButtonText: 'Maybe Later',
        );
        return false; // not added
      }
      tags.add(tagName.trim());
      return true; // added
    }
    return false;
  }

  void removeTag(int index) {
    if (index >= 0 && index < tags.length) {
      tags.removeAt(index);
    }
  }

  void updateTag(int index, String newTagName) {
    if (newTagName.trim().isNotEmpty && index >= 0 && index < tags.length) {
      tags[index] = newTagName.trim();
    }
  }

  String? getTagIdByTitle(String title) {
    try {
      return allTagsList.firstWhere((t) => t.title == title).id.toString();
    } catch (e) {
      return null;
    }
  }


  Future<void> fetchAllTags() async {
    try {
      isLoading(true);
      String accessToken =
          LocalStorage.getData(key: AppConstant.accessToken)?.toString() ?? "";
      if (accessToken.isEmpty) {
        kSnackBar(message: "User not authenticated", bgColor: AppColors.orange);
        return;
      }
      var response = await BaseClient.getRequest(
        api: Api.allTags,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': accessToken,
        },
      );

      var data = await BaseClient.handleResponse(response);
      if (data != null && data['success'] == true) {
        var model = AllTagsModel.fromJson(data);
        allTagsList.value = model.data;
      } else {
        kSnackBar(
            message: data['message'] ?? 'Failed to load tags',
            bgColor: AppColors.orange);
      }
    } catch (e) {
      kSnackBar(message: e.toString(), bgColor: AppColors.orange);
    } finally {
      isLoading(false);
    }
  }

  Future<bool> addTags({required String title}) async {
    try {
      isLoading(true);

      //String authorId = profileController.profileData.value?.data?.id ?? '';
      String token = LocalStorage.getData(key: AppConstant.accessToken)?.toString() ?? '';

      var map = {
        "title": title,
      };

      var headers = {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
        'Authorization': token,
      };

      var response = await BaseClient.postRequest(
        api: Api.addTags,
        body: jsonEncode(map),
        headers: headers,
      );

      dynamic responseBody = await BaseClient.handleResponse(response);
      if (responseBody != null && responseBody['success'] == true) {
        kSnackBar(
          message: responseBody['message'] ?? "Tag added successfully",
          bgColor: AppColors.green,
        );
        return true;
      } else {
        kSnackBar(
          message: responseBody?['message'] ?? "Failed to add tag",
          bgColor: AppColors.orange,
        );
        return false;
      }
    } catch (e) {
      debugPrint("Catch Error:::::: $e");
      kSnackBar(message: e.toString(), bgColor: AppColors.orange);
      return false;
    } finally {
      isLoading(false);
    }
  }

  Future<bool> editTag({required String tagId,required String title}) async {
    try {
      isLoading(true);

      //String authorId = profileController.profileData.value?.data?.id ?? '';
      String token = LocalStorage.getData(key: AppConstant.accessToken)?.toString() ?? '';

      var map = {
        "title": title,
      };

      var headers = {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
        'Authorization': token,
      };

      var response = await BaseClient.putRequest(
        api: Api.editTag(tagId),
        body: jsonEncode(map),
        headers: headers,
      );

      dynamic responseBody = await BaseClient.handleResponse(response);
      if (responseBody != null && responseBody['success'] == true) {
        kSnackBar(
          message: responseBody['message'] ?? "Tag edit successfully",
          bgColor: AppColors.green,
        );

        // Refresh list after editing
        await fetchAllTags();
        return true;
      } else {
        kSnackBar(
          message: responseBody?['message'] ?? "Failed to edit tag",
          bgColor: AppColors.orange,
        );
        return false;
      }
    } catch (e) {
      debugPrint("Catch Error:::::: $e");
      kSnackBar(message: e.toString(), bgColor: AppColors.orange);
      return false;
    } finally {
      isLoading(false);
    }
  }
}
