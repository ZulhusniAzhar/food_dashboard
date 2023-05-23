// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:food_dashboard/src/features/rolechange/controller/roleform_controller.dart';
import 'package:get/get.dart';
import '../../../../constants/sizes.dart';

class RejectNoteScreen {
  static Future<dynamic> buildShowModalBottomSheet(
      BuildContext context, String rfID) {
    final _formKey = GlobalKey<FormState>();
    final RoleFormController rfController = Get.put(RoleFormController());
    return showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
      builder: (context) => Container(
        padding: const EdgeInsets.all(tDefaultSize),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Why Rejected", style: Theme.of(context).textTheme.headline2),
            Text("Provide the explanation for the rejection below here",
                style: Theme.of(context).textTheme.bodyText2),
            const SizedBox(height: tDefaultSize),
            Container(
              padding: const EdgeInsets.all(20.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                color: Colors.grey.withOpacity(0.3),
              ),
              child: Form(
                key: _formKey,
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextFormField(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Field is required.';
                          }
                          return null;
                        },
                        controller: rfController.statusforReject,
                        decoration: const InputDecoration(
                          prefixIcon: Icon(Icons.note_alt_rounded),
                          labelText: "Description",
                          hintText: "Description for Rejection",
                          border: OutlineInputBorder(),
                        ),
                      ),
                      const SizedBox(height: 20.0),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          // onPressed: () => Get.to(() => Dashboard()),
                          onPressed: () {
                            rfController.changeRoleFormStatusReject(
                              rfID,
                              rfController.statusforReject.text.trim(),
                            );
                          },
                          child: Text("Submit"),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20.0),
          ],
        ),
      ),
    );
  }
}
