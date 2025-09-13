import 'package:get/get.dart';

class OnboardingController extends GetxController {
  var currentPage = 0.obs;

  // Method to update current page
  void updatePage(int pageIndex) {
    currentPage.value = pageIndex;
  }
}
