import 'package:get/get.dart';

class TagsController extends GetxController {
  var tags = <String>[].obs; // list of tags

  void addTag(String tagName) {
    if (tagName.trim().isNotEmpty) {
      tags.add(tagName.trim());
    }
  }

  void removeTag(int index) {
    if (index >= 0 && index < tags.length) {
      tags.removeAt(index);
    }
  }
}
