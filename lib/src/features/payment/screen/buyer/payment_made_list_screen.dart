import 'package:flutter/material.dart';
import 'package:food_dashboard/src/constants/colors.dart';
import 'package:get/get.dart';

import '../../../authentication/models/user_model.dart';
import '../../../rolechange/controller/roleform_controller.dart';
import '../../controller/payment_controller.dart';
import 'package:intl/intl.dart';
import '../../model/payment_model.dart';

class MyTabbedScreen extends StatelessWidget {
  final PaymentController paymentController = Get.put(PaymentController());

  @override
  Widget build(BuildContext context) {
    double fontSizeInSp = 12.0;
    double fontSizeInPixels =
        MediaQuery.of(context).textScaleFactor * fontSizeInSp;
    final txtTheme = Theme.of(context).textTheme;
    return DefaultTabController(
      length: 2, // Number of tabs
      child: Scaffold(
        appBar: TabBar(
          padding: const EdgeInsets.all(4),
          indicator: BoxDecoration(
            color: tPrimaryColor,
            borderRadius: BorderRadius.circular(10),
          ),
          labelStyle: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
          unselectedLabelColor: const Color(0xFF1A1A1A),
          labelColor: const Color(0xFF1A1A1A),
          tabs: const [
            Tab(
              child: Text("Expenses"),
            ),
            Tab(
              child: Text("Incomes"),
            ),
          ],
        ),
        body: TabBarView(
          children: [
            // Contents of Tab 1
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: paymentController
                    .getUniqueMonthsBuyer()
                    .map((monthYearBuyer) {
                  List<PaymentModel> paymentsForMonthBuyer =
                      paymentController.getPaymentsByMonthBuyer(monthYearBuyer);

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        monthYearBuyer,
                        style: TextStyle(
                          fontSize: fontSizeInPixels,
                        ),
                      ),
                      // ListView.builder(
                      //   shrinkWrap: true,
                      //   physics: NeverScrollableScrollPhysics(),
                      //   itemCount: paymentsForMonth.length,
                      //   itemBuilder: (context, index) {
                      //     PaymentModel payment =
                      //         paymentsForMonth[index];
                      //     return TransactionCard(
                      //         paymentforMonths:
                      //             paymentsForMonth[index]);
                      //   },
                      // ),
                      ListView.separated(
                        padding: EdgeInsets.zero,
                        itemCount: paymentsForMonthBuyer.length,
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        separatorBuilder: (context, index) => const SizedBox(
                          height: 2,
                        ),
                        itemBuilder: (context, index) {
                          PaymentModel paymentBuyer =
                              paymentsForMonthBuyer[index];
                          return TransactionCard(
                              paymentforMonths: paymentsForMonthBuyer[index]);
                        },
                      ),
                    ],
                  );
                }).toList(),
              ),
            ),

            // Contents of Tab 2
            Obx(() => paymentController.role.value == "Seller"
                ? Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: paymentController
                          .getUniqueMonthsSeller()
                          .map((monthYearSeller) {
                        List<PaymentModel> paymentsForMonthSeller =
                            paymentController
                                .getPaymentsByMonthSeller(monthYearSeller);

                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              monthYearSeller,
                              style: TextStyle(
                                fontSize: fontSizeInPixels,
                              ),
                            ),
                            ListView.separated(
                              padding: EdgeInsets.zero,
                              itemCount: paymentsForMonthSeller.length,
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              separatorBuilder: (context, index) =>
                                  const SizedBox(
                                height: 2,
                              ),
                              itemBuilder: (context, index) {
                                PaymentModel payment =
                                    paymentsForMonthSeller[index];
                                return TransactionCard(
                                    paymentforMonths:
                                        paymentsForMonthSeller[index]);
                              },
                            ),
                          ],
                        );
                      }).toList(),
                    ),
                  )
                : Text('Please be Seller')),
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
                      ),
                      Text(
                        paymentforMonths.method,
                        style: TextStyle(
                          fontSize: fontSizeInPixels12,
                          color: const Color(0xFF1A1A1A).withOpacity(0.7),
                        ),
                      )
                    ],
                  ),
                  const Spacer(),
                  Text(
                    "RM${paymentforMonths.paymentTotal.toStringAsFixed(2)}",
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
