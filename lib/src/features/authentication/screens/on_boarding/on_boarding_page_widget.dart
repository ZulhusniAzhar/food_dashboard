import 'package:flutter/material.dart';
import '../../models/model_on_boarding.dart';

class OnBoardingPageWidget extends StatelessWidget {
  const OnBoardingPageWidget({
    super.key,
    required this.model,
  });

  final OnBoardingModel model;

  @override
  Widget build(BuildContext context) {
    final saiz = MediaQuery.of(context).size;

    return Container(
      padding: const EdgeInsets.all(50.0),
      color: model.bgColor,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        // mainAxisSize: MainAxisSize.max,
        // crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image(
            image: AssetImage(model.image),
            height: saiz.height * 0.4,
          ),
          Column(
            children: [
              Text(
                model.title,
                style: Theme.of(context).textTheme.titleLarge,
              ),
              Text(model.subTitle, textAlign: TextAlign.center),
            ],
          ),
          Text(
            model.counterText,
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(
            height: 50,
          )
        ],
      ),
    );
  }
}
