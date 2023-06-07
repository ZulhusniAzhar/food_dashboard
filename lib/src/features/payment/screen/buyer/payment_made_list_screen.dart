import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controller/payment_controller.dart';

class PaymentListBuyerScreen extends GetView<PaymentController> {
  const PaymentListBuyerScreen({super.key});

  @override
  @override
  Widget build(BuildContext context) {
    final PaymentController paymentController = Get.put(PaymentController());
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Payments as Buyer:',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16.0),
            Expanded(
              child: Obx(
                () {
                  if (paymentController.paymentsasBuyer.isEmpty) {
                    return const Center(
                      child: Text('No payments found.'),
                    );
                  }
                  return ListView.builder(
                    itemCount: paymentController.paymentsasBuyer.length,
                    itemBuilder: (context, index) {
                      final payment = paymentController.paymentsasBuyer[index];
                      return ListTile(
                        title: Text('Payment ID: ${payment.paymentID}'),
                        subtitle:
                            Text('Payment Total: RM${payment.paymentTotal}'),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
