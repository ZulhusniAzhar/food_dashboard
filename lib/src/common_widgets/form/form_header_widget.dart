// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';

class FormHeaderWidget extends StatelessWidget {
  const FormHeaderWidget({
    Key? key,
    this.imageColor,
    this.heightBetween,
    required this.image,
    required this.title,
    required this.subTitle,
    this.imageHeight = 0.35,
    this.crossAxisAlignment = CrossAxisAlignment.start,
    this.textAlign,
  }) : super(key: key);

  final Color? imageColor;
  final double imageHeight;
  final double? heightBetween;
  final String image, title, subTitle;
  final CrossAxisAlignment crossAxisAlignment;
  final TextAlign? textAlign;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Image(
          image: AssetImage(image),
          color: imageColor,
          height: size.height * imageHeight,
        ),
        SizedBox(height: heightBetween),
        Text(
          title,
          style: Theme.of(context).textTheme.headline1,
          textAlign: textAlign,
        ),
        Text(
          subTitle,
          style: Theme.of(context).textTheme.bodyText1,
          textAlign: textAlign,
        ),
      ],
    );
  }
}
