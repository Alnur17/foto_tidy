import 'package:get/get.dart';

import '../../../../common/app_constant/app_constant.dart';
import '../../../../common/helper/local_store.dart';
import '../../../data/api.dart';
import '../../../data/base_client.dart';
import '../model/settings_model.dart';

class SettingsController extends GetxController {
  var isLoading = true.obs;
  var errorMessage = ''.obs;
  var getAboutUs = ''.obs;
  var getTermsConditions = ''.obs;
  var getPrivacyPolicy = ''.obs;
  var settingsList = <Datum>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchSettings();
  }

  Future<void> fetchSettings() async {
    try {
      isLoading(true);
      errorMessage('');

      String token = LocalStorage.getData(key: AppConstant.accessToken) ?? '';
      var headers = {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      };

      final response = await BaseClient.getRequest(
        api: Api.settings,
        headers: headers,
      );

      final data = await BaseClient.handleResponse(response);
      var settings  = SettingsModel.fromJson(data);
      settingsList.addAll(settings.data);

      getPrivacyPolicy.value = settingsList.first.privacyPolicy.toString();
      getTermsConditions.value = settingsList.first.termsAndConditions.toString();
      getAboutUs.value = settingsList.first.aboutUs.toString();

    } catch (e) {
      errorMessage(e.toString());
    } finally {
      isLoading(false);
    }
  }

}