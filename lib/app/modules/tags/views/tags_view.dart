import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../../common/app_color/app_colors.dart';
import '../controllers/tags_controller.dart';

class TagsView extends GetView<TagsController> {
  const TagsView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        title: const Text('TagsView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'TagsView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
