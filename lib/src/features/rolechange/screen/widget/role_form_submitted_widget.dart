import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:food_dashboard/src/features/rolechange/controller/roleform_controller.dart';
import 'package:get/get.dart';

import '../../../../constants/colors.dart';

class SubmittedRoleFormWidget extends StatelessWidget {
  const SubmittedRoleFormWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final RoleFormController rfController = Get.put(RoleFormController());
    return FutureBuilder(
        future: rfController.getDocumentRoleFormDetail(),
        builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else if (snapshot.hasData) {
            if (snapshot.data!['status'] != "Accepted") {
              return Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: const EdgeInsets.only(top: 50.0),
                    child: Center(
                        child: Text(
                      ' Status:  ${snapshot.data!['status']}',
                      style: const TextStyle(
                        fontSize: 18.0,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    )),
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        rfController.deletePreviousRoleForm();
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: tPrimaryColor,
                          side: BorderSide.none,
                          shape: const StadiumBorder()),
                      child: const Text(
                        "Make Request Again",
                        style: TextStyle(color: tDarkColor),
                      ),
                    ),
                  ),
                ],
              );
            } else {
              return Container(
                padding: const EdgeInsets.only(top: 50.0),
                child: Center(
                    child: Text(
                  ' Status:  ${snapshot.data!['status']}',
                  style: const TextStyle(
                    fontSize: 18.0,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                )),
              );
            }
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        });
  }
}
