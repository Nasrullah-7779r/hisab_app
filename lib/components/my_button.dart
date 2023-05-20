import 'package:flutter/material.dart';
import 'package:hisaap_app/components/text_widget.dart';

class MyOutlinedButton extends StatefulWidget {
  final double L, T, R, B, cBorderRadius;
  final Widget screenToJump;

  final String text;

  const MyOutlinedButton({
    super.key,
    this.L = 0,
    this.T = 0,
    this.R = 0,
    this.B = 0,
    this.cBorderRadius = 0,
    required this.text,
    required this.screenToJump,
  });

  @override
  State<MyOutlinedButton> createState() => _MyOutlinedButtonState();
}

class _MyOutlinedButtonState extends State<MyOutlinedButton> {
  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      style: ButtonStyle(
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(widget.cBorderRadius),
          ),
        ),
        minimumSize: MaterialStateProperty.all(const Size(double.infinity, 50)),
        backgroundColor:
            MaterialStateProperty.all(Theme.of(context).primaryColor),
      ),
      onPressed: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => widget.screenToJump,
            ));
      },
      child: MyTextWidget(
        text: widget.text,
        isTitle: true,
        color: Colors.white,
        textSize: 19,
      ),
    );
  }
}
