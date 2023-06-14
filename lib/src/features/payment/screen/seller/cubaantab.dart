// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:food_dashboard/src/features/payment/controller/payment_controller.dart';
import 'package:food_dashboard/src/features/rolechange/controller/roleform_controller.dart';
import 'package:get/get.dart';
import '../../../../constants/sizes.dart';
import '../../../authentication/models/user_model.dart';
import '../../model/payment_model.dart';
import 'package:intl/intl.dart';

class PaymentListBuyerScreen extends StatelessWidget {
  final PaymentController paymentController = Get.put(PaymentController());
  @override
  Widget build(BuildContext context) {
    double fontSizeInSp = 12.0;
    double fontSizeInPixels =
        MediaQuery.of(context).textScaleFactor * fontSizeInSp;
    final txtTheme = Theme.of(context).textTheme;

    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(tDashboardPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Your spending is here!",
              style: txtTheme.bodyText2,
            ),
            Text(
              "Transaction",
              style: txtTheme.headline2,
            ),
            const SizedBox(
              height: tDashboardPadding,
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Display payments by month
                    Obx(
                      () => Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: paymentController
                            .getUniqueMonthsBuyer()
                            .map((monthYear) {
                          List<PaymentModel> paymentsForMonth =
                              paymentController
                                  .getPaymentsByMonthBuyer(monthYear);

                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                monthYear,
                                style: TextStyle(
                                  fontSize: fontSizeInPixels,
                                ),
                              ),
                              ListView.separated(
                                padding: EdgeInsets.zero,
                                itemCount: paymentsForMonth.length,
                                physics: const NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                separatorBuilder: (context, index) =>
                                    const SizedBox(
                                  height: 2,
                                ),
                                itemBuilder: (context, index) {
                                  PaymentModel payment =
                                      paymentsForMonth[index];
                                  return TransactionCard(
                                      paymentforMonths:
                                          paymentsForMonth[index]);
                                },
                              ),
                            ],
                          );
                        }).toList(),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class TransactionCard extends StatelessWidget {
  const TransactionCard({
    Key? key,
    required this.paymentforMonths,
  }) : super(key: key);

  final PaymentModel paymentforMonths;

  @override
  Widget build(BuildContext context) {
    double fontSizeInSp12 = 12.0;
    double fontSizeInPixels12 =
        MediaQuery.of(context).textScaleFactor * fontSizeInSp12;
    double fontSizeInSp14 = 14.0;
    double fontSizeInPixels14 =
        MediaQuery.of(context).textScaleFactor * fontSizeInSp14;
    double fontSizeInSp16 = 16.0;
    double fontSizeInPixels16 =
        MediaQuery.of(context).textScaleFactor * fontSizeInSp16;
    double heightInUnits = 30.0;
    double heightInPixels =
        heightInUnits * MediaQuery.of(context).devicePixelRatio;
    String formattedDateTime =
        DateFormat('MMM d, hh:mm a').format(paymentforMonths.datePayment);
    final RoleFormController rfCOntroller = Get.put(RoleFormController());
    return SizedBox(
      height: heightInPixels,
      child: FutureBuilder<UserModel?>(
          future: rfCOntroller.getUserDetail(paymentforMonths.sellerID),
          builder: (context, AsyncSnapshot<UserModel?> snapshot) {
            if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else if (snapshot.hasData) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  CircleAvatar(
                    radius: 20.0,
                    backgroundColor: const Color(0xFFF3F4F5),
                    backgroundImage: NetworkImage(snapshot.data!.profilePhoto),
                  ),
                  const SizedBox(width: 17),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 170,
                        child: Text(
                          snapshot.data!.fullName,
                          overflow: TextOverflow
                              .ellipsis, // Specify the overflow behavior
                          maxLines: 1,
                          style: TextStyle(
                            fontSize: fontSizeInPixels14,
                            color: const Color(0xFF1A1A1A),
                          ),
                        ),
                      ),
                      const SizedBox(height: 1),
                      Text(
                        formattedDateTime,
                        style: TextStyle(
                          fontSize: fontSizeInPixels12,
                          color: const Color(0xFF1A1A1A).withOpacity(0.4),
                        ),
                      )
                    ],
                  ),
                  const Spacer(),
                  Text(
                    "-RM${paymentforMonths.paymentTotal.toStringAsFixed(2)}",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: fontSizeInPixels16,
                      fontWeight: FontWeight.w600,
                    ),
                  )
                ],
              );
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          }),
    );
  }
}
