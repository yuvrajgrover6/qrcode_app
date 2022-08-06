import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' as ui;

class QrGeneratorController extends GetxController {
  TextEditingController qrController = TextEditingController();

  final GlobalKey genKey = GlobalKey();
  Future<File> takePicture() async {
    RenderRepaintBoundary boundary =
        genKey.currentContext!.findRenderObject() as RenderRepaintBoundary;
    ui.Image image = await boundary.toImage();
    final directory = (await getApplicationDocumentsDirectory()).path;
    ByteData byteData =
        (await image.toByteData(format: ui.ImageByteFormat.png))!;
    Uint8List pngBytes = byteData.buffer.asUint8List();
    File imgFile = new File('$directory/photo.png');
    await imgFile.writeAsBytes(pngBytes);
    return imgFile;
  }

  onSubmit() async {
    Get.back();
    qrController.clear();
    final recordedImage = await takePicture();
    final result = await GallerySaver.saveImage(recordedImage.path);
    Get.snackbar(
      'Saved to Gallery Successfully',
      'Check your gallery to see image',
      backgroundColor: Colors.pink,
      colorText: Colors.white,
    );
  }
}
