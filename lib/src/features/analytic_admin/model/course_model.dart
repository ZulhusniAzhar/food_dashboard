import 'dart:ui';

class Course {
  final String text;
  int number;
  final String imageUrl;
  double percent;
  final String backImage;
  final Color color;

  Course({
    required this.text,
    required this.number,
    required this.imageUrl,
    required this.percent,
    required this.backImage,
    required this.color,
  });

  Course updateNumber(int newNumber) {
    return Course(
      text: text,
      number: newNumber,
      imageUrl: imageUrl,
      percent: percent,
      backImage: backImage,
      color: color,
    );
  }
}
