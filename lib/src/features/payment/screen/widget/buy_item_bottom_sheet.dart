// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:food_dashboard/src/features/payment/screen/buyer/thanks_page.dart';
import 'package:food_dashboard/src/repository/authentication_repository/authentication_repository.dart';
import 'package:get/get.dart';

import '../../../../constants/colors.dart';
import '../../../../constants/sizes.dart';
import '../../../../constants/text_strings.dart';
import '../../../authentication/screens/forget_password/forget_password_options/forget_password_btn_widget.dart';

class BuyItemStockScreen {
  static Future<dynamic> buildShowModalBottomSheet(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
      builder: (context) => Container(
        padding: const EdgeInsets.all(tDefaultSize),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("How many to buy?",
                style: Theme.of(context).textTheme.headline2),
            Text("Choose the item amount and the payment method suits you",
                style: Theme.of(context).textTheme.bodyText2),
            const SizedBox(height: tDefaultSize),
            // ForgetPasswordBtnWidget(
            //   onTap: () {
            //     Navigator.pop(context);
            //     Get.to(() => const ThankYouPage());
            //   },
            //   btnIcon: Icons.mail_outline_rounded,
            //   title: tEmail,
            //   subTitle: tResetViaEmail,
            // ),
            const SizedBox(height: 20.0),
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
                    child: const Icon(Icons.add),
                  ),
                  Container(
                    height: 30.0,
                    width: 30.0,
                    alignment: Alignment.center,
                    decoration: const BoxDecoration(
                      color: Colors.transparent,
                    ),
                    child: const Text(
                      "4",
                      style: TextStyle(fontSize: 20.0),
                    ),
                  ),
                  const SizedBox(height: 40.0),
                  Container(
                    height: 35.0,
                    width: 35.0,
                    margin: const EdgeInsets.only(left: 15.0),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: tPrimaryColor.withOpacity(0.6),
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    child: const Icon(Icons.remove),
                  ),
                ],
              ),
            ),
            ForgetPasswordBtnWidget(
              btnIcon: Icons.mobile_friendly_rounded,
              title: tPhoneNo,
              subTitle: tResetViaPhone,
              onTap: () {
                Navigator.pop(context);
                Get.to(() => const ThankYouPage());
              },
            ),
          ],
        ),
      ),
    );
  }
}
