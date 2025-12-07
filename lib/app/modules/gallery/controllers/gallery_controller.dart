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


  /// FILTERS
  var selectedDate = Rx<DateTime?>(null);
  var selectedSort = "Newest First".obs;

  /// Formatted date
  String get formattedSelectedDate {
    final date = selectedDate.value;
    if (date == null) return '';
    return "${date.day.toString().padLeft(2, '0')}/${date.month.toString().padLeft(2, '0')}/${date.year}";
  }

  /// Reset filters
  void resetFilters() {
    selectedDate.value = null;
    selectedSort.value = "Newest First";
    fetchMyGallery();
  }

  /// Apply filters
  void applyFilters() {
    fetchMyGallery(
      date: selectedDate.value,
      sort: selectedSort.value,
    );
  }

  @override
  void onInit() {
    super.onInit();
    fetchMyGallery();
  }

  /// Public fetch: includes optional filter params
  Future<void> fetchMyGallery({
    DateTime? date,
    String? sort,
  }) async {
    await _fetchGallery(
      apiUrl: Api.myGallery,
      date: date,
      sort: sort,
    );
  }

  /// Fetch images by Tag ID
  Future<void> fetchPhotosByTagId(String tagId) async {
    await _fetchGallery(apiUrl: Api.getPhotoByTagId(tagId));
  }

  /// Main internal fetch with optional parameters
  Future<void> _fetchGallery({
    required String apiUrl,
    DateTime? date,
    String? sort,
  }) async {
    try {
      isLoading(true);

      final accessToken =
          LocalStorage.getData(key: AppConstant.accessToken)?.toString() ?? "";

      if (accessToken.isEmpty) {
        Get.snackbar('Error', "User not authenticated",
            backgroundColor: AppColors.orange);
        return;
      }

      // -----------------------------------------
      // BUILD QUERY PARAMS
      // -----------------------------------------
      Map<String, String> queryParams = {};

      if (date != null) {
        queryParams['date'] =
        "${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}";
      }

      if (sort != null && sort.isNotEmpty) {
        queryParams['sort'] =
        sort == "Newest First" ? "-createdAt" : "createdAt";
      }

      // Append params only when needed
      if (queryParams.isNotEmpty) {
        final qp = Uri(queryParameters: queryParams).query;
        apiUrl = "$apiUrl?$qp";
      }

      // -----------------------------------------
      // SEND REQUEST
      // -----------------------------------------
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
        Get.snackbar('Failed',
            data?['message'] ?? 'Failed to load gallery images',
            backgroundColor: AppColors.orange);
      }
    } catch (e) {
      galleryList.clear();
      Get.snackbar('Error', e.toString(), backgroundColor: AppColors.orange);
    } finally {
      isLoading(false);
    }
  }

  Future<void> uploadSinglePhoto({
    required String tag,
    required String imageUrl,
    required double fileSize,
    required BuildContext context,
  }) async {
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

      /// Prepare request body
      final rawBody = jsonEncode({
        "tag": tag,
        "image": imageUrl,
        "fileSize": fileSize,
      });

      final response = await BaseClient.postRequest(
        api: Api.uploadSinglePhotos,
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
            content: Text('${data['message']}'),
            backgroundColor: AppColors.green,
          ),
        );

        fetchMyGallery();
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('${data?['message'] ?? 'Failed to upload photo'}'),
            backgroundColor: AppColors.orange,
          ),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(e.toString()),
          backgroundColor: AppColors.orange,
        ),
      );
    } finally {
      isLoading(false);
    }
  }


  Future<void> deleteSinglePhoto({
    required String photoId,
    required BuildContext context,
  }) async {
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

      final response = await BaseClient.deleteRequest(
        api: Api.deletePhoto(photoId),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': accessToken,
        },
      );

      final data = await BaseClient.handleResponse(response);

      if (data != null && data['success'] == true) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('${data['message']}'),
            backgroundColor: AppColors.green,
          ),
        );
        fetchMyGallery();
        Get.back();
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('${data?['message'] ?? 'Failed to upload photo'}'),
            backgroundColor: AppColors.orange,
          ),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(e.toString()),
          backgroundColor: AppColors.orange,
        ),
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
