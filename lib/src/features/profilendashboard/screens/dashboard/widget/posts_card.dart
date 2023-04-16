// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';

import '../../../../../constants/colors.dart';
import '../../../../../constants/sizes.dart';
import '../../../models/dashboard/postscard_model.dart';

class DashboardPostCard extends StatelessWidget {
  const DashboardPostCard({
    super.key,
    required this.txtTheme,
  });

  final TextTheme txtTheme;

  @override
  Widget build(BuildContext context) {
    final list = DashboardPostCardModel.list;
    double screenHeight = MediaQuery.of(context).size.height;
    return SizedBox(
      height: 400,
      // height: screenHeight,
      child: ListView.builder(
        scrollDirection: Axis.vertical,
        itemCount: list.length,
        shrinkWrap: true,
        itemBuilder: (context, index) => GestureDetector(
          onTap: list[index].onPress,
          child: SizedBox(
            width: 320,
            height: 200,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: tCardBgColor),
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Flexible(
                            child: Text(
                              list[index].title,
                              style: txtTheme.headline4,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          Flexible(
                            child: Image(
                              image: AssetImage(list[index].image),
                              height: 110,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "RM 2.50",
                                style: txtTheme.headline4,
                                overflow: TextOverflow.ellipsis,
                              ),
                              Text(
                                "KTDI",
                                style: txtTheme.bodyText2,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                          const SizedBox(width: tDashboardCardPadding * 4),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5),
                              ),
                            ),
                            onPressed: () {},
                            child: Text(
                              "Details",
                              style: txtTheme.bodyText2
                                  ?.apply(color: Colors.white),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ],
                  )),
            ),
          ),
        ),
      ),
    );
  }
}
