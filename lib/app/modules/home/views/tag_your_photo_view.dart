import 'package:flutter/material.dart';

import 'package:get/get.dart';

class TagYourPhotoView extends GetView {
  const TagYourPhotoView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('TagYourPhotoView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'TagYourPhotoView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
