// ignore_for_file: deprecated_member_use

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:food_dashboard/src/features/item/controller/item_controller.dart';
import 'package:get/get.dart';
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

  @override
  Widget build(BuildContext context) {
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
      body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: FutureBuilder(
              future: itemController.getItemDetail(itemID),
              builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
                if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else if (snapshot.hasData) {
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
                              child: Container(
                                width: 250,
                                height: 200,
                                decoration: BoxDecoration(
                                  border:
                                      Border.all(color: Colors.black, width: 4),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Image.network(
                                  snapshot.data!['itemPhoto'],
                                  fit: BoxFit.cover,
                                ),
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
                            // GestureDetector(
                            //   onTap: () {
                            //     // Navigate to another page when the box is clicked
                            //   },
                            //   child: Container(
                            //     width: double.infinity,
                            //     height: 50.0,
                            //     decoration: BoxDecoration(
                            //       color: Colors.yellow,
                            //       borderRadius: BorderRadius.circular(16.0),
                            //     ),
                            //     child: const Center(
                            //       child: Text(
                            //         'Buy Now',
                            //         style: TextStyle(
                            //           fontSize: 18.0,
                            //           color: Colors.white,
                            //           fontWeight: FontWeight.bold,
                            //         ),
                            //       ),
                            //     ),
                            //   ),
                            // ),
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
              })),
    );
  }
}
