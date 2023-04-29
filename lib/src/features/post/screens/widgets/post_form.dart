import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../../../../constants/colors.dart';
import '../../../../constants/sizes.dart';
import '../../controller/post_controller.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'date_picker.dart';

class AddPostForm extends StatelessWidget {
  AddPostForm({super.key});

  String? selectedItem;
  final controller = Get.put(PostController());
  static final _formKey = GlobalKey<FormState>();

  showOptionsDialog(BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) => SimpleDialog(
        children: [
          SimpleDialogOption(
            onPressed: () {
              controller.pickImage(ImageSource.gallery);
              Navigator.of(context).pop();
              Future.delayed(
                const Duration(seconds: 2),
                () {
                  controller.chooseImage.value = true;
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
              controller.pickImage(ImageSource.camera);
              Navigator.of(context).pop();
              Future.delayed(
                const Duration(seconds: 2),
                () {
                  controller.chooseImage.value = true;
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

    return Container(
      padding: const EdgeInsets.symmetric(vertical: tFormHeight),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 10,
            ),
            Center(
              child: SizedBox(
                width: 200,
                child: ElevatedButton(
                  onPressed: () {
                    showOptionsDialog(context);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: tPrimaryColor,
                    side: BorderSide.none,
                    shape: const StadiumBorder(),
                  ),
                  child: Obx(
                    () => Text(
                      controller.chooseImage.value == false
                          ? "Add Venue Image"
                          : "Image Added",
                      style: const TextStyle(color: tDarkColor),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
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
            const SizedBox(
              height: 10,
            ),
            SizedBox(
              height: 100.0,
              child: TextFormField(
                maxLines: 7,
                controller: controller.caption,
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
              controller: controller.caption,
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
              controller: controller.caption,
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
            TextFormField(
              controller: controller.caption,
              decoration: const InputDecoration(
                label: Text("Venue College"),
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
            DateRangePickerWidget(),
            const SizedBox(height: tFormHeight),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  //   try {
                  //     double? parsedPrice =
                  //         double.tryParse(controller.price.text);
                  //     controller.createItem(
                  //       controller.name.text.trim(),
                  //       parsedPrice,
                  //       controller.category.text.trim(),
                  //       controller.ingredient.text
                  //           .trim()
                  //           .split(',')
                  //           .map((e) => (e.trim()))
                  //           .toList(),
                  //       controller.sideDish.text
                  //           .trim()
                  //           .split(',')
                  //           .map((e) => (e.trim()))
                  //           .toList(),
                  //       controller.itemImage,
                  //     );
                  //   } catch (e) {
                  //     Get.snackbar(
                  //       'Error',
                  //       "Please Select Image",
                  //     );
                  //   }
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
