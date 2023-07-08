import 'package:flutter/material.dart';
import 'package:food_dashboard/src/constants/image_strings.dart';
import 'package:get/get.dart';
import 'package:percent_indicator/percent_indicator.dart';

import '../../controller/analytic_controller.dart';

class UserGrid extends StatelessWidget {
  const UserGrid({super.key});

  @override
  Widget build(BuildContext context) {
    final AnalyticDashboardController analyticDashboardController =
        Get.put(AnalyticDashboardController());

    return StreamBuilder(
      stream: analyticDashboardController.getAllRoleList(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final List<Map<String, dynamic>> combinedList = snapshot.data!;

          final sellerList =
              combinedList.where((item) => item['role'] == "Seller").toList();
          final studentList =
              combinedList.where((item) => item['role'] == "General").toList();
          final administratorList =
              combinedList.where((item) => item['role'] == 'Admin').toList();

          final sellerCount = sellerList.length;
          final studentCount = studentList.length;
          final administratorCount = administratorList.length;

          final totalCount = sellerCount + studentCount + administratorCount;

          final sellerRatio = sellerCount / totalCount;
          final sellerRatioPercent = sellerRatio * 100;
          final studentRatio = studentCount / totalCount;
          final studentRatioPercent = studentRatio * 100;
          final administratorRatio = administratorCount / totalCount;
          final adminRatioPercent = administratorRatio * 100;

          return Column(
            children: [
              Container(
                decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage(tBox1), fit: BoxFit.fill),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          const Text(
                            'Seller',
                            style: TextStyle(color: Colors.white),
                          ),
                          Text(
                            sellerCount.toString(),
                            style: const TextStyle(color: Colors.white),
                          ),
                          CircularPercentIndicator(
                            radius: 30,
                            lineWidth: 8,
                            animation: true,
                            animationDuration: 1500,
                            circularStrokeCap: CircularStrokeCap.round,
                            percent: sellerRatio.toPrecision(2),
                            progressColor: Colors.white,
                            center: Text(
                              "${sellerRatioPercent.toStringAsFixed(2)}%",
                              style: const TextStyle(color: Colors.white),
                            ),
                          )
                        ],
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            // course[index].imageUrl,
                            tSellerImage,
                            height: 110,
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage(tBox2), fit: BoxFit.fill),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          const Text(
                            'Student',
                            style: TextStyle(color: Colors.white),
                          ),
                          Text(
                            studentCount.toString(),
                            style: const TextStyle(color: Colors.white),
                          ),
                          CircularPercentIndicator(
                            radius: 30,
                            lineWidth: 8,
                            animation: true,
                            animationDuration: 1500,
                            circularStrokeCap: CircularStrokeCap.round,
                            percent: studentRatio.toPrecision(2),
                            progressColor: Colors.white,
                            center: Text(
                              "${studentRatioPercent.toStringAsFixed(2)}%",
                              style: const TextStyle(color: Colors.white),
                            ),
                          )
                        ],
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            // course[index].imageUrl,
                            tBuyerImage,

                            height: 110,
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage(tBox3), fit: BoxFit.fill),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          const Text(
                            'Administrator',
                            style: TextStyle(color: Colors.white),
                          ),
                          Text(
                            administratorCount.toString(),
                            style: const TextStyle(color: Colors.white),
                          ),
                          CircularPercentIndicator(
                            radius: 30,
                            lineWidth: 8,
                            animation: true,
                            animationDuration: 1500,
                            circularStrokeCap: CircularStrokeCap.round,
                            percent: administratorRatio.toPrecision(2),
                            progressColor: Colors.white,
                            center: Text(
                              "${adminRatioPercent.toStringAsFixed(2)}%",
                              style: const TextStyle(color: Colors.white),
                            ),
                          )
                        ],
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            // course[index].imageUrl,
                            tAdminImage,
                            height: 110,
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ],
          );
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          return const CircularProgressIndicator();
        }
      },
    );
  }
}
