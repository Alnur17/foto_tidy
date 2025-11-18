// import 'package:foto_tidy/app/data/api.dart';
// import 'package:foto_tidy/app/modules/profile/model/subscription_package_model.dart';
// import 'package:get/get.dart';
//
// import '../../../../common/app_color/app_colors.dart';
// import '../../../../common/app_constant/app_constant.dart';
// import '../../../../common/helper/local_store.dart';
// import '../../../../common/widgets/custom_snackbar.dart';
// import '../../../data/base_client.dart';
//
// class SubscriptionController extends GetxController {
//   // Observable state
//   var isLoading = false.obs;
//   var subscriptionPackageList = <SubsPackageDatum>[].obs;
//
//   // Per-package toggle: packageId → isMonthly (true = monthly)
//   final Map<String, RxBool> _monthlySelected = {};
//
//   Map<String, RxBool> get monthlySelectedMap => _monthlySelected;
//
//   @override
//   void onInit() {
//     super.onInit();
//     fetchSubscriptionPackages();
//   }
//
//   // Toggle billing cycle for a specific package
//   void setBillingCycle(String packageId, bool isMonthly) {
//     _monthlySelected.putIfAbsent(packageId, () => true.obs);
//     _monthlySelected[packageId]!.value = isMonthly;
//   }
//
//   // Get current billing state
//   bool isMonthly(String packageId) {
//     return _monthlySelected[packageId]?.value ?? true;
//   }
//
//   // Fetch packages from API
//   Future<void> fetchSubscriptionPackages() async {
//     try {
//       isLoading(true);
//       final accessToken =
//           LocalStorage.getData(key: AppConstant.accessToken)?.toString() ?? "";
//
//       if (accessToken.isEmpty) {
//         kSnackBar(
//           message: "User not authenticated",
//           bgColor: AppColors.orange,
//         );
//         return;
//       }
//
//       final response = await BaseClient.getRequest(
//         api: Api.subscriptionPackages,
//         headers: {
//           'Content-Type': 'application/json',
//           'Authorization': accessToken,
//         },
//       );
//
//       final data = await BaseClient.handleResponse(response);
//
//       if (data != null && data['success'] == true) {
//         final model = SubscriptionPackageModel.fromJson(data);
//         subscriptionPackageList.assignAll(model.data);
//
//         // Initialize toggle state for each package
//         for (final pkg in model.data) {
//           _monthlySelected.putIfAbsent(pkg.id!, () => true.obs);
//         }
//       } else {
//         subscriptionPackageList.clear();
//         kSnackBar(
//           message: data?['message'] ?? 'Failed to load subscription packages',
//           bgColor: AppColors.orange,
//         );
//       }
//     } catch (e) {
//       subscriptionPackageList.clear();
//       kSnackBar(message: e.toString(), bgColor: AppColors.orange);
//     } finally {
//       isLoading(false);
//     }
//   }
// }

import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:foto_tidy/app/data/api.dart';
import 'package:foto_tidy/app/modules/dashboard/views/dashboard_view.dart';
import 'package:foto_tidy/app/modules/profile/controllers/profile_controller.dart';
import 'package:foto_tidy/app/modules/profile/model/subscription_package_model.dart';
import 'package:get/get.dart';

import '../../../../common/app_color/app_colors.dart';
import '../../../../common/app_constant/app_constant.dart';
import '../../../../common/helper/local_store.dart';
import '../../../../common/widgets/custom_snackbar.dart';
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
        kSnackBar(message: "User not authenticated", bgColor: AppColors.orange);
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
        kSnackBar(
          message: data?['message'] ?? 'Failed to load packages',
          bgColor: AppColors.orange,
        );
      }
    } catch (e) {
      subscriptionPackageList.clear();
      kSnackBar(message: e.toString(), bgColor: AppColors.orange);
    } finally {
      isLoading(false);
    }
  }

  Future createSubscription({
    required String packageId,
  }) async {
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
        Get.offAll(() => DashboardView(),routeName: '/dashboard');
      } else {
        debugPrint("Error on Payment Result: $responseBody['message'] ");
      }
    } catch (e) {
      debugPrint("Error on Payment Result: $e");
      kSnackBar(
        message: "Error on Payment Result: $e",
        bgColor: AppColors.orange,
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
