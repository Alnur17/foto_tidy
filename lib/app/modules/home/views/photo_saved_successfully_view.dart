import 'package:flutter/material.dart';

import 'package:get/get.dart';

class PhotoSavedSuccessfullyView extends GetView {
  const PhotoSavedSuccessfullyView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('PhotoSavedSuccessfullyView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'PhotoSavedSuccessfullyView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
