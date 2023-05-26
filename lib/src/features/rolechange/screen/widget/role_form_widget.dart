import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../constants/colors.dart';
import '../../../../constants/sizes.dart';
import '../../controller/roleform_controller.dart';

class RoleFormWidget extends StatelessWidget {
  const RoleFormWidget({
    super.key,
  });
  static final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final roleFormcontroller = Get.put(RoleFormController());

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
            const SizedBox(
              height: 10,
            ),
            TextFormField(
              controller: roleFormcontroller.itemSelling,
              decoration: const InputDecoration(
                  label: Text(
                      "Item for Sell (separated by commas, if more than one)"),
                  prefixIcon: Icon(Icons.list_alt_rounded)),
              validator: (value) {
                if (value == null || value.isEmpty) return 'Field is required.';
                return null;
              },
            ),
            const SizedBox(height: tFormHeight),
            TextFormField(
              controller: roleFormcontroller.descriptionRF,
              validator: (value) {
                if (value == null || value.isEmpty) return 'Field is required.';
                return null;
              },
              decoration: const InputDecoration(
                  label: Text("Short Description"),
                  prefixIcon: Icon(Icons.description_rounded)),
            ),
            const SizedBox(height: tFormHeight),
            TextFormField(
              controller: roleFormcontroller.collegeSelling,
              validator: (value) {
                if (value == null || value.isEmpty) return 'Field is required.';
                return null;
              },
              decoration: const InputDecoration(
                  label: Text("College for selling"),
                  prefixIcon: Icon(Icons.house_rounded)),
            ),
            const SizedBox(height: tFormHeight),
            TextFormField(
              controller: roleFormcontroller.blockSelling,
              decoration: const InputDecoration(
                  label: Text("Block for Selling"),
                  prefixIcon: Icon(Icons.house_siding_rounded)),
            ),
            const SizedBox(height: tFormHeight),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  try {
                    DateTime now = DateTime.now();
                    roleFormcontroller.createRoleForm(
                      now,
                      "For Review",
                      roleFormcontroller.itemSelling.text
                          .trim()
                          .split(',')
                          .map((e) => (e.trim()))
                          .toList(),
                      roleFormcontroller.descriptionRF.text.trim(),
                      roleFormcontroller.blockSelling.text.trim(),
                      roleFormcontroller.collegeSelling.text.trim(),
                    );
                  } catch (e) {
                    Get.snackbar(
                      'Error',
                      e.toString(),
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                    backgroundColor: tPrimaryColor,
                    side: BorderSide.none,
                    shape: const StadiumBorder()),
                child: const Text(
                  "Submit",
                  style: TextStyle(color: tDarkColor),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
