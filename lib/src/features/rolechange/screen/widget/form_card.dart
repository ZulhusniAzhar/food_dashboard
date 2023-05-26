// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:food_dashboard/src/features/rolechange/controller/roleform_controller.dart';
import 'package:get/get.dart';
import '../../../..//constants/colors.dart';
import '../../../authentication/models/user_model.dart';
import 'reject_note.dart';

class FormCard extends StatefulWidget {
  FormCard({
    super.key,
    required this.index,
    required this.userID,
    required this.rfID,
    required this.status,
    required this.descriptionRF,
    required this.collegeSelling,
    required this.blockSelling,
    required this.createdAt,
    required this.itemSelling,
  });
  final int index;
  final String userID;
  final String rfID;
  final String status;
  final String descriptionRF;
  final String collegeSelling;
  final String blockSelling;
  final String createdAt;
  final String itemSelling;

  @override
  State createState() => FormCardState();
}

class FormCardState extends State<FormCard> {
  @override
  Widget build(BuildContext context) {
    final RoleFormController rfCOntroller = Get.put(RoleFormController());
    return FutureBuilder<UserModel?>(
        future: rfCOntroller.getUserDetail(widget.userID),
        builder: (context, AsyncSnapshot<UserModel?> snapshot) {
          if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else if (snapshot.hasData) {
            return Container(
              clipBehavior: Clip.antiAlias,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(10)),
                color: Colors.primaries[widget.index % Colors.primaries.length],
              ),
              child: Padding(
                padding: const EdgeInsets.all(18.0),
                child: Stack(
                  children: [
                    Positioned(
                      top: 10,
                      left: 10,
                      child: Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(5),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(50),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const SizedBox(
                                  width: 5,
                                ),
                                Text(snapshot.data!.fullName),
                                const SizedBox(
                                  width: 5,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Positioned(
                      top: 10,
                      right: 10,
                      child: Container(
                        padding: const EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          color: Colors.grey.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(50),
                        ),
                        child: Text(widget.createdAt),
                      ),
                    ),
                    Positioned(
                      top: 80,
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        // decoration: BoxDecoration(
                        //   color: Colors.white.withOpacity(0.4),
                        // ),
                        width: MediaQuery.of(context).size.width,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(
                              height: 5,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(right: 8.0),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    "Sale Venue: ",
                                    style:
                                        Theme.of(context).textTheme.headline4,
                                  ),
                                  const SizedBox(
                                    width: 15,
                                  ),
                                  Text(
                                    "${widget.blockSelling.toUpperCase()},${widget.collegeSelling.toUpperCase()}",
                                    style: const TextStyle(color: Colors.white),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 5),
                            Padding(
                              padding: const EdgeInsets.only(right: 8.0),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    "Description: ",
                                    style:
                                        Theme.of(context).textTheme.headline4,
                                  ),
                                  const SizedBox(
                                    width: 15,
                                  ),
                                  Flexible(
                                    child: Text(
                                      widget.descriptionRF,
                                      style:
                                          const TextStyle(color: Colors.white),
                                      overflow: TextOverflow.visible,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 5),
                            Padding(
                              padding: const EdgeInsets.only(right: 8.0),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    "Items: ",
                                    style:
                                        Theme.of(context).textTheme.headline4,
                                  ),
                                  const SizedBox(
                                    width: 60,
                                  ),
                                  Text(
                                    widget.itemSelling,
                                    style: const TextStyle(color: Colors.white),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 15,
                      left: 50,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          SizedBox(
                            width: 100,
                            child: ElevatedButton(
                              onPressed: () {
                                RejectNoteScreen.buildShowModalBottomSheet(
                                    context, widget.rfID);
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: tPrimaryColor,
                                side: const BorderSide(
                                    width: 1.0, color: tWhiteColor),
                                shape: const StadiumBorder(),
                              ),
                              child: const Text("Rejected",
                                  style: TextStyle(color: tDarkColor)),
                            ),
                          ),
                          const SizedBox(width: 20),
                          SizedBox(
                            width: 100,
                            child: ElevatedButton(
                              onPressed: () {
                                rfCOntroller
                                    .changeRoleFormStatusAccept(widget.rfID);
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.greenAccent,
                                side: const BorderSide(
                                    width: 1.0, color: tWhiteColor),
                                shape: const StadiumBorder(),
                              ),
                              child: const Text("Accepted",
                                  style: TextStyle(color: tDarkColor)),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        });
  }
}
