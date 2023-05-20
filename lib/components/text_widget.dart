import 'package:flutter/material.dart';

class MyTextWidget extends StatelessWidget {
  const MyTextWidget({
    Key? key,
    required this.text,
    this.textSize,
    required this.isTitle,
    this.color,
    this.alignment,
  }) : super(key: key);

  final String text;
  final double? textSize;
  final bool isTitle;
  final Color? color;
  final TextAlign? alignment;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
          color: color,
          fontWeight: isTitle ? FontWeight.bold : FontWeight.normal,
          fontSize: textSize),
      textAlign: alignment,
    );
  }
}
