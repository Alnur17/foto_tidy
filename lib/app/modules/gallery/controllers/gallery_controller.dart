import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import '../../../../common/app_color/app_colors.dart';
import '../../../../common/app_constant/app_constant.dart';
import '../../../../common/helper/local_store.dart';
import '../../../data/api.dart';
import '../../../data/base_client.dart';
import '../../home/views/photo_saved_successfully_view.dart';
import '../model/gallery_model.dart';

class GalleryController extends GetxController {
  /// Observables
  var isLoading = false.obs;
  var selectedCategory = ''.obs;
  var galleryList = <GalleryDatum>[].obs;


  @override
  void onInit() {
    super.onInit();
    fetchMyGallery();
  }

  /// Fetch user's full gallery
  Future<void> fetchMyGallery() async {
    await _fetchGallery(apiUrl: Api.myGallery);
  }

  /// Fetch gallery by tag ID (from API)
  Future<void> fetchPhotosByTagId(String tagId) async {
    await _fetchGallery(apiUrl: Api.getPhotoByTagId(tagId));
  }

  /// Shared internal fetch method
  Future<void> _fetchGallery({required String apiUrl}) async {
    try {
      isLoading(true);
      final accessToken =
          LocalStorage.getData(key: AppConstant.accessToken)?.toString() ?? "";

      if (accessToken.isEmpty) {
        Get.snackbar(
          'Empty',
          "User not authenticated",
          backgroundColor: AppColors.orange,
        );
        return;
      }

      final response = await BaseClient.getRequest(
        api: apiUrl,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': accessToken,
        },
      );

      final data = await BaseClient.handleResponse(response);

      if (data != null && data['success'] == true) {
        final model = GalleryModel.fromJson(data);
        galleryList.assignAll(model.data);
      } else {
        galleryList.clear();
        Get.snackbar(
          'Failed',
          data?['message'] ?? 'Failed to load gallery images',
          backgroundColor: AppColors.orange,
        );

      }
    } catch (e) {
      galleryList.clear();
      Get.snackbar(
        'Error',
        e.toString(),
        backgroundColor: AppColors.orange,
      );
    } finally {
      isLoading(false);
    }
  }

  Future<void> uploadBatchPhotos(
      List<Map<String, dynamic>> payload, context)
  async {
    try {
      isLoading(true);

      final accessToken =
          LocalStorage.getData(key: AppConstant.accessToken)?.toString() ?? "";

      if (accessToken.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('User not authenticated'),
            backgroundColor: AppColors.orange,
          ),
        );
        return;
      }

      /// BODY MUST BE JSON STRING
      final rawBody = jsonEncode({
        "data": payload,
      });

      final response = await BaseClient.postRequest(
        api: Api.uploadBadgePhotos,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': accessToken,
        },
        body: rawBody,
      );

      final data = await BaseClient.handleResponse(response);

      if (data != null && data['success'] == true) {
        Get.to(() => PhotoSavedSuccessfullyView());

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('${data['message']} Uploaded successfully!'),
            backgroundColor: AppColors.green,
          ),
        );

        fetchMyGallery();
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('${data?['message']} Failed to upload photos'),
            backgroundColor: AppColors.orange,
          ),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('$e'),
          backgroundColor: AppColors.orange,
        ),
      );
    } finally {
      isLoading(false);
    }
  }

  /// Select category (tag) — updated to fetch from API instead of filtering locally
  Future<void> selectCategory(String tagId, String tagName) async {
    if (selectedCategory.value == tagName) {
      selectedCategory.value = '';
      await fetchMyGallery();
    } else {
      selectedCategory.value = tagName;
      await fetchPhotosByTagId(tagId);
    }
  }


  Future<File> downloadFile(String url) async {
    final response = await http.get(Uri.parse(url));
    final tempDir = await getTemporaryDirectory();
    final file = File('${tempDir.path}/${DateTime.now().millisecondsSinceEpoch}.jpg');
    await file.writeAsBytes(response.bodyBytes);
    return file;
  }

}
