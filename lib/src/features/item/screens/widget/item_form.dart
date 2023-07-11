import 'dart:io';

import 'package:custom_radio_group_list/custom_radio_group_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:food_dashboard/src/constants/image_strings.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../../../../constants/category.dart';
import '../../../../constants/colors.dart';
import '../../../../constants/sizes.dart';
import '../../controller/item_controller.dart';

class AddItemForm extends StatelessWidget {
  AddItemForm({super.key});

  final controller = Get.put(ItemController());
  static final _formKey = GlobalKey<FormState>();
  // bool chooseImage = false;

  showOptionsDialog(BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) => SimpleDialog(
        children: [
          SimpleDialogOption(
            onPressed: () {
              controller.pickImage(ImageSource.gallery);
              Navigator.of(context).pop();
              // Future.delayed(
              //   const Duration(seconds: 2),
              //   () {
              //     controller.chooseImage.value = true;
              //   },
              // );
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
              // Future.delayed(
              //   const Duration(seconds: 2),
              //   () {
              //     controller.chooseImage.value = true;
              //   },
              // );
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
    // final controller = Get.put(ItemController(), permanent: false);

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
              child: Obx(
                () => Column(
                  children: [
                    controller.imagePath.value == ""
                        ? const Image(
                            image:
                                AssetImage(tImageBlank), // Use the AssetImage
                            fit: BoxFit.cover,
                            width: 150,
                            height: 150,
                          )
                        : Image.file(
                            File(controller.imagePath.value),
                            fit: BoxFit.cover,
                            width: 150,
                            height: 150,
                          ),
                    SizedBox(
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
                            controller.chooseImage.value == true
                                ? "Image Added"
                                : "Add Item's Image",
                            style: const TextStyle(color: tDarkColor),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            TextFormField(
              controller: controller.nameCtrl,
              decoration: const InputDecoration(
                label: Text("Name"),
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
              // keyboardType: TextInputType.number,
              // inputFormatters: [
              //   FilteringTextInputFormatter.digitsOnly,
              // ],
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp(r'(^\d*\.?\d{0,2})'))
              ],
              controller: controller.priceCtrl,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Field is required.';
                }
                return null;
              },
              decoration: const InputDecoration(
                label: Text("Price"),
                // prefixIcon: Icon(Icons.numbers_rounded)
              ),
            ),
            const SizedBox(height: tFormHeight),
            Text(
              "Category",
              style: TextStyle(
                color: Colors.black.withOpacity(0.7),
              ),
            ),
            RadioGroup(
              radioList: category,
              selectedItem: null,
              onChanged: (value) {
                controller.categoryItem.value = value;
              },
            ),
            const SizedBox(height: tFormHeight),
            TextFormField(
              controller: controller.ingredientCtrl,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Field is required.';
                }
                return null;
              },
              decoration: const InputDecoration(
                label: Text("Ingredients (separated by commas)"),
                // prefixIcon: Icon(Icons.numbers)
              ),
              // onSaved: (value) {
              //   controller
              //       .setNumbersIngredient(controller.ingredient.text.trim());
              // },
            ),
            const SizedBox(height: tFormHeight),
            TextFormField(
              controller: controller.sideDishCtrl,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Field is required.';
                }
                return null;
              },
              decoration: const InputDecoration(
                label: Text("Side Dishes (separated by commas)"),
                // prefixIcon: Icon(Icons.fingerprint)
              ),
              // onSaved: (value) {
              //   controller
              //       .setNumbersSideDish(controller.ingredient.text.trim());
              // },
            ),
            const SizedBox(height: tFormHeight),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  try {
                    double? parsedPrice =
                        double.tryParse(controller.priceCtrl.text);
                    DateTime now = DateTime.now();
                    controller.createItem(
                      controller.nameCtrl.text.trim(),
                      parsedPrice,
                      controller.categoryItem.value,
                      controller.ingredientCtrl.text
                          .trim()
                          .split(',')
                          .map((e) => (e.trim()))
                          .toList(),
                      controller.sideDishCtrl.text
                          .trim()
                          .split(',')
                          .map((e) => (e.trim()))
                          .toList(),
                      controller.itemImage,
                      now,
                    );
                  } catch (e) {
                    Get.snackbar(
                      'Error',
                      "Please Select Image",
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
