import 'package:flutter/material.dart';
import 'package:hisaap_app/components/text_widget.dart';

class UserBalanceWidget extends StatelessWidget {
  const UserBalanceWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: Colors.redAccent,
            borderRadius: BorderRadius.circular(5),
          ),
          height: MediaQuery.of(context).size.height * 0.08,
          width: MediaQuery.of(context).size.width * 0.15,
          child: const MyTextWidget(
            text: '400',
            isTitle: true,
            color: Colors.white,
            textSize: 17,
          ),
        ),
        const SizedBox(
          width: 10,
        ),
        Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: Colors.green.shade400,
            borderRadius: BorderRadius.circular(5),
          ),
          height: MediaQuery.of(context).size.height * 0.08,
          width: MediaQuery.of(context).size.width * 0.15,
          child: const MyTextWidget(
            text: '500',
            isTitle: true,
            color: Colors.white,
            textSize: 17,
          ),
        ),
      ],
    );
  }
}
