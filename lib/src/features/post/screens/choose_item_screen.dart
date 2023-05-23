// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:food_dashboard/src/features/item/screens/widget/item_card.dart';
import 'package:food_dashboard/src/features/post/screens/add_post_screen.dart';
import 'package:get/get.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

import '../../../constants/colors.dart';
import '../../../constants/sizes.dart';
import '../../item/controller/item_controller.dart';
import '../../item/screens/add_item_screen.dart';

class ChooseItemScreen extends StatelessWidget {
  const ChooseItemScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final txtTheme = Theme.of(context).textTheme;
    final itemController = Get.put(ItemController());
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
          "Choose An Item",
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
      body: StreamBuilder<List<Map<String, dynamic>>>(
        stream: itemController.getItemsListwithUid(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Center(
              child: Text("Error while fetching list"),
            );
          }
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          final itemDocs = snapshot.data!;

          return ListView.builder(
            itemCount: itemDocs.length,
            itemBuilder: ((context, index) {
              final itemData = itemDocs[index];
              final itemId = itemData['id'].toString();
              final itemName = itemData['itemName'].toString();
              final itemPhoto = itemData['itemPhoto'].toString();
              final price = itemData['price'];
              final category = itemData['category'].toString();
              // final sideDish = itemData['sideDish'];

              return SingleChildScrollView(
                child: Container(
                  padding: const EdgeInsets.all(tDashboardPadding),
                  child: Center(
                    child: ItemCard(
                      txtTheme: txtTheme,
                      name: itemName,
                      imageLink: itemPhoto,
                      price: price as double,
                      category: category,
                      itemID: itemId,
                      path: AddPostScreen(itemID: itemId),
                    ),
                  ),
                ),
              );
            }),
          );
        },
      ),
    );
  }
}