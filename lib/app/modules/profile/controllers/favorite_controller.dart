import 'dart:convert';

import 'package:get/get.dart';

import '../../../../common/app_constant/app_constant.dart';
import '../../../../common/helper/local_store.dart';
import '../../../data/api.dart';
import '../../../data/base_client.dart';
import '../model/favorite_model.dart';

class FavoriteController extends GetxController {
  RxBool isFavoriteLoading = false.obs;
  Rx<FavoriteModel?> favoriteData = Rx<FavoriteModel?>(null);
  RxList<FavoriteDatum> favorites = <FavoriteDatum>[].obs;

  Future<void> addFavorite({required String userId, required String photoId}) async {
    try {
      isFavoriteLoading.value = true;

      final token = LocalStorage.getData(key: AppConstant.accessToken)?.toString() ?? "";
      if (token.isEmpty) {
        print("❌ No token found");
        return;
      }

      final headers = {
        'Content-Type': 'application/json',
        'Authorization': token,
      };

      final body = {
        "user": userId,
        "photo": photoId,
      };

      final response = await BaseClient.postRequest(
        api: Api.addFavorite,
        body: jsonEncode(body), // BaseClient will handle JSON
        headers: headers,
      );

      final data = await BaseClient.handleResponse(response);

      if (data != null) {
        print("✅ Favorite added successfully");
        // Refresh favorite list
        await fetchFavorites();
      } else {
        print("❌ Failed to add favorite");
      }
    } catch (e) {
      print("❌ Error adding favorite: $e");
    } finally {
      isFavoriteLoading.value = false;
    }
  }

  Future<void> removeFavorite({required String photoId}) async {
    try {
      isFavoriteLoading.value = true;

      final token = LocalStorage.getData(key: AppConstant.accessToken)?.toString() ?? "";
      if (token.isEmpty) {
        print("❌ No token found");
        return;
      }

      final headers = {
        'Content-Type': 'application/json',
        'Authorization': token,
      };

      final apiUrl = Api.removeFavorite(photoId);

      final response = await BaseClient.deleteRequest(
        api: apiUrl,
        headers: headers,
      );

      final data = await BaseClient.handleResponse(response);

      if (data != null) {
        print("✅ Favorite removed successfully");
        await fetchFavorites(); // optional refresh
      } else {
        print("❌ Failed to remove favorite");
      }
    } catch (e) {
      print("❌ Error removing favorite: $e");
    } finally {
      isFavoriteLoading.value = false;
    }
  }

  Future<void> fetchFavorites() async {
    try {
      isFavoriteLoading.value = true;

      final token = LocalStorage.getData(key: AppConstant.accessToken)?.toString() ?? "";
      if (token.isEmpty) {
        print("❌ No token found");
        return;
      }

      final headers = {
        'Content-Type': 'application/json',
        'Authorization': token,
      };

      final response = await BaseClient.getRequest(
        api: Api.favorite,
        headers: headers,
      );

      final data = await BaseClient.handleResponse(response);

      if (data == null) {
        print("❌ Favorite API returned null");
        return;
      }

      // Parse Model
      favoriteData.value = FavoriteModel.fromJson(data);

      // Update List
      favorites.value = favoriteData.value?.data ?? [];

      print("✅ Favorites fetched: ${favorites.length}");
    } catch (e) {
      print("❌ Error fetching favorites: $e");
    } finally {
      isFavoriteLoading.value = false;
    }
  }

}
