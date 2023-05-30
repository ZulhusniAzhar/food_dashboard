import 'dart:ui';

import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'dart:core';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;
import '../../../../constants/colors.dart';

class ResultQRGeneratorScreen extends StatefulWidget {
  final String text;
  ResultQRGeneratorScreen({
    super.key,
    required this.text,
  });
  @override
  State<ResultQRGeneratorScreen> createState() =>
      _ResultQRGeneratorScreenState();
}

class _ResultQRGeneratorScreenState extends State<ResultQRGeneratorScreen> {
//   Future<bool?> share() async {
//     if (widget.text != null && widget.text != '') {
//       bool? shareResult = await FlutterShare.share(
//           title: 'Share',
//           linkUrl: widget.text,
//           chooserTitle: 'Choose the medium for sharing');

//       return shareResult;
//     } else {
//       await ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(
//           content: Text("Leia o QRCode!"),
//         ),
//       );
//     }
//   }

  @override
  Widget build(BuildContext context) {
    var isDark = MediaQuery.of(context).platformBrightness == Brightness.dark;
    final globalKey = GlobalKey();

    void saveImage() async {
      try {
        RenderRepaintBoundary boundary = globalKey.currentContext!
            .findRenderObject() as RenderRepaintBoundary;
        final image = await boundary.toImage(pixelRatio: 3.0);
        final byteData = await image.toByteData(format: ImageByteFormat.png);
        final bytes = byteData!.buffer.asUint8List();

        await ImageGallerySaver.saveImage(bytes);
        Get.snackbar(
          'Success',
          'Successfully saved image',
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );
      } catch (e) {
        Get.snackbar("Error", e.toString());
      }
    }

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              // Get.to(() => Dashboard());
              Get.back();
            },
            icon: Icon(LineAwesomeIcons.angle_left,
                color: isDark ? tWhiteColor : tDarkColor)),
        title: Text(
          "QR CODE",
          style: Theme.of(context).textTheme.headline4,
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
        actions: const [
          // IconButton(
          //   onPressed: () {},
          //   icon: Icon(isDark ? LineAwesomeIcons.sun : LineAwesomeIcons.moon,
          //       color: isDark ? tWhiteColor : tDarkColor),
          // ),
        ],
      ),
      body: Center(
        child: Material(
          type: MaterialType.transparency,
          child: Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 32,
              vertical: 36,
            ),
            height: MediaQuery.of(context).size.height * 0.60,
            width: MediaQuery.of(context).size.width * 0.860,
            decoration: const BoxDecoration(
              color: Colors.black,
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment(0.8, 1),
                colors: <Color>[
                  Color(0xFFFEEDFC),
                  Colors.white,
                  Color(0xFFE4E6F7),
                  Color(0xFFE2E5F5),
                ],
                tileMode: TileMode.mirror,
              ),
              borderRadius: BorderRadius.all(
                Radius.circular(20),
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: const EdgeInsets.all(16),
                  height: 240,
                  width: 240,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(
                      Radius.circular(60),
                    ),
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment(0.8, 1),
                      colors: <Color>[
                        Colors.white,
                        Color(0xFFE4E6F7),
                        Colors.white,
                      ],
                      tileMode: TileMode.mirror,
                    ),
                  ),
                  child: Center(
                    child: RepaintBoundary(
                      key: globalKey,
                      child: QrImage(
                        data: widget.text,
                        version: QrVersions.auto,
                        size: 180,
                        foregroundColor: const Color(0xFF8194FE),
                      ),
                    ),
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      'Here your code!!',
                      style: TextStyle(
                        fontFamily: 'poppins_bold',
                        fontSize: 28,
                        color: Color(0xFF6565FF),
                      ),
                    ),
                    Text(
                      "This is the unique QR code for the generated post",
                      style: TextStyle(
                        fontFamily: 'poppins_regular',
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Column(
                    //   children: [
                    //     GestureDetector(
                    //       onTap: () {
                    //         // share();
                    //       },
                    //       child: Container(
                    //         padding: const EdgeInsets.all(12),
                    //         decoration: BoxDecoration(
                    //           color: Colors.white,
                    //           borderRadius: const BorderRadius.all(
                    //             Radius.circular(12),
                    //           ),
                    //           boxShadow: [
                    //             BoxShadow(
                    //               blurRadius: 32.0,
                    //               color:
                    //                   const Color.fromARGB(255, 133, 142, 212)
                    //                       .withOpacity(0.68),
                    //             ),
                    //           ],
                    //         ),
                    //         child: const Icon(
                    //           EvaIcons.shareOutline,
                    //           color: Color(0xFF6565FF),
                    //         ),
                    //       ),
                    //     ),
                    //     const Gap(8),
                    //     const Text(
                    //       "Share",
                    //       style: TextStyle(
                    //         fontFamily: 'poppins_semi_bold',
                    //         fontSize: 14,
                    //       ),
                    //     ),
                    //   ],
                    // ),
                    const Gap(40),
                    Column(
                      children: [
                        GestureDetector(
                          onTap: () {
                            saveImage();
                          },
                          child: Container(
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: const BorderRadius.all(
                                Radius.circular(12),
                              ),
                              boxShadow: [
                                BoxShadow(
                                  blurRadius: 32.0,
                                  color:
                                      const Color.fromARGB(255, 133, 142, 212)
                                          .withOpacity(0.68),
                                ),
                              ],
                            ),
                            child: const Icon(
                              EvaIcons.saveOutline,
                              color: Color(0xFF6565FF),
                            ),
                          ),
                        ),
                        const Gap(8),
                        const Text(
                          "Save",
                          style: TextStyle(
                            fontFamily: 'poppins_semi_bold',
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
