import 'package:custom_radio_group_list/custom_radio_group_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../../../../constants/college.dart';
import '../../../../constants/sizes.dart';
import '../../../item/controller/item_controller.dart';
import '../../controller/post_controller.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:time_interval_picker/time_interval_picker.dart';
import 'date_picker.dart';
import 'package:intl/intl.dart';

class AddPostForm extends StatelessWidget {
  AddPostForm({required this.itemID, super.key});

  final String itemID;
  final postController = Get.put(PostController());
  final itemController = Get.put(ItemController());
  static final _formKey = GlobalKey<FormState>();

  showOptionsDialog(BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) => SimpleDialog(
        children: [
          SimpleDialogOption(
            onPressed: () {
              postController.pickImage(ImageSource.gallery);
              Navigator.of(context).pop();
              Future.delayed(
                const Duration(seconds: 2),
                () {
                  postController.chooseImage.value = true;
                },
              );
            },
            child: Row(
              children: const [
                Icon(Icons.image),
                Padding(
                  padding: EdgeInsets.all(7.0),
                  child: Text(
                    'Gallery',
                    style: TextStyle(fontSize: 20),
                  ),
                ),
              ],
            ),
          ),
          SimpleDialogOption(
            onPressed: () {
              postController.pickImage(ImageSource.camera);
              Navigator.of(context).pop();
              Future.delayed(
                const Duration(seconds: 2),
                () {
                  postController.chooseImage.value = true;
                },
              );
            },
            child: Row(
              children: const [
                Icon(Icons.camera_alt),
                Padding(
                  padding: EdgeInsets.all(7.0),
                  child: Text(
                    'Camera',
                    style: TextStyle(fontSize: 20),
                  ),
                ),
              ],
            ),
          ),
          SimpleDialogOption(
            onPressed: () => Navigator.of(context).pop(),
            child: Row(
              children: const [
                Icon(Icons.cancel),
                Padding(
                  padding: EdgeInsets.all(7.0),
                  child: Text(
                    'Cancel',
                    style: TextStyle(fontSize: 20),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var isDark = MediaQuery.of(context).platformBrightness == Brightness.dark;
    final DateRangePickerController dateController =
        Get.put(DateRangePickerController());
    // itemController.getData(itemID);
    return Container(
      padding: const EdgeInsets.symmetric(vertical: tFormHeight),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // const SizedBox(
            //   height: 10,
            // ),
            // Center(
            //   child: SizedBox(
            //     width: 200,
            //     child: ElevatedButton(
            //       onPressed: () {
            //         showOptionsDialog(context);
            //       },
            //       style: ElevatedButton.styleFrom(
            //         backgroundColor: tPrimaryColor,
            //         side: BorderSide.none,
            //         shape: const StadiumBorder(),
            //       ),
            //       child: Obx(
            //         () => Text(
            //           postController.chooseImage.value == false
            //               ? "Add Venue Image"
            //               : "Image Added",
            //           style: const TextStyle(color: tDarkColor),
            //         ),
            //       ),
            //     ),
            //   ),
            // ),
            // const SizedBox(
            //   height: 10,
            // ),
            // StreamBuilder<List<Map<String, dynamic>>>(
            //   stream: controller.getItemsListwithUid(),
            //   builder: ((context, snapshot) {
            //     if (snapshot.hasError) {
            //       return const Center(
            //         child: Text("Error while fetching list"),
            //       );
            //     }
            //     if (!snapshot.hasData) {
            //       return const Center(
            //         child: CircularProgressIndicator(),
            //       );
            //     }
            //     final itemDocs = snapshot.data!;
            //     return DropdownButton(
            //         value: selectedItem,
            //         items: itemDocs.map((item) {
            //           final itemData = item;
            //           final itemId = itemData['id'].toString();

            //           final itemName = itemData['itemName'].toString();
            //           // final itemPhoto = itemData['itemPhoto'].toString();
            //           // final price = itemData['price'];
            //           // final category = itemData['category'].toString();
            //           return DropdownMenuItem<Map<String, dynamic>>(
            //             value: item,
            //             child: Text(itemName),
            //           );
            //         }).toList(),
            //         onChanged: (value) {
            //           controller.addPost(value!);
            //         });
            //   }),
            // ),
            // const SizedBox(
            //   height: 10,
            // ),
            SizedBox(
              height: 100.0,
              child: TextFormField(
                maxLines: 7,
                controller: postController.caption,
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
              controller: postController.itemStock,
              decoration: const InputDecoration(
                label: Text("Item Stock"),
                // prefixIcon: Icon(Icons.person_outline_rounded)
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Field is required.';
                }
                return null;
              },
            ),
            const SizedBox(height: tFormHeight),
            TextFormField(
              controller: postController.venueBlock,
              decoration: const InputDecoration(
                label: Text("Venue Block"),
                // prefixIcon: Icon(Icons.person_outline_rounded)
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Field is required.';
                }
                return null;
              },
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
              selectedItem: 1,
              onChanged: (value) {
                postController.collegeChosen.value = value;
              },
            ),
            const SizedBox(height: tFormHeight),
            Text(
              "Sale Time",
              style: TextStyle(
                color: Colors.black.withOpacity(0.7),
              ),
            ),
            TimeIntervalPicker(
              endLimit: null,
              startLimit: null,
              onChanged:
                  (DateTime? startTime, DateTime? endTime, bool isAllDay) {
                postController.formattedSaleStart.value =
                    DateFormat('HH:mm').format(startTime!);
                postController.formattedSaleEnd.value =
                    DateFormat('HH:mm').format(endTime!);
              },
            ),
            const SizedBox(height: tFormHeight),
            DateRangePickerWidget(),
            const SizedBox(height: tFormHeight),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  try {
                    int? parsedStock =
                        int.tryParse(postController.itemStock.text);
                    DateTime now = DateTime.now();
                    postController.createPost(
                      itemID,
                      postController.caption.text.trim(),
                      parsedStock!,
                      postController.formattedSaleStart.value,
                      postController.formattedSaleEnd.value,
                      // dateController.startDate,
                      // postController.endDate,
                      postController.venueBlock.text.trim(),
                      postController.collegeChosen.value,
                      now,
                      // postController.postImage,
                    );
                  } catch (e) {
                    Get.snackbar(
                      'Error',
                      "Please fill in all fields",
                      backgroundColor: Colors.red,
                      colorText: Colors.white,
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  textStyle: const TextStyle(color: Colors.white),
                  side: BorderSide.none,
                  shape: const StadiumBorder(),
                ),
                child: Text("Create".toUpperCase()),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
