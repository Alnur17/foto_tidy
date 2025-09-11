import 'dart:io';
import 'package:camerawesome/camerawesome_plugin.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:get/get.dart';

class CameraView extends StatelessWidget {
  const CameraView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CameraAwesomeBuilder.awesome(
        // This is how you configure where to save photos (and/or videos)
        saveConfig: SaveConfig.photoAndVideo(
          initialCaptureMode: CaptureMode.photo,
          photoPathBuilder: (sensors) async {
            final dir = await getTemporaryDirectory();
            final path = '${dir.path}/${DateTime.now().millisecondsSinceEpoch}.jpg';
            return SingleCaptureRequest(path, sensors.first);
          },
        ),

        // This is how you get notified when media (photo/video) is captured
        onMediaCaptureEvent: (event) {
          if (event.isPicture && event.status == MediaCaptureStatus.success) {
            // Extract the path
            event.captureRequest.when(
              single: (single) {
                final file = single.file;
                if (file != null) {
                  // media is saved, file.path is available
                  // you can pop with result, etc.
                  Get.back(result: file);
                }
              },
              multiple: (_) {
                // not needed for single photo mode
              },
            );
          }
        },
        // You might want sensorConfig optional (set front/back/flash etc.)
        sensorConfig: SensorConfig.single(
          sensor: Sensor.position(SensorPosition.back),
          aspectRatio: CameraAspectRatios.ratio_4_3,
          flashMode: FlashMode.auto,
          zoom: 0,
        ),
      ),
    );
  }
}
