import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:hisaap_app/components/text_widget.dart';
import 'package:hisaap_app/screens/remove_user_screeen.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const MyTextWidget(text: 'Setting', isTitle: true),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(top: 20),
          child: ListTile(
            leading: const Icon(IconlyBold.user2),
            title: const MyTextWidget(
              text: 'Remove user',
              isTitle: true,
              textSize: 20,
            ),
            trailing: const Icon(
              IconlyBold.delete,
              color: Colors.red,
            ),
            enableFeedback: true,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const RemoveUserScreen(),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
