// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';

import '../../../../constants/image_strings.dart';
import '../../../../constants/text_strings.dart';

class LoginHeaderWidget extends StatelessWidget {
  const LoginHeaderWidget({
    super.key,
    required this.size,
  });

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image(
          image: const AssetImage(tWelcomeImage1),
          height: size.height * 0.25,
        ),
        Text(
          tLoginTitle,
          style: Theme.of(context).textTheme.headline1,
          textAlign: TextAlign.center,
        ),
        Text(
          tLoginSubTitle,
          style: Theme.of(context).textTheme.bodyText1,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
