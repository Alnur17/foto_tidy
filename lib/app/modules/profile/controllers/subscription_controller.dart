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

import 'package:foto_tidy/app/data/api.dart';
import 'package:foto_tidy/app/modules/profile/model/subscription_package_model.dart';
import 'package:get/get.dart';

import '../../../../common/app_color/app_colors.dart';
import '../../../../common/app_constant/app_constant.dart';
import '../../../../common/helper/local_store.dart';
import '../../../../common/widgets/custom_snackbar.dart';
import '../../../data/base_client.dart';

class SubscriptionController extends GetxController {
  // State
  var isLoading = false.obs;
  var subscriptionPackageList = <SubsPackageDatum>[].obs;

  // Selected package ID (for purchase flow)
  var selectedPackageId = RxnString();

  @override
  void onInit() {
    super.onInit();
    fetchSubscriptionPackages();
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
          (p) => (p.billingCycle?.toLowerCase() == (isMonthly ? 'monthly' : 'yearly')),
    );
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
}