// ignore_for_file: deprecated_member_use, unused_local_variable

import 'package:custom_radio_group_list/custom_radio_group_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:food_dashboard/src/features/post/controller/post_controller.dart';
import 'package:food_dashboard/src/features/post/model/post_model.dart';
import 'package:food_dashboard/src/features/post/screens/widgets/date_picker.dart';
import 'package:intl/intl.dart';
import 'package:get/get.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:time_interval_picker/time_interval_picker.dart';

import '../../../constants/college.dart';
import '../../../constants/colors.dart';
import '../../../constants/sizes.dart';

class UpdatePostScreen extends StatefulWidget {
  const UpdatePostScreen({
    super.key,
    required this.post,
  });
  final PostModel post;

  @override
  State<UpdatePostScreen> createState() => _UpdatePostScreenState();
}

class _UpdatePostScreenState extends State<UpdatePostScreen> {
  TextEditingController captionController = TextEditingController();
  TextEditingController stockItemController = TextEditingController();
  TextEditingController venueBlockController = TextEditingController();
  TextEditingController venueCollegeController = TextEditingController();
  TextEditingController saleTimeStartController = TextEditingController();
  TextEditingController saleTimeEndController = TextEditingController();

  @override
  void initState() {
    captionController = TextEditingController(text: widget.post.caption);
    stockItemController =
        TextEditingController(text: widget.post.stockItem.toString());
    venueBlockController = TextEditingController(text: widget.post.venueBlock);
    venueCollegeController =
        TextEditingController(text: widget.post.venueCollege);
    saleTimeStartController =
        TextEditingController(text: widget.post.saleTimeStart);
    saleTimeEndController =
        TextEditingController(text: widget.post.saleTimeEnd);

    super.initState();
  }

  @override
  void dispose() {
    captionController.dispose();
    stockItemController.dispose();
    venueBlockController.dispose();
    venueCollegeController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    final postController = Get.put(PostController());
    DateTime parsedSaleStartTime =
        DateFormat('HH:mm').parse(widget.post.saleTimeStart);
    DateTime parsedSaleEndTime =
        DateFormat('HH:mm').parse(widget.post.saleTimeEnd);
    // bool chooseImage = false;
    int selectedIndexCollege = 0;
    for (int i = 0; i < college.length; i++) {
      if (college[i] == widget.post.venueCollege) {
        selectedIndexCollege = i;
        break;
      }
    }

    var isDark = MediaQuery.of(context).platformBrightness == Brightness.dark;

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                // Get.to(() => Dashboard());
                Get.back();
              },
              icon: Icon(LineAwesomeIcons.angle_left,
                  color: isDark ? tWhiteColor : tDarkColor)),
          title: Text(
            "Update Post ",
            style: Theme.of(context).textTheme.headline4,
          ),
          centerTitle: true,
          elevation: 0,
          backgroundColor: Colors.transparent,
          actions: const [
            // IconButton(
            //   onPressed: () {},
            //   icon: Icon(isDark ? LineAwesomeIcons.sun : LineAwesomeIcons.moon,
            //       color: isDark ? tWhiteColor : tDarkColor),
            // ),
          ],
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: tFormHeight),
              child: Form(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 100.0,
                      child: TextFormField(
                        maxLines: 7,
                        controller: captionController,
                        decoration: const InputDecoration(
                          label: Text("Caption"),
                          // prefixIcon: Icon(Icons.person_outline_rounded)
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Field is required.';
                          }
                          return null;
                        },
                      ),
                    ),
                    const SizedBox(height: tFormHeight),
                    TextFormField(
                      keyboardType: TextInputType.number,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                      ],
                      controller: stockItemController,
                      decoration: const InputDecoration(
                        label: Text("Item Stock"),
                        // prefixIcon: Icon(Icons.person_outline_rounded)
                      ),
                    ),
                    const SizedBox(height: tFormHeight),
                    TextFormField(
                      controller: venueBlockController,
                      decoration: const InputDecoration(
                        label: Text("Venue Block"),
                        // prefixIcon: Icon(Icons.person_outline_rounded)
                      ),
                    ),
                    const SizedBox(height: tFormHeight),
                    Text(
                      "Venue College",
                      style: TextStyle(
                        color: Colors.black.withOpacity(0.7),
                      ),
                    ),
                    Container(
                      width: 180, // Set the desired width
                      height: 370,
                      child: RadioGroup(
                        radioList: college,
                        selectedItem: selectedIndexCollege,
                        onChanged: (value) {
                          venueCollegeController.text = value;
                        },
                      ),
                    ),
                    const SizedBox(height: tFormHeight),
                    Text(
                      "Sale Time",
                      style: TextStyle(
                        color: Colors.black.withOpacity(0.7),
                      ),
                    ),
                    TimeIntervalPicker(
                      endLimit: parsedSaleEndTime,
                      startLimit: parsedSaleStartTime,
                      onChanged: (DateTime? startTime, DateTime? endTime,
                          bool isAllDay) {
                        postController.formattedSaleStart.value =
                            DateFormat('HH:mm').format(startTime!);
                        postController.formattedSaleEnd.value =
                            DateFormat('HH:mm').format(endTime!);
                      },
                    ),
                    const SizedBox(height: tFormHeight),
                    DateRangePickerWidget(),
                    // const SizedBox(height: tFormHeight),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          if (captionController.text.isNotEmpty &&
                              venueBlockController.text.isNotEmpty &&
                              venueCollegeController.text.isNotEmpty) {
                            try {
                              int? parsedStock =
                                  int.tryParse(stockItemController.text.trim());
                              DateTime now = DateTime.now();
                              postController.updatePost(PostModel(
                                  uid: widget.post.uid,
                                  postID: widget.post.postID,
                                  itemID: widget.post.itemID,
                                  caption: captionController.text.trim(),
                                  stockItem: parsedStock!,
                                  saleTimeStart:
                                      postController.formattedSaleStart.value,
                                  saleTimeEnd:
                                      postController.formattedSaleEnd.value,
                                  timeStart: widget.post.timeStart,
                                  timeEnd: widget.post.timeEnd,
                                  venueBlock: venueBlockController.text.trim(),
                                  venueCollege:
                                      venueCollegeController.text.trim(),
                                  createdAt: widget.post.createdAt,
                                  deletedAt: widget.post.deletedAt));
                            } catch (e) {
                              Get.snackbar(
                                'Error',
                                "Please fill in all the field",
                              );
                            }
                          } else {
                            Get.snackbar("Error", "Please fill all fields");
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.black,
                          textStyle: const TextStyle(color: Colors.white),
                          side: BorderSide.none,
                          shape: const StadiumBorder(),
                        ),
                        child: Text("Save".toUpperCase()),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
