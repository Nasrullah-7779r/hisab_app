import 'package:flutter/cupertino.dart';
import 'package:hisaap_app/components/text_widget.dart';

class UtilizationScreen extends StatelessWidget {
  const UtilizationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      child: Center(
        child: MyTextWidget(
          text: 'Utilization Screen',
          isTitle: true,
          textSize: 25,
        ),
      ),
    );
  }
}
