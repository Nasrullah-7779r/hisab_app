import 'package:flutter/material.dart';
import 'package:hisaap_app/components/text_widget.dart';

import '../components/global_methods.dart';
import '../services/db.dart';

class RemoveUserScreen extends StatefulWidget {
  const RemoveUserScreen({super.key});

  @override
  State<RemoveUserScreen> createState() => _RemoveUserScreenState();
}

class _RemoveUserScreenState extends State<RemoveUserScreen> {
  final TextEditingController nameController = TextEditingController();

  final TextEditingController keyController = TextEditingController();

  final FocusNode focusNode = FocusNode();

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const MyTextWidget(text: 'Remove user', isTitle: true),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              Expanded(child: newUserTextFormFields()),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 30),
                child: ElevatedButton(
                  onPressed: () async {
                    if (formKey.currentState!.validate()) {
                      focusNode.unfocus();
                      DB db = DB();
                      List<String> usersList =
                          await db.getAllUsersFromFirebase();

                      await db.removeUserFromFirebase(
                                  nameController.text, keyController.text) ==
                              true
                          ? GlobalMethods.popUpDialog(
                              title: 'Removed',
                              subtitle:
                                  '${nameController.text} has been removed successfully',
                              context: context,
                              haveIcon: false,
                              function: () {
                                Navigator.pop(context);
                                nameController.clear();
                                keyController.clear();
                                focusNode.unfocus();
                              })
                          : GlobalMethods.errorDialog(
                              title: 'Failed',
                              subtitle:
                                  'Removal failed, ${nameController.text} might not be a user.',
                              context: context,
                              function: () {
                                nameController.clear();
                                keyController.clear();
                                focusNode.unfocus();
                              });
                    }
                  },
                  style: ButtonStyle(
                    minimumSize: MaterialStateProperty.all(
                      const Size(double.infinity, 50),
                    ),
                  ),
                  child: const MyTextWidget(
                    text: 'Remove',
                    color: Colors.white,
                    isTitle: true,
                    textSize: 20,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Form newUserTextFormFields() {
    return Form(
      key: formKey,
      child: Column(
        children: [
          const SizedBox(
            height: 30,
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: TextFormField(
              onEditingComplete: (() {
                nameController.clear();
              }),
              focusNode: focusNode,
              keyboardType: TextInputType.streetAddress,
              textCapitalization: TextCapitalization.sentences,
              controller: nameController,
              maxLines: null,
              decoration: const InputDecoration(
                hintText: 'Name',
              ),
              validator: ((value) {
                if (value == null || value.isEmpty) {
                  return 'Kindly enter a valid name';
                }
                return null;
              }),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: TextFormField(
              obscureText: true,
              controller: keyController,
              onEditingComplete: (() {
                keyController.clear();
              }),
              decoration: const InputDecoration(
                hintText: 'Key',
                // errorBorder: OutlineInputBorder(
                //   borderRadius: BorderRadius.circular(10),
                // ),
              ),
              keyboardType: TextInputType.visiblePassword,
              // inputFormatters: [
              //   FilteringTextInputFormatter.allow(
              //       RegExp(r'^\d+')), // accept only integers

              // ],
              validator: ((value) {
                if (value == null || value.isEmpty) {
                  return 'Invalid key';
                }
                return null;
              }),
            ),
          ),
        ],
      ),
    );
  }
}
