import 'package:flutter/material.dart';
import 'package:food_dashboard/src/features/report_ticket/controller/report_ticket_controller.dart';
import 'package:food_dashboard/src/features/report_ticket/model/reportticket_model.dart';
import 'package:get/get.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import '../../../constants/colors.dart';
import '../../../constants/sizes.dart';
import 'package:dropdown_model_list/dropdown_model_list.dart';

class CreateReportScreenCopy extends StatefulWidget {
  CreateReportScreenCopy({
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
  State<CreateReportScreenCopy> createState() => _CreateReportScreenCopyState();
}

class _CreateReportScreenCopyState extends State<CreateReportScreenCopy> {
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ReportTicketController());
    final _formKey = GlobalKey<FormState>();
    String selectedId = "";
    String selectedTitle = "";
    DropListModel optionsCategory = DropListModel([
      OptionItem(id: "1", title: "Quality Complaint"),
      OptionItem(id: "2", title: "Allergic Reactions"),
      OptionItem(id: "3", title: "Food Poisoning"),
      OptionItem(id: "4", title: "Mislabeling or Misrepresentation"),
      OptionItem(id: "5", title: "Foreign Objects"),
      OptionItem(id: "6", title: "Packaging Issues"),
      OptionItem(id: "7", title: "Expired or Spoiled Products"),
      OptionItem(id: "8", title: "Adverse Reactions"),
    ]);
    OptionItem optionItemSelected = OptionItem(title: "Select Report Category");
    var isDark = MediaQuery.of(context).platformBrightness == Brightness.dark;
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
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 10,
                ),
                const SizedBox(
                  height: 10,
                ),
                // SelectDropList(
                //   itemSelected: optionItemSelected,
                //   dropListModel: optionsCategory,
                //   showIcon: true, // Show Icon in DropDown Title
                //   showArrowIcon: true, // Show Arrow Icon in DropDown
                //   showBorder: true,
                //   suffixIcon: Icons.arrow_drop_down,
                //   paddingTop: 0,
                //   icon: const Icon(Icons.report_problem_rounded,
                //       color: Colors.black),
                //   onOptionSelected: (optionItem) {
                //     setState(() {
                //       optionItemSelected = optionItem;
                //       print(optionItemSelected.title);
                //       selectedId = optionItemSelected.id!;
                //       selectedTitle = optionItemSelected.title;
                //     });
                //   },
                // ),
                const SizedBox(height: tFormHeight),
                TextFormField(
                  controller: controller.comment,
                  validator: (value) {
                    if (value == null || value.isEmpty)
                      return 'Field is required.';
                    return null;
                  },
                  decoration: const InputDecoration(
                      label: Text("Report Description"),
                      prefixIcon: Icon(Icons.report_rounded)),
                ),
                const SizedBox(height: tFormHeight * 3),
                SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        final newTicketReport = ReportTicketModel(
                            reporterID: controller.getCurrentUserId(),
                            sellerID: widget.sellerID,
                            reportID: '',
                            postID: widget.postId,
                            problemCat: selectedTitle,
                            comment: controller.comment.text.trim(),
                            statusTicket: 0,
                            createdAt: DateTime.now(),
                            deletedAt: null);
                        controller.addTicket(newTicketReport);
                      },
                      child: const Text("Proceed to Seller"),
                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
