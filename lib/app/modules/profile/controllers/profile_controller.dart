import 'dart:io';

import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../common/app_constant/app_constant.dart';
import '../../../../common/app_images/app_images.dart';
import '../../../../common/helper/local_store.dart';
import '../../../data/api.dart';
import '../../../data/base_client.dart';
import '../model/profile_model.dart';

class ProfileController extends GetxController {
  RxBool isLoading = false.obs;
  RxBool isProUser = true.obs;
  RxBool isFirstTimeLock = false.obs;
  Rx<File?> selectedImage = Rx<File?>(null);
  Rx<ProfileModel?> profileData = Rx<ProfileModel?>(null);
  RxString profileImageUrl = AppImages.profileImage.obs;

  final ImagePicker _picker = ImagePicker();

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

      final token = LocalStorage.getData(key: AppConstant.accessToken)?.toString() ?? "";
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
}