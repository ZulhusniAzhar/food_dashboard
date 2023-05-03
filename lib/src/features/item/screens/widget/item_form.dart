import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
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
    // final controller = Get.put(ItemController());

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
                          ? "Add Item's Image"
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
            TextFormField(
              controller: controller.name,
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
              keyboardType: TextInputType.number,
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
              ],
              controller: controller.price,
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
            TextFormField(
              controller: controller.category,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Field is required.';
                }
                return null;
              },
              decoration: const InputDecoration(
                label: Text("Category (Food/Drink)"),
                // prefixIcon: Icon(Icons.boy_rounded)
              ),
            ),
            const SizedBox(height: tFormHeight),
            TextFormField(
              controller: controller.ingredient,
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
              controller: controller.sideDish,
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
                        double.tryParse(controller.price.text);
                    controller.createItem(
                      controller.name.text.trim(),
                      parsedPrice,
                      controller.category.text.trim(),
                      controller.ingredient.text
                          .trim()
                          .split(',')
                          .map((e) => (e.trim()))
                          .toList(),
                      controller.sideDish.text
                          .trim()
                          .split(',')
                          .map((e) => (e.trim()))
                          .toList(),
                      controller.itemImage,
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
