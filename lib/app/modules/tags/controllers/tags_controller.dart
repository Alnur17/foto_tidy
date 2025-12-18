import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:foto_tidy/app/modules/profile/controllers/profile_controller.dart';
import 'package:foto_tidy/app/modules/profile/views/subscription_view.dart';
import 'package:foto_tidy/common/app_images/app_images.dart';
import 'package:foto_tidy/common/widgets/popup_helper.dart';
import 'package:get/get.dart';

import '../../../../common/app_color/app_colors.dart';
import '../../../../common/app_constant/app_constant.dart';
import '../../../../common/helper/local_store.dart';
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

    fetchAllTags();
  }

  bool addTag(String tagName, {BuildContext? context}) {
    if (tagName.trim().isNotEmpty) {
      if (tags.length >= 5) {
        if (context != null) {
          PopupHelper.showCustomPopup(
            title: 'Unlock Unlimited Tags',
            description:
                'Go Pro to add more than 5 tag. Organize your photos better with unlimited tags. Upgrade to Pro for advanced features!',
            iconPath: AppImages.crownCircle,
            onPrimaryPressed: () {
              Navigator.pop(context);
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => SubscriptionView()));
            },
            primaryButtonText: 'Upgrade to Pro',
            onSecondaryPressed: () {
              Navigator.pop(context);
            },
            secondaryButtonText: 'Maybe Later',
          );
        }
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

  Future<void> fetchAllTags({BuildContext? context}) async {
    try {
      isLoading(true);
      String accessToken =
          LocalStorage.getData(key: AppConstant.accessToken)?.toString() ?? "";
      if (accessToken.isEmpty) {
        if (context != null) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text("User not authenticated"),
              backgroundColor: AppColors.orange,
            ),
          );
        }
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
      } else if (context != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(data['message'] ?? 'Failed to load tags'),
            backgroundColor: AppColors.orange,
          ),
        );
      }
    } catch (e) {
      if (context != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(e.toString()),
            backgroundColor: AppColors.orange,
          ),
        );
      }
    } finally {
      isLoading(false);
    }
  }

  Future<bool> addTags(
      {required String title, required BuildContext context}) async {
    try {
      isLoading(true);

      String token =
          LocalStorage.getData(key: AppConstant.accessToken)?.toString() ?? '';

      var map = {"title": title};

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
        await fetchAllTags(context: context);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(responseBody['message'] ?? "Tag added successfully"),
            backgroundColor: Colors.green,
          ),
        );
        return true;
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(responseBody['message'] ?? "Failed to add tag"),
            backgroundColor: Colors.orange,
          ),
        );
        return false;
      }
    } catch (e) {
      debugPrint("Catch Error:::::: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(e.toString()),
          backgroundColor: Colors.orange,
        ),
      );
      return false;
    } finally {
      isLoading(false);
    }
  }

  Future<bool> editTag({
    required String tagId,
    required String title,
    required BuildContext context,
  }) async {
    try {
      isLoading(true);

      String token =
          LocalStorage.getData(key: AppConstant.accessToken)?.toString() ?? '';

      var map = {"title": title};

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
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(responseBody['message'] ?? "Tag edited successfully"),
            backgroundColor: Colors.green,
          ),
        );
        await fetchAllTags(context: context);
        return true;
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(responseBody['message'] ?? "Failed to edit tag"),
            backgroundColor: Colors.orange,
          ),
        );
        return false;
      }
    } catch (e) {
      debugPrint("Catch Error:::::: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(e.toString()),
          backgroundColor: Colors.orange,
        ),
      );
      return false;
    } finally {
      isLoading(false);
    }
  }

  Future<void> transferPhotoFormTag({
    required String formTagId,
    required String toTagId,
    required BuildContext context,
  })
  async {
    try {
      isLoading(true);

      String token =
          LocalStorage.getData(key: AppConstant.accessToken)?.toString() ?? '';

      var map = {"tag": toTagId};

      var headers = {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
        'Authorization': token,
      };

      var response = await BaseClient.patchRequest(
        api: Api.transferPhotoFormTag(formTagId),
        body: jsonEncode(map),
        headers: headers,
      );

      dynamic responseBody = await BaseClient.handleResponse(response);
      if (responseBody != null && responseBody['success'] == true) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content:
                Text(responseBody['message'] ?? "Photo transfer successfully"),
            backgroundColor: Colors.green,
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content:
                Text(responseBody['message'] ?? "Failed to transfer photo"),
            backgroundColor: Colors.orange,
          ),
        );
      }
    } catch (e) {
      debugPrint("Catch Error:::::: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(e.toString()),
          backgroundColor: Colors.orange,
        ),
      );
    } finally {
      isLoading(false);
    }
  }

  Future<bool> deleteTag({
    required String tagId,
    required BuildContext context,
  }) async {
    try {
      isLoading(true);

      String token =
          LocalStorage.getData(key: AppConstant.accessToken)?.toString() ?? '';

      var headers = {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
        'Authorization': token,
      };

      var response = await BaseClient.deleteRequest(
        api: Api.deleteTag(tagId),
        headers: headers,
      );

      dynamic responseBody = await BaseClient.handleResponse(response);

      if (responseBody != null && responseBody['success'] == true) {
        await fetchAllTags(context: context);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Tag deleted successfully"),
            backgroundColor: Colors.green,
          ),
        );
        return true;
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Failed to delete tag"),
            backgroundColor: Colors.orange,
          ),
        );
        return false;
      }
    } catch (e) {
      debugPrint("Catch Error:::::: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(e.toString()),
          backgroundColor: Colors.orange,
        ),
      );
      return false;
    } finally {
      isLoading(false);
    }
  }
}
