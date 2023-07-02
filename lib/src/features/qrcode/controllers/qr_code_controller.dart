import 'package:get/get.dart';

import '../models/qr_code_model.dart';

class QRCodeController extends GetxController {
  late QRCodeModel qrCodeModel;
  RxBool existPost = false.obs;

  void generateQRCode(String data) {
    qrCodeModel = QRCodeModel(data);
    update();
  }
}
