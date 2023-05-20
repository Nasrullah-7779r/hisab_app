import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:hisaap_app/components/text_widget.dart';
import 'package:hisaap_app/screens/consumer_screen.dart';
import 'package:hisaap_app/widgets/user_balance_widget.dart';

class UserWidget extends StatelessWidget {
  const UserWidget({super.key, required this.userTitle});
  final String userTitle;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(6),
      margin: const EdgeInsets.all(6),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.deepPurple.shade200),
      child: GestureDetector(
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => ConsumerScreen(
                consumerName: userTitle,
              ),
            ),
          );
        },
        child: ListTile(
          iconColor: Theme.of(context).primaryColorDark,
          title: MyTextWidget(
            text: userTitle,
            isTitle: true,
            textSize: 20,
          ),
          // subtitle: const MyTextWidget(
          //   text: 'This is subtitle',
          //   isTitle: false,
          //   textSize: 20,
          // ),
          leading: const Icon(
            IconlyBold.user2,
            size: 35,
          ),
          trailing: const SizedBox(width: 140, child: UserBalanceWidget()),
        ),
      ),
    );
  }
}
