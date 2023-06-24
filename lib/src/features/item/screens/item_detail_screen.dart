// ignore_for_file: deprecated_member_use

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:food_dashboard/src/features/item/controller/item_controller.dart';
import 'package:food_dashboard/src/features/item/model/item_model.dart';
import 'package:food_dashboard/src/features/item/screens/update_item_screen.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

import '../../../constants/colors.dart';
import '../../../constants/sizes.dart';

class ItemDetailScreen extends StatelessWidget {
  ItemDetailScreen({
    super.key,
    required this.itemID,
  });

  final String itemID;
  final ItemController itemController = Get.put(ItemController());

  showOptionsDialog(BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Are you sure you want to delete this item?"),
          content: const Text("This action cannot be undone."),
          actions: [
            TextButton(
              child: const Text("No"),
              onPressed: () {
                // Close the dialog
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text("Yes"),
              onPressed: () {
                // Delete the document and close the dialog
                itemController.deleteItem(itemID);
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  showOptionsDialogPic(BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) => SimpleDialog(
        children: [
          SimpleDialogOption(
            onPressed: () {
              itemController.pickImageUpdate(ImageSource.gallery);
              // controller.updateUserImage(controller.profileImage);
              Navigator.of(context).pop();
              Future.delayed(
                const Duration(seconds: 2),
                () {
                  itemController.chooseImage.value = true;
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
              itemController.pickImageUpdate(ImageSource.camera);
              // controller.updateUserImage(controller.profileImage);
              Navigator.of(context).pop();
              Future.delayed(
                const Duration(seconds: 2),
                () {
                  itemController.chooseImage.value = true;
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
    itemController.itemIDCurrent.value = itemID;

    // final ItemController itemController = Get.put(ItemController());

    var isDark = MediaQuery.of(context).platformBrightness == Brightness.dark;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              // Get.to(() => Dashboard());
              Get.back();
            },
            icon: Icon(LineAwesomeIcons.angle_left,
                color: isDark ? tWhiteColor : tDarkColor)),
        title: Text(
          "Item Details",
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
      body: GetBuilder<ItemController>(builder: (itemController) {
        return Padding(
            padding: const EdgeInsets.all(16.0),
            child: FutureBuilder(
                future: itemController.getItemDetail(itemID),
                builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
                  if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else if (snapshot.hasData) {
                    itemController.itemPhoto.value =
                        snapshot.data!['itemPhoto'];
                    print(
                        "itemID:${itemID} and the obx:${itemController.itemPhoto.value}");
                    // Map<String, dynamic> data = document as Map<String, dynamic>;
                    String joinedIngredients =
                        snapshot.data!['ingredient'].join(", ");
                    String joinedDish = snapshot.data!['sideDish'].join(", ");

                    return SafeArea(
                      child: SingleChildScrollView(
                        child: Container(
                          padding: const EdgeInsets.all(tDefaultSize),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Center(
                                child: Stack(
                                  children: [
                                    Obx(
                                      () => SizedBox(
                                        width: 250,
                                        height: 200,
                                        child: Container(
                                          width: 250,
                                          height: 200,
                                          decoration: BoxDecoration(
                                            border: Border.all(
                                                color: Colors.black, width: 4),
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                          child: Image(
                                            image: NetworkImage(
                                                itemController.itemPhoto.value),
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      bottom: 0,
                                      right: 0,
                                      child: Container(
                                        width: 35,
                                        height: 35,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(100),
                                            color: tPrimaryColor),
                                        child: IconButton(
                                          onPressed: () {
                                            showOptionsDialogPic(context);
                                          },
                                          icon: const Icon(
                                            LineAwesomeIcons.pen,
                                            size: 20,
                                          ),
                                          color: Colors.black,
                                          // size: 20,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Center(
                                child: Text(
                                  snapshot.data!['itemName'],
                                  style: const TextStyle(
                                    fontSize: 24.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 16.0),
                              Text(
                                'RM ${snapshot.data!['price'].toStringAsFixed(2)}',
                                style: const TextStyle(
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.blue,
                                ),
                              ),
                              const SizedBox(height: 16.0),
                              Text(
                                'Ingredient: $joinedIngredients',
                                style: const TextStyle(
                                  fontSize: 18.0,
                                ),
                              ),
                              const SizedBox(height: 16.0),
                              Text(
                                'Side Dish: $joinedDish',
                                style: const TextStyle(
                                  fontSize: 18.0,
                                ),
                              ),
                              const SizedBox(height: 32.0),
                              GestureDetector(
                                onTap: () {
                                  List<dynamic> ingredientList =
                                      snapshot.data!['ingredient'];
                                  List<String> ingredients =
                                      List<String>.from(ingredientList);
                                  List<dynamic> sideDishList =
                                      snapshot.data!['sideDish'];
                                  List<String> sideDish =
                                      List<String>.from(sideDishList);
                                  Get.to(
                                      // () => UpdateProfileScreen(uid: authRepo.user.uid)),
                                      () => UpdateItemScreen(
                                              item: ItemModel(
                                            uid: snapshot.data!['uid'],
                                            itemID: itemID,
                                            itemName:
                                                snapshot.data!['itemName'],
                                            price: snapshot.data!['price'],
                                            ingredient: ingredients,
                                            sideDish: sideDish,
                                            itemPhoto:
                                                snapshot.data!['itemPhoto'],
                                            category:
                                                snapshot.data!['category'],
                                          )));
                                },
                                child: Container(
                                  width: double.infinity,
                                  height: 50.0,
                                  decoration: BoxDecoration(
                                    color: Colors.yellow,
                                    borderRadius: BorderRadius.circular(16.0),
                                  ),
                                  child: const Center(
                                    child: Text(
                                      'Edit Item',
                                      style: TextStyle(
                                        fontSize: 18.0,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 20.0),
                              GestureDetector(
                                onTap: () {
                                  showOptionsDialog(context);
                                  // Navigate to another page when the box is clicked
                                },
                                child: Container(
                                  width: double.infinity,
                                  height: 50.0,
                                  decoration: BoxDecoration(
                                    color: Colors.red,
                                    borderRadius: BorderRadius.circular(16.0),
                                  ),
                                  child: const Center(
                                    child: Text(
                                      'Delete',
                                      style: TextStyle(
                                        fontSize: 18.0,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  } else {
                    return const Center(child: CircularProgressIndicator());
                  }
                }));
      }),
    );
  }
}
