import 'package:flutter/material.dart';
import 'package:hisaap_app/components/text_widget.dart';
import 'package:hisaap_app/user_provider.dart';
import 'package:provider/provider.dart';

class UsersCheckbox extends StatefulWidget {
  const UsersCheckbox({super.key});

  @override
  State<UsersCheckbox> createState() => _UsersCheckboxState();
}

class _UsersCheckboxState extends State<UsersCheckbox> {
  UserProvider userProvider = UserProvider();

  String selectAll = 'Select all';
  String deSelectAll = 'Deselect all';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Consumer<UserProvider>(
            builder: (context, value, child) {
              return Column(
                children: [
                  const MyTextWidget(
                    text: 'Select users',
                    isTitle: true,
                    textSize: 25,
                  ),
                  const SizedBox(height: 10),
                  Expanded(
                    flex: 4,
                    child: ListView.builder(
                      itemCount: value.getToogleUsersName.length,
                      itemBuilder: (context, index) {
                        return CheckboxListTile(
                            title: MyTextWidget(
                              text: value.getToogleUsersName[index]['name'],
                              isTitle: true,
                              textSize: 20,
                            ),
                            value: value.getToogleUsersName[index]['isChecked'],
                            onChanged: (val) {
                              value.toggleUserCheck(index);
                            });
                      },
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      value.toggleAllUserCheck();
                    },
                    child: MyTextWidget(
                      text: value.getSetall == true
                          ? 'Deselect all'
                          : 'Select all',
                      isTitle: true,
                      textSize: 20,
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
