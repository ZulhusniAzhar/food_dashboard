import 'package:flutter/material.dart';

import 'package:flutter_cards_reel/cards_reel_view.dart';
import 'package:food_dashboard/src/features/rolechange/controller/roleform_controller.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'widget/form_card.dart';

class RoleFormListScreen extends StatelessWidget {
  const RoleFormListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final RoleFormController rfController = Get.put(RoleFormController());
    return Scaffold(
      body: GetBuilder<RoleFormController>(builder: (controller) {
        return StreamBuilder<List<Map<String, dynamic>>>(
          stream: rfController.getAllFormList(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const Center(
                child: Text("No Active Role Form to be Reviewed"),
              );
            }
            if (snapshot.hasError) {
              return const Center(
                child: Text("Error while fetching list"),
              );
            } else if (snapshot.hasData) {
              List<Map<String, dynamic>>? documents = snapshot.data;
              int documentCount = documents!.length;
              final rfDashboardDocs = snapshot.data!;
              if (documentCount < 1) {
                return const Center(
                    child: Text("No Active Role Form to be Reviewed"));
              } else {
                return CardsReelView.builder(
                    itemExtent: 400,
                    itemHeaderExtent: 100,
                    maxScrollPagesAtOnce: 2,
                    itemCount: documentCount,
                    itemBuilder: (context, index) {
                      final rfData = rfDashboardDocs[index];

                      DateTime dateCreated = rfData['createdAt'].toDate();
                      String formattedDateCreated =
                          DateFormat('EEEE, MMMM d, yyyy').format(dateCreated);
                      final userID = rfData['userID'].toString();
                      final rfID = rfData['rfID'].toString();
                      final status = rfData['status'].toString();
                      final descriptionRF = rfData['descriptionRF'].toString();
                      final collegeSelling =
                          rfData['collegeSelling'].toString();
                      final blockSelling = rfData['blockSelling'].toString();
                      final createdAt = formattedDateCreated;
                      var itemSelling = "";
                      rfData['itemSelling'] == null
                          ? itemSelling = "No Item"
                          : itemSelling = rfData['itemSelling'].join(", ");
                      return Padding(
                        padding: const EdgeInsets.all(10),
                        child: SizedBox(
                          height: 400,
                          child: FormCard(
                              index: index,
                              userID: userID,
                              rfID: rfID,
                              status: status,
                              descriptionRF: descriptionRF,
                              collegeSelling: collegeSelling,
                              blockSelling: blockSelling,
                              createdAt: createdAt,
                              itemSelling: itemSelling),
                        ),
                      );
                    });
              }
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        );
      }),
    );
  }
}
