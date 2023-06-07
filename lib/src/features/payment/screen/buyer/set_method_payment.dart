import 'package:flutter/material.dart';
import 'package:food_dashboard/src/features/payment/controller/payment_controller.dart';
import 'package:food_dashboard/src/features/payment/model/payment_model.dart';
import 'package:food_dashboard/src/features/payment/screen/buyer/thanks_page.dart';
import 'package:get/get.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

import '../../../../constants/colors.dart';

class PaymentMethod {
  final String name;
  final IconData icon;

  PaymentMethod({required this.name, required this.icon});
}

class SetPaymentMethod extends StatelessWidget {
  SetPaymentMethod(
      {super.key,
      required this.amountPayment,
      required this.quantity,
      required this.sellerID});
  final double amountPayment;
  final int quantity;
  final String sellerID;
  final List<PaymentMethod> paymentMethods = [
    PaymentMethod(name: 'PayPal', icon: Icons.payment),
    PaymentMethod(name: 'Visa', icon: Icons.credit_card),
    PaymentMethod(name: 'MasterCard', icon: Icons.credit_card),
    PaymentMethod(name: 'American Express', icon: Icons.credit_card),
    PaymentMethod(name: 'Online Banking', icon: LineAwesomeIcons.piggy_bank),
    PaymentMethod(name: 'Cash', icon: LineAwesomeIcons.money_bill),
  ];

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(PaymentController());
    var isDark = MediaQuery.of(context).platformBrightness == Brightness.dark;
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: Icon(LineAwesomeIcons.angle_left,
                color: isDark ? tWhiteColor : tDarkColor)),
        title: Text(
          "Payment Method for RM ${amountPayment.toStringAsFixed(2)}",
          style: Theme.of(context).textTheme.headline4,
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: ListView.builder(
        itemCount: paymentMethods.length,
        itemBuilder: (BuildContext context, int index) {
          PaymentMethod paymentMethod = paymentMethods[index];

          return ListTile(
            leading: Icon(paymentMethod.icon),
            title: Text(paymentMethod.name),
            onTap: () {
              final newPayment = PaymentModel(
                  userID: controller.getCurrentUserId(),
                  sellerID: sellerID,
                  paymentID: '',
                  paymentTotal: amountPayment,
                  statusPayment: 1,
                  method: paymentMethod.name,
                  itemTotal: quantity,
                  createdAt: DateTime.now(),
                  datePayment: DateTime.now(),
                  deletedAt: null);
              controller.addPayment(newPayment);
            },
          );
        },
      ),
    );
  }
}
