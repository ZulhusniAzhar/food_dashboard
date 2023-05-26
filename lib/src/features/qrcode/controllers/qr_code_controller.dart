import 'package:get/get.dart';

import '../models/qr_code_model.dart';

class QRCodeController extends GetxController {
  late QRCodeModel qrCodeModel;

  void generateQRCode(String data) {
    qrCodeModel = QRCodeModel(data);
    update();
  }
}
