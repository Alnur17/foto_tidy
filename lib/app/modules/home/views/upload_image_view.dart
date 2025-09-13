import 'package:flutter/material.dart';

import 'package:get/get.dart';

class UploadImageView extends GetView {
  const UploadImageView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('UploadImageView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'UploadImageView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
