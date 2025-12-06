import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:foto_tidy/app/data/api.dart';
import 'package:foto_tidy/app/modules/dashboard/views/dashboard_view.dart';
import 'package:foto_tidy/app/modules/profile/controllers/profile_controller.dart';
import 'package:foto_tidy/app/modules/profile/model/subscription_package_model.dart';
import 'package:get/get.dart';

import '../../../../common/app_color/app_colors.dart';
import '../../../../common/app_constant/app_constant.dart';
import '../../../../common/helper/local_store.dart';
import '../../../data/base_client.dart';
import '../model/current_subscription_model.dart';
import '../views/payment_view.dart';

class SubscriptionController extends GetxController {
  // State
  var isLoading = false.obs;
  var subscriptionPackageList = <SubsPackageDatum>[].obs;
  var mySubscription = Rxn<MySubscriptionModel>();

  // Selected package ID (for purchase flow)
  var selectedPackageId = RxnString();

  ProfileController profileController = Get.find<ProfileController>();

  late String userId = profileController.profileData.value?.data?.id ?? '';

  @override
  void onInit() {
    super.onInit();
    fetchSubscriptionPackages();
    fetchMySubscription();
  }

  // Group packages: { "pro_basic": [monthlyPkg, yearlyPkg], "pro_premium": [...] }
  Map<String, List<SubsPackageDatum>> get groupedPackages {
    final Map<String, List<SubsPackageDatum>> map = {};

    for (final pkg in subscriptionPackageList) {
      final key = pkg.type?.toLowerCase() ?? '';
      map.putIfAbsent(key, () => []).add(pkg);
    }
    return map;
  }

  // Get a specific variant (monthly or yearly) of a plan
  SubsPackageDatum? getPackage(String planType, bool isMonthly) {
    final pkgs = groupedPackages[planType.toLowerCase()] ?? [];
    return pkgs.firstWhereOrNull(
      (p) =>
          (p.billingCycle?.toLowerCase() == (isMonthly ? 'monthly' : 'yearly')),
    );
  }

  Future<void> fetchMySubscription() async {
    try {
      isLoading(true);

      String token = LocalStorage.getData(key: AppConstant.accessToken) ?? "";

      var response = await BaseClient.getRequest(
        api: Api.mySubscription,
        headers: {
          "Authorization": token,
          "Content-Type": "application/json",
        },
      );

      var data = await BaseClient.handleResponse(response);

      if (data != null && data['success'] == true) {
        mySubscription.value = MySubscriptionModel.fromJson(data);
      } else {
        mySubscription.value = null;
      }
    } catch (e) {
      debugPrint("Fetch My Subscription Error: $e");
      mySubscription.value = null;
    } finally {
      isLoading(false);
    }
  }

