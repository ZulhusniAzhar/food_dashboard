import 'dart:ui';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../controllers/qr_code_controller.dart';

class ResultQRGeneratorScreen extends GetWidget<QRCodeController> {
  final GlobalKey globalKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('QR Code Generator'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Obx(
              () => controller.qrCodeModel != null
                  ? RepaintBoundary(
                      key: globalKey,
                      child: QrImage(
                        data: controller.qrCodeModel.data,
                        version: QrVersions.auto,
                        size: 200.0,
                      ),
                    )
                  : Container(),
            ),
            SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () {
                if (controller.qrCodeModel != null) {
                  _saveQRCode();
                }
              },
              child: Text('Save QR Code'),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showQRCodeDialog();
        },
        child: Icon(Icons.qr_code),
      ),
    );
  }

  void _showQRCodeDialog() {
    TextEditingController dataController = TextEditingController();

    showDialog(
      context: Get.context,
      builder: (context) {
        return AlertDialog(
          title: Text('Generate QR Code'),
          content: TextField(
            controller: dataController,
            decoration: InputDecoration(
              labelText: 'Data',
            ),
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                String data = dataController.text;
                if (data.isNotEmpty) {
                  Get.back();
                  controller.generateQRCode(data);
                }
              },
              child: Text('Generate'),
            ),
          ],
        );
      },
    );
  }

  void _saveQRCode() async {
    RenderRepaintBoundary boundary =
        globalKey.currentContext.findRenderObject();
    var image = await boundary.toImage();
    ByteData byteData = await image.toByteData(format: ImageByteFormat.png);
    Uint8List pngBytes = byteData.buffer.asUint8List();

    Directory directory = await getTemporaryDirectory();
    String filePath = '${directory.path}/qr_code.png';

    File file = File(filePath);
    await file.writeAsBytes(pngBytes);

    final picker = ImagePicker();
    final pickedFile = await picker.saveImage(File(filePath));

    if (pickedFile != null) {
      Get.snackbar('QR Code Saved', 'QR code image saved to gallery');
    } else {
      Get.snackbar('Save Error', 'Failed to save QR code image');
    }
  }
}
