import 'dart:io';

import 'package:custom_radio_group_list/custom_radio_group_list.dart';
import 'package:flutter/material.dart';
import 'package:food_dashboard/src/features/report_ticket/controller/report_ticket_controller.dart';
import 'package:food_dashboard/src/features/report_ticket/model/reportticket_model.dart';
import 'package:get/get.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../constants/colors.dart';
import '../../../constants/sizes.dart';
import 'package:dropdown_model_list/dropdown_model_list.dart';

class CreateReportScreen extends StatelessWidget {
  CreateReportScreen({
    super.key,
    required this.sellerID,
    required this.postId,
    required this.sellerPhoneNo,
    required this.fullNameSeller,
    required this.itemName,
    required this.dateStartBuy,
    required this.dateStartEnd,
  });

  String sellerID;
  String postId;
  String sellerPhoneNo;
  String fullNameSeller;
  String itemName;
  String dateStartBuy;
  String dateStartEnd;
  @override
  Widget build(BuildContext context) {
    void openWhatsapp({required String text, required String number}) async {
      var whatsapp = number; //+92xx enter like this
      var whatsappURlAndroid =
          "whatsapp://send?phone=" + whatsapp + "&text=$text";
      var whatsappURLIos = "https://wa.me/$whatsapp?text=${Uri.tryParse(text)}";
      if (Platform.isIOS) {
        // for iOS phone only
        if (await canLaunchUrl(Uri.parse(whatsappURLIos))) {
          await launchUrl(Uri.parse(
            whatsappURLIos,
          ));
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("Whatsapp not installed")));
        }
      } else {
        // android , web
        if (await canLaunchUrl(Uri.parse(whatsappURlAndroid))) {
          await launchUrl(Uri.parse(whatsappURlAndroid));
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("Whatsapp not installed")));
        }
      }
    }

    List<String> reportList = [
      "Quality Complaint",
      "Allergic Reactions",
      "Food Poisoning",
      "Mislabeling or Misrepresentation",
      "Foreign Objects",
      "Packaging Issues",
      "Expired or Spoiled Products",
      "Adverse Reactions"
    ];
    final controller = Get.put(ReportTicketController());
    var isDark = MediaQuery.of(context).platformBrightness == Brightness.dark;
    String chosenCategory = '';
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: Icon(LineAwesomeIcons.angle_left,
                color: isDark ? tWhiteColor : tDarkColor)),
        title: Text(
          "Post Details",
          style: Theme.of(context).textTheme.headline4,
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(tFormHeight),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("Report Category"),
              RadioGroup(
                radioList: reportList,
                selectedItem: 1,
                onChanged: (value) {
                  controller.chosenCategory.value = value;
                },
              ),
              const SizedBox(height: tFormHeight),
              TextFormField(
                controller: controller.comment,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Field is required.';
                  }
                  return null; // Return null if the value is valid
                },
                maxLines: null,
                keyboardType: TextInputType.multiline,
                decoration: const InputDecoration(
                  labelText: "Report Description",
                  prefixIcon: Icon(Icons.report_rounded),
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: tFormHeight * 3),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    if (controller.comment.text.trim().isEmpty) {
                      // Display snackbar if the comment field is empty
                      Get.snackbar(
                        "Error",
                        "Please fill in the report description.",
                        backgroundColor: Colors.red,
                        colorText: Colors.white,
                      );
                    } else if (controller.chosenCategory.value.isEmpty) {
                      // Display snackbar if the category is not chosen
                      Get.snackbar(
                        "Error",
                        "Please choose a report category.",
                        backgroundColor: Colors.red,
                        colorText: Colors.white,
                      );
                    } else {
                      // All fields are filled, proceed with ticket creation and opening WhatsApp
                      final newTicketReport = ReportTicketModel(
                        reporterID: controller.getCurrentUserId(),
                        sellerID: sellerID,
                        reportID: '',
                        postID: postId,
                        problemCat: controller.chosenCategory.value,
                        comment: controller.comment.text.trim(),
                        statusTicket: 0,
                        createdAt: DateTime.now(),
                        deletedAt: null,
                      );
                      controller.addTicket(newTicketReport);
                      openWhatsapp(
                        number: sellerPhoneNo,
                        text:
                            'Hello ${fullNameSeller},\n\nthrough UTM Food Dashboard, I would like to make a report regarding the item you are selling. \nItem: ${itemName.toString().toUpperCase()}\nPost:${dateStartBuy} - ${dateStartEnd}.\nProblem:${controller.chosenCategory.value}.\nExplanation:${controller.comment.text.trim()}',
                      );
                    }
                  },
                  child: const Text("Proceed to Seller"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
