// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'package:flutter/material.dart';
import 'package:food_dashboard/src/constants/colors.dart';
import 'package:food_dashboard/src/features/payment/screen/buyer/set_method_payment.dart';
import 'package:food_dashboard/src/features/payment/screen/buyer/thanks_page.dart';
import 'package:get/get.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

class SetAmountItemStockScreen extends StatefulWidget {
  const SetAmountItemStockScreen({
    super.key,
    required this.itemPhoto,
    required this.price,
    required this.itemName,
    required this.caption,
    required this.itemStock,
    required this.sellerID,
  });

  final String itemPhoto;
  final double price;
  final String itemName;
  final String caption;
  final int itemStock;
  final String sellerID;

  @override
  State<SetAmountItemStockScreen> createState() =>
      _SetAmountItemStockScreenState();
}

class _SetAmountItemStockScreenState extends State<SetAmountItemStockScreen> {
  int quantity = 0;
  double price = 0;
  final int limit = 10;

  void increaseQuantity() {
    if (quantity < limit) {
      setState(() {
        quantity++;
        calculatePrice();
      });
    }
  }

  void decreaseQuantity() {
    if (quantity > 0) {
      setState(() {
        quantity--;
        calculatePrice();
      });
    }
  }

  void calculatePrice() {
    price = quantity * widget.price;
  }

  Widget _container(Widget child) {
    // price = widget.price;
    return Container(
      height: 45.0,
      width: 45.0,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: tWhiteColor,
        borderRadius: BorderRadius.circular(10.0),
        boxShadow: [
          BoxShadow(
            color: tDarkColor.withOpacity(0.15),
            offset: const Offset(1, 1),
            blurRadius: 10,
            spreadRadius: 2.0,
          ),
        ],
      ),
      child: child,
    );
  }

  @override
  Widget build(BuildContext context) {
    var isDark = MediaQuery.of(context).platformBrightness == Brightness.dark;
    Size _size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: Icon(LineAwesomeIcons.angle_left,
                color: isDark ? tWhiteColor : tDarkColor)),
        title: Text(
          "Buying Details",
          style: Theme.of(context).textTheme.headline4,
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            Stack(
              children: [
                Container(
                  height: _size.height * 0.57,
                  margin: const EdgeInsets.only(bottom: 30.0),
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.only(
                      bottomRight: Radius.circular(500.0),
                      bottomLeft: Radius.circular(500.0),
                    ),
                    color: tWhiteColor,
                    boxShadow: [
                      BoxShadow(
                        color: tDarkColor.withOpacity(0.15),
                        offset: const Offset(1, 1),
                        blurRadius: 10,
                        spreadRadius: 2.0,
                      ),
                    ],
                  ),
                ),
                // Positioned(
                //   top: 35.0,
                //   left: 10.0,
                //   right: 10.0,
                //   child: Row(
                //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //     children: [
                //       InkWell(
                //         onTap: () {
                //           Navigator.pop(context);
                //         },
                //         child: _container(
                //           const Icon(
                //             Icons.chevron_left,
                //             size: 35.0,
                //           ),
                //         ),
                //       ),
                //       // _container(
                //       //   const Icon(
                //       //     Icons.favorite_border,
                //       //     color: tPrimaryColor,
                //       //     size: 30.0,
                //       //   ),
                //       // ),
                //     ],
                //   ),
                // ),
                Positioned(
                  top: _size.height * 0.05,
                  left: 10.0,
                  right: 10.0,
                  child: Column(
                    // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        widget.itemName,
                        textAlign: TextAlign.left,
                        style: const TextStyle(
                          color: tDarkColor,
                          fontSize: 18.0,
                          fontWeight: FontWeight.w900,
                          height: 1,
                        ),
                      ),
                      const SizedBox(
                        height: 15.0,
                      ),
                      Text(
                        widget.caption,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: tDarkColor,
                          fontSize: 15.0,
                          fontWeight: FontWeight.w500,
                          height: 1.1,
                        ),
                      ),
                      const SizedBox(
                        height: 15.0,
                      ),
                      Container(
                        alignment: Alignment.center,
                        child: Image.network(
                          widget.itemPhoto,
                          // color: ConstantColor.primaryColor,
                          height: 280.0,
                        ),
                      ),
                    ],
                  ),
                ),
                // Positioned(
                //   bottom: 40.0,
                //   left: _size.width * 0.12,
                //   child: _container(
                //     const Text(
                //       "S",
                //       textAlign: TextAlign.center,
                //       style: TextStyle(fontSize: 22.0),
                //     ),
                //   ),
                // ),
                // Positioned(
                //   bottom: 0,
                //   // bottom: -3.0,
                //   left: _size.width * 0.45,
                //   child: _container(
                //     const Text(
                //       "M",
                //       textAlign: TextAlign.center,
                //       style: TextStyle(fontSize: 22.0),
                //     ),
                //   ),
                // ),
                // Positioned(
                //   bottom: 35,
                //   right: _size.width * 0.10,
                //   child: _container(
                //     const Text(
                //       "L",
                //       textAlign: TextAlign.center,
                //       style: TextStyle(fontSize: 22.0),
                //     ),
                //   ),
                // ),
              ],
            ),
            const Spacer(),
            Container(
              alignment: Alignment.center,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 35.0,
                    width: 35.0,
                    decoration: BoxDecoration(
                      color: tPrimaryColor.withOpacity(0.6),
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    margin: const EdgeInsets.only(right: 15.0),
                    child: IconButton(
                      icon: const Icon(Icons.add),
                      onPressed: increaseQuantity,
                    ),
                  ),
                  Container(
                    height: 30.0,
                    width: 30.0,
                    alignment: Alignment.center,
                    decoration: const BoxDecoration(
                      color: Colors.transparent,
                    ),
                    child: Text(
                      '$quantity',
                      style: const TextStyle(fontSize: 20.0),
                    ),
                  ),
                  Container(
                    height: 35.0,
                    width: 35.0,
                    margin: const EdgeInsets.only(left: 15.0),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: tPrimaryColor.withOpacity(0.6),
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    child: IconButton(
                      icon: const Icon(Icons.remove),
                      onPressed: decreaseQuantity,
                    ),
                  ),
                ],
              ),
            ),
            const Spacer(),
            Container(
              alignment: Alignment.bottomCenter,
              padding: const EdgeInsets.all(10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Price",
                        style: TextStyle(
                          fontWeight: FontWeight.w300,
                          fontSize: 15.0,
                          color: Colors.grey,
                        ),
                      ),
                      Text(
                        "RM ${price.toStringAsFixed(2)}",
                        style: const TextStyle(
                          fontWeight: FontWeight.w800,
                          fontSize: 20.0,
                        ),
                      ),
                    ],
                  ),
                  InkWell(
                    onTap: () {
                      quantity > 0
                          ? Get.to(() => SetPaymentMethod(
                                amountPayment: price,
                                quantity: quantity,
                                sellerID: widget.sellerID,
                              ))
                          : Get.snackbar("Error", "You must buy atleast one");
                    },
                    child: Container(
                      height: 60.0,
                      width: 130.0,
                      decoration: const BoxDecoration(
                        color: tPrimaryColor,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10.0),
                          bottomLeft: Radius.circular(10.0),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Icon(
                            Icons.attach_money_rounded,
                            size: 25.0,
                            color: tWhiteColor,
                          ),
                          SizedBox(
                            width: 3.0,
                          ),
                          Text(
                            "Payment",
                            style: TextStyle(
                              color: tWhiteColor,
                              fontSize: 14.0,
                              fontWeight: FontWeight.w600,
                            ),
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
