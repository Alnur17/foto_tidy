import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mime/mime.dart';

import '../../../../common/app_color/app_colors.dart';
import '../../../../common/app_constant/app_constant.dart';
import '../../../../common/app_images/app_images.dart';
import '../../../../common/helper/local_store.dart';
import '../../../data/api.dart';
import '../../../data/base_client.dart';
import '../model/profile_model.dart';

class ProfileController extends GetxController {
  RxBool isLoading = false.obs;
  RxBool isFirstTimeLock = false.obs;
  Rx<File?> selectedImage = Rx<File?>(null);
  Rx<ProfileModel?> profileData = Rx<ProfileModel?>(null);
  RxString profileImageUrl = AppImages.profileImage.obs;

  final ImagePicker _picker = ImagePicker();

  final TextEditingController nameTEController = TextEditingController();
  final TextEditingController emailTEController = TextEditingController();
  final TextEditingController contactTEController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    fetchProfile();
  }

  Future<void> pickImageFromGallery() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      selectedImage.value = File(pickedFile.path);
    }
  }

  void saveProfileChanges() {
    if (selectedImage.value != null) {
      profileImageUrl.value = selectedImage.value!.path;
    }
  }

  Future<void> fetchProfile() async {
    try {
      isLoading.value = true;

      final token =
          LocalStorage.getData(key: AppConstant.accessToken)?.toString() ?? "";
      if (token.isEmpty) {
        print("❌ No token found");
        return;
      }

      final headers = <String, String>{
        'Content-Type': 'application/json',
        'Authorization': token,
      };

      final response = await BaseClient.getRequest(
        api: Api.profile,
        headers: headers,
      );

      final data = await BaseClient.handleResponse(response);

      profileData.value = ProfileModel.fromJson(data);

      if (profileData.value?.data?.photoUrl != null) {
        profileImageUrl.value = profileData.value!.data!.photoUrl!.toString();
        print("🟠 Photo URL: ${profileImageUrl.value}");
      }

      print("✅ Profile fetched successfully");
    } catch (e) {
      print("❌ Profile fetch error: $e");
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> updateProfile(BuildContext context) async {
    try {
      isLoading.value = true;
      String accessToken =
          LocalStorage.getData(key: AppConstant.accessToken)?.toString() ?? "";
      if (accessToken.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("User not authenticated"),
            backgroundColor: AppColors.orange,
          ),
        );
        return;
      }

      var request = http.MultipartRequest('PUT', Uri.parse(Api.editProfile));

      request.headers.addAll({
        'Authorization': accessToken,
        'Content-Type': 'multipart/form-data',
      });

      // Add JSON payload as text
      Map<String, dynamic> data = {
        "name": nameTEController.text.trim(),
        "email": emailTEController.text.trim(),
        "contractNumber": contactTEController.text.trim(),
      };

      request.fields['data'] = jsonEncode(data);

      // Handle Image Upload
      if (selectedImage.value != null) {
        String imagePath = selectedImage.value!.path;
        String? mimeType = lookupMimeType(imagePath) ?? 'image/jpeg';

        request.files.add(
          await http.MultipartFile.fromPath(
            'image',
            imagePath,
            contentType: MediaType.parse(mimeType), //from http_parser package
          ),
        );
      }

      var response = await request.send();
      var responseData = await response.stream.bytesToString();

      try {
        var decodedResponse = json.decode(responseData);

        if (response.statusCode == 200) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text("Profile updated successfully"),
              backgroundColor: AppColors.green,
            ),
          );

          await fetchProfile();
          update();
          if (Get.context != null) {
            Navigator.pop(Get.context!);
          }
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(decodedResponse['message'] ?? "Failed to update profile"),
              backgroundColor: AppColors.orange,
            ),
          );
        }
      } catch (decodeError) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Catch Error: $decodeError"),
            backgroundColor: AppColors.orange,
          ),
        );
        debugPrint("Response Error: $decodeError");
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Error updating profile: $e"),
          backgroundColor: AppColors.orange,
        ),
      );
      debugPrint("Update Error: $e");
    } finally {
      isLoading.value = false;
    }
  }

  int getTrialRemainingDays() {
    final exp = profileData.value?.data?.freeTrialExpiry;
    if (exp == null) return 0;

    final now = DateTime.now();
    return exp.difference(now).inDays;
  }
}
