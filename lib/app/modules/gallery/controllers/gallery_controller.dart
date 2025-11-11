import 'package:get/get.dart';
import '../../../../common/app_color/app_colors.dart';
import '../../../../common/app_constant/app_constant.dart';
import '../../../../common/helper/local_store.dart';
import '../../../../common/widgets/custom_snackbar.dart';
import '../../../data/api.dart';
import '../../../data/base_client.dart';
import '../model/gallery_model.dart';

class GalleryController extends GetxController {
  /// Observables
  var isLoading = false.obs;
  var selectedCategory = ''.obs;
  var galleryList = <GalleryDatum>[].obs;

  /// Optional flags
  var isProUser = true.obs;
  var isGalleryLocked = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchMyGallery();
  }

  /// Fetch user's gallery from API
  Future<void> fetchMyGallery() async {
    try {
      isLoading(true);
      final accessToken =
          LocalStorage.getData(key: AppConstant.accessToken)?.toString() ?? "";

      if (accessToken.isEmpty) {
        kSnackBar(
          message: "User not authenticated",
          bgColor: AppColors.orange,
        );
        return;
      }

      final response = await BaseClient.getRequest(
        api: Api.myGallery,
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
        kSnackBar(
          message: data?['message'] ?? 'Failed to load gallery images',
          bgColor: AppColors.orange,
        );
      }
    } catch (e) {
      galleryList.clear();
      kSnackBar(message: e.toString(), bgColor: AppColors.orange);
    } finally {
      isLoading(false);
    }
  }

  /// Select a category (tag)
  void selectCategory(String category) {
    if (selectedCategory.value == category) {
      selectedCategory.value = '';
      fetchMyGallery(); // reset
    } else {
      selectedCategory.value = category;
      filterByTag(category);
    }
  }

  /// Filter gallery by tag
  void filterByTag(String tag) {
    if (tag.isEmpty || tag == 'All') {
      fetchMyGallery();
      return;
    }

    final filtered = galleryList
        .where((item) =>
    item.tag?.title?.toLowerCase().contains(tag.toLowerCase()) ?? false)
        .toList();

    galleryList.assignAll(filtered);
  }
}