  Future<void> fetchSubscriptionPackages() async {
    try {
      isLoading(true);
      final accessToken =
          LocalStorage.getData(key: AppConstant.accessToken)?.toString() ?? "";

      if (accessToken.isEmpty) {
        Get.snackbar("Error", "User not authenticated",
            backgroundColor: AppColors.orange);
        return;
      }

      final response = await BaseClient.getRequest(
        api: Api.subscriptionPackages,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': accessToken,
        },
      );

      final data = await BaseClient.handleResponse(response);

      if (data != null && data['success'] == true) {
        final model = SubscriptionPackageModel.fromJson(data);
        subscriptionPackageList.assignAll(model.data);
      } else {
        subscriptionPackageList.clear();
        Get.snackbar("Error", data?['message'] ?? 'Failed to load packages');
      }
    } catch (e) {
      subscriptionPackageList.clear();
      debugPrint("Catch Error:::::: $e");
    } finally {
      isLoading(false);
    }
  }

  Future createSubscription({
    required String packageId,
  }) async
  {
    try {
      isLoading(true);
      String token =
          LocalStorage.getData(key: AppConstant.accessToken)?.toString() ?? "";

      var map = {
        "user": userId,
        "package": packageId,
      };

      var headers = {
        'Authorization': token,
        'Content-Type': 'application/json',
      };

      dynamic responseBody = await BaseClient.handleResponse(
        await BaseClient.postRequest(
            api: Api.buySubscription, body: jsonEncode(map), headers: headers),
      );

      if (responseBody != null) {
        final String subscriptionId = responseBody['data']['_id'].toString();
        createPaymentSession(subscriptionId: subscriptionId, userId: userId);
        isLoading.value = false;
      } else {
        Get.snackbar("Error", "Failed to create subscription");
      }
    } catch (e) {
      debugPrint("Catch Error:::::: $e");
    } finally {
      isLoading(false);
    }
  }

  Future<void> freeTrialSubscription() async {
    try {
      isLoading(true);
      String token =
          LocalStorage.getData(key: AppConstant.accessToken)?.toString() ?? "";

      var headers = {
        'Authorization': token,
        'Content-Type': 'application/json',
      };

      dynamic responseBody = await BaseClient.handleResponse(
        await BaseClient.patchRequest(
            api: Api.freeTrial, headers: headers),
      );

      if (responseBody['success'] == true) {
        final String message = responseBody['message'].toString();
        // createPaymentSession(subscriptionId: subscriptionId, userId: userId);
        ScaffoldMessenger.of(Get.context!).showSnackBar(
          SnackBar(
            content: Text(message),
            backgroundColor: AppColors.green,
          ),
        );
        fetchMySubscription();
        profileController.fetchProfile();
        isLoading.value = false;
      } else {
        ScaffoldMessenger.of(Get.context!).showSnackBar(
          SnackBar(
            content: Text(responseBody['message'].toString()),
            backgroundColor: AppColors.red,
          ),
        );
      }
    } catch (e) {
      debugPrint("Catch Error:::::: $e");
    } finally {
      isLoading(false);
    }
  }

  Future<void> createPaymentSession({
    required String userId,
    required String subscriptionId,
  }) async {
    isLoading.value = true;
    debugPrint(';;;;;;;;;;;;;;;;;; $subscriptionId ;;;;;;;;;;;;;;;;;;;');
    String token = LocalStorage.getData(key: AppConstant.accessToken);

    var headers = {
      'Authorization': token,
      'Content-Type': 'application/json',
    };

    var map = {"user": userId, "subscription": subscriptionId};

    dynamic responseBody = await BaseClient.handleResponse(
      await BaseClient.postRequest(
        api: Api.createPayment,
        body: jsonEncode(map),
        headers: headers,
      ),
    );

    if (responseBody != null) {
      Get.to(() => PaymentView(paymentUrl: responseBody["data"]));
      isLoading.value = false;
    } else {
      Get.snackbar("Error", "Failed to create payment session");
    }
  }

  Future<void> paymentResults({required String paymentLink}) async {
    try {
      isLoading.value = true;

      var headers = {
        'Content-Type': "application/json",
      };

      var response =
          await BaseClient.getRequest(api: paymentLink, headers: headers);

      var responseBody = await BaseClient.handleResponse(response);

      if (responseBody['success'] = true) {
        // var paymentId = responseBody['data']['_id'].toString();
        //
        // LocalStorage.saveData(key: AppConstant.paymentId, data: paymentId);
        // String id = LocalStorage.getData(key: AppConstant.paymentId);
        // debugPrint('::::::::::::::::: $id :::::::::::::::::');
        Get.offAll(() => DashboardView(), routeName: '/dashboard');
      } else {
        debugPrint("Error on Payment Result: $responseBody['message'] ");
      }
    } catch (e) {
      debugPrint("Error on Payment Result: $e");
      Get.snackbar(
        'Error',
        "Error on Payment Result: $e",
        backgroundColor: AppColors.orange,
      );
    } finally {
      isLoading.value = false;
    }
  }

  int getRemainingDays() {
    final exp = mySubscription.value?.data?.expiredAt;
    if (exp == null) return 0;

    final now = DateTime.now();
    return exp.difference(now).inDays;
  }
}
