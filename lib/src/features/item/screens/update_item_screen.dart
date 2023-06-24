// ignore_for_file: deprecated_member_use

import 'dart:io';

import 'package:custom_radio_group_list/custom_radio_group_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:food_dashboard/src/features/item/model/item_model.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

import '../../../constants/category.dart';
import '../../../constants/colors.dart';
import '../../../constants/image_strings.dart';
import '../../../constants/sizes.dart';
import '../controller/item_controller.dart';

class UpdateItemScreen extends StatefulWidget {
  const UpdateItemScreen({
    super.key,
    required this.item,
  });
  final ItemModel item;

  @override
  State<UpdateItemScreen> createState() => _UpdateItemScreenState();
}

class _UpdateItemScreenState extends State<UpdateItemScreen> {
  TextEditingController itemNameController = TextEditingController();
  TextEditingController itemPriceController = TextEditingController();
  TextEditingController itemPhotoController = TextEditingController();
  TextEditingController itemSideDishController = TextEditingController();
  TextEditingController itemIngredientController = TextEditingController();
  TextEditingController itemCategoryController = TextEditingController();

  @override
  void initState() {
    String joinedIngredients = widget.item.ingredient.join(", ");
    String joinedDish = widget.item.sideDish.join(", ");
    itemNameController = TextEditingController(text: widget.item.itemName);
    itemPriceController =
        TextEditingController(text: widget.item.price.toString());
    itemPhotoController = TextEditingController(text: widget.item.itemPhoto);
    itemSideDishController = TextEditingController(text: joinedDish);
    itemIngredientController = TextEditingController(text: joinedIngredients);
    itemCategoryController = TextEditingController(text: widget.item.category);

    super.initState();
  }

  @override
  void dispose() {
    itemNameController.dispose();
    itemPriceController.dispose();
    itemPhotoController.dispose();
    itemSideDishController.dispose();
    itemIngredientController.dispose();
    itemCategoryController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ItemController());
    // bool chooseImage = false;
    int selectedIndexCategory = 0;
    for (int i = 0; i < category.length; i++) {
      if (category[i] == widget.item.category) {
        selectedIndexCategory = i;
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
          child: Container(
            // padding: const EdgeInsets.symmetric(vertical: tFormHeight),
            padding: const EdgeInsets.all(tDefaultSize),
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: tFormHeight),
              child: Form(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      controller: itemNameController,
                      decoration: const InputDecoration(
                        label: Text("Name"),
                        // prefixIcon: Icon(Icons.person_outline_rounded)
                      ),
                    ),
                    const SizedBox(height: tFormHeight),
                    TextFormField(
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(
                            RegExp(r'(^\d*\.?\d{0,2})'))
                      ],
                      controller: itemPriceController,
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
                      selectedItem: selectedIndexCategory,
                      onChanged: (value) {
                        itemCategoryController.text = value;
                      },
                    ),
                    const SizedBox(height: tFormHeight),
                    TextFormField(
                      controller: itemIngredientController,
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
                      controller: itemSideDishController,
                      decoration: const InputDecoration(
                        label: Text("Side Dishes (separated by commas)"),
                      ),
                    ),
                    const SizedBox(height: tFormHeight),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          try {
                            double? parsedPrice =
                                double.tryParse(itemPriceController.text);
                            ItemController.updateItem(ItemModel(
                              uid: widget.item.uid,
                              itemID: widget.item.itemID,
                              itemName: itemNameController.text,
                              price: parsedPrice!,
                              ingredient: itemIngredientController.text
                                  .trim()
                                  .split(',')
                                  .map((e) => (e.trim()))
                                  .toList(),
                              sideDish: itemSideDishController.text
                                  .trim()
                                  .split(',')
                                  .map((e) => (e.trim()))
                                  .toList(),
                              itemPhoto: widget.item.itemPhoto,
                              category: itemCategoryController.text,
                            ));
                          } catch (e) {
                            Get.snackbar(
                              'Error',
                              "Please Fill All Field",
                            );
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
