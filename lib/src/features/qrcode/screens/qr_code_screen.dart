// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'scanner/qr_result_screen.dart';
import 'widgets/tool.dart';

class QRCodeScreen extends StatefulWidget {
  const QRCodeScreen({super.key});

  @override
  State<QRCodeScreen> createState() => _QRCodeScreenState();
}

class _QRCodeScreenState extends State<QRCodeScreen> {
  //* qr scan transaction
  bool isScanComplete = false;

  //* flash bool
  bool isFlash = false;

  //* cam bool
  bool isCam = false;

  //* toggle flash controller
  MobileScannerController controller = MobileScannerController();

  //* change page
  void closeScanner() {
    setState(() {
      isScanComplete = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    var isDark = MediaQuery.of(context).platformBrightness == Brightness.dark;
    return Scaffold(
      //* body
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 20),
            //* Body title
            Expanded(
              child: Column(
                children: [
                  Text(
                    "Place your QR code here",
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                  Text(
                    "Scanned Automatically",
                    style: Theme.of(context).textTheme.bodyText2,
                  ),
                ],
              ),
            ),

            //* Camera Container
            Expanded(
              flex: 3,
              child: MobileScanner(
                controller: controller,
                allowDuplicates: true,
                onDetect: (barcode, args) {
                  if (!isScanComplete) {
                    String qrResult = barcode.rawValue ?? "";
                    List<String> values = qrResult
                        .split('|'); // Split the string using the separator
                    if (values.length >= 2) {
                      String postID = values[0];
                      String sellerID = values[1];
                      setState(() {
                        isScanComplete = true;
                      });
                      Get.to(
                        () => QrResultScreen(
                          // closeScreen: closeScanner,
                          widgetpostID: postID,
                          widgetsellerID: sellerID,
                        ),
                      );
                    }
                  }
                },
              ),
            ),

            //* Tools Container
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  //* flash toggle
                  MyTool(
                    onPressed: () {
                      HapticFeedback.heavyImpact();
                      setState(() {
                        isFlash = !isFlash;
                      });
                      controller.toggleTorch();
                    },
                    text: "Flash",
                    icon: Icon(
                      Icons.flash_on,
                      color: isFlash ? Colors.yellow : Colors.white,
                    ),
                  ),

                  //* camera toggle
                  MyTool(
                    onPressed: () {
                      HapticFeedback.heavyImpact();
                      setState(() {
                        isCam = !isCam;
                      });
                      controller.switchCamera();
                    },
                    text: "Camera",
                    icon: const Icon(
                      Icons.switch_camera_outlined,
                      color: Colors.white,
                    ),
                  ),

                  //* gallery toggle
                  // MyTool(
                  //   text: "Gallery",
                  //   onPressed: () {
                  //     HapticFeedback.heavyImpact();
                  //   },
                  //   icon: const Icon(
                  //     Icons.browse_gallery_outlined,
                  //     color: Colors.white,
                  //   ),
                  // ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
