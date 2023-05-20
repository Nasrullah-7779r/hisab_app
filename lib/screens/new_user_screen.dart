import 'package:flutter/material.dart';

import 'package:hisaap_app/components/global_methods.dart';
import 'package:hisaap_app/components/my_button.dart';
import 'package:hisaap_app/components/text_widget.dart';
import 'package:hisaap_app/user_provider.dart';

import '../services/db.dart';

class NewUserScreen extends StatefulWidget {
  const NewUserScreen({super.key});

  @override
  State<NewUserScreen> createState() => _NewUserScreenState();
}

class _NewUserScreenState extends State<NewUserScreen> {
  final TextEditingController nameController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();

  final FocusNode focusNode = FocusNode();

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              flex: 1,
              child: Padding(
                padding: const EdgeInsets.only(top: 30),
                child: newUserTextFormFields(),
              ),
            ),
            // MyOutlinedButton(
            //   text: 'Register',
            //   screenToJump: GlobalMethods.popUpDialog(
            //       title: 'Registered',
            //       subtitle: 'New user has been registered successfully',
            //       context: context,
            //       haveIcon: false),
            // ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 80, 20, 30),
              child: OutlinedButton(
                style: ButtonStyle(
                    minimumSize: MaterialStateProperty.all(
                        const Size(double.infinity, 50)),
                    backgroundColor: MaterialStateProperty.all(
                        Theme.of(context).primaryColor)),
                onPressed: () async {
                  if (formKey.currentState!.validate()) {
                    UserProvider newUser = UserProvider(
                        name: nameController.text,
                        password: passwordController.text);
                    DB db = DB();
                    await db.addUserToFirebase(newUser) == true
                        ? GlobalMethods.popUpDialog(
                            title: 'Success',
                            subtitle:
                                '${nameController.text} has been registered successfully',
                            context: context,
                            haveIcon: false,
                            function: () {
                              Navigator.pop(context);
                              nameController.clear();
                              passwordController.clear();
                              focusNode.requestFocus();
                            })
                        : GlobalMethods.errorDialog(
                            title: 'Error',
                            subtitle: 'Registration failed',
                            context: context,
                          );
                  }
                },
                child: const MyTextWidget(
                  text: 'Register',
                  isTitle: true,
                  color: Colors.white,
                  textSize: 17,
                ),
              ),
            ),
          ],
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
              controller: passwordController,
              decoration: const InputDecoration(
                hintText: 'Password',
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
                  return 'Invalid password';
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
