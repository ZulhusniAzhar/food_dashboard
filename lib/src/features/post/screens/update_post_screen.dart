// ignore_for_file: deprecated_member_use, unused_local_variable

import 'package:custom_radio_group_list/custom_radio_group_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:food_dashboard/src/features/post/controller/post_controller.dart';
import 'package:food_dashboard/src/features/post/model/post_model.dart';
import 'package:food_dashboard/src/features/post/screens/widgets/date_picker.dart';
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

  @override
  void initState() {
    captionController = TextEditingController(text: widget.post.caption);
    stockItemController =
        TextEditingController(text: widget.post.stockItem.toString());
    venueBlockController = TextEditingController(text: widget.post.venueBlock);
    venueCollegeController =
        TextEditingController(text: widget.post.venueCollege);

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
    final controller = Get.put(PostController());
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
            "Update Item (Your Product)",
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
                    RadioGroup(
                      radioList: college,
                      selectedItem: selectedIndexCollege,
                      onChanged: (value) {
                        venueCollegeController.text = value;
                      },
                    ),
                    const SizedBox(height: tFormHeight),
                    Text(
                      "Sale Time",
                      style: TextStyle(
                        color: Colors.black.withOpacity(0.7),
                      ),
                    ),
                    // TimeIntervalPicker(
                    //   endLimit: null,
                    //   startLimit: null,
                    //   onChanged:
                    //       (DateTime? startTime, DateTime? endTime, bool isAllDay) {
                    //     postController.formattedSaleStart.value =
                    //         DateFormat('HH:mm').format(startTime!);
                    //     postController.formattedSaleEnd.value =
                    //         DateFormat('HH:mm').format(endTime!);
                    //   },
                    // ),
                    // const SizedBox(height: tFormHeight),
                    // DateRangePickerWidget(),
                    // const SizedBox(height: tFormHeight),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          //   try {
                          //     int? parsedStock =
                          //         int.tryParse(postController.itemStock.text);
                          //     DateTime now = DateTime.now();
                          //     postController.createPost(
                          //       itemID,
                          //       postController.caption.text.trim(),
                          //       parsedStock!,
                          //       postController.formattedSaleStart.value,
                          //       postController.formattedSaleEnd.value,
                          //       // dateController.startDate,
                          //       // postController.endDate,
                          //       postController.venueBlock.text.trim(),
                          //       postController.collegeChosen.value,
                          //       now,
                          //       // postController.postImage,
                          //     );
                          //   } catch (e) {
                          //     Get.snackbar(
                          //       'Error',
                          //       e.toString(),
                          //     );
                          //   }
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
