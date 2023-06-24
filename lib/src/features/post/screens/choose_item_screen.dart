// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:food_dashboard/src/features/item/screens/widget/item_card.dart';
import 'package:food_dashboard/src/features/post/screens/add_post_screen.dart';
import 'package:get/get.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

import '../../../constants/colors.dart';
import '../../../constants/sizes.dart';
import '../../item/controller/item_controller.dart';

class ChooseItemScreen extends StatelessWidget {
  const ChooseItemScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final txtTheme = Theme.of(context).textTheme;
    final itemController = Get.put(ItemController());
    var isDark = MediaQuery.of(context).platformBrightness == Brightness.dark;
    return Scaffold(
      extendBody: true,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: Icon(
            LineAwesomeIcons.angle_left,
            color: isDark ? tWhiteColor : tDarkColor,
          ),
        ),
        title: Text(
          "Choose An Item",
          style: Theme.of(context).textTheme.headline4,
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: SafeArea(
        child: StreamBuilder<List<Map<String, dynamic>>>(
          stream: itemController.getItemsListwithUid(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Center(
                child: Text("Error while fetching list"),
              );
            }
            if (!snapshot.hasData) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }

            final itemDocs = snapshot.data!;

            return ListView.builder(
              itemCount: itemDocs.length,
              itemBuilder: ((context, index) {
                final itemData = itemDocs[index];
                final itemId = itemData['itemID'].toString();
                final itemName = itemData['itemName'].toString();
                final itemPhoto = itemData['itemPhoto'].toString();
                final price = itemData['price'];
                final category = itemData['category'].toString();

                return MenuCard(
                  txtTheme: txtTheme,
                  name: itemName,
                  imageLink: itemPhoto,
                  price: price as double,
                  category: category,
                  itemID: itemId,
                  path: AddPostScreen(itemID: itemId),
                );
              }),
            );
          },
        ),
      ),
    );
  }
}
