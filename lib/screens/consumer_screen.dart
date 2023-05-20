import 'package:flutter/material.dart';
import 'package:hisaap_app/components/global_methods.dart';
import 'package:hisaap_app/screens/post_screen.dart';
import 'package:hisaap_app/screens/transactions_screen.dart';
import 'package:hisaap_app/widgets/users_check_box.dart';

import '../components/text_widget.dart';
import '../services/db.dart';

class ConsumerScreen extends StatefulWidget {
  const ConsumerScreen({super.key, required this.consumerName});
  final String consumerName;
  @override
  State<ConsumerScreen> createState() => _ConsumerScreenState();
}

class _ConsumerScreenState extends State<ConsumerScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(widget.consumerName),
      ),
      body: SafeArea(
        child: Column(children: [
          Expanded(
            flex: 4,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 350),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: Colors.redAccent,
                      borderRadius: BorderRadius.circular(5),
                      //shape: BoxShape.circle
                    ),
                    height: 100,
                    width: 150,
                    child: const MyTextWidget(
                      text: '500',
                      isTitle: true,
                      color: Colors.white,
                      textSize: 25,
                    ),
                  ),
                  const SizedBox(
                    width: 50,
                  ),
                  Container(
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: Colors.green.shade400,
                      borderRadius: BorderRadius.circular(5),
                      //shape: BoxShape.circle
                    ),
                    height: 100,
                    width: 150,
                    child: const MyTextWidget(
                      text: '700',
                      isTitle: true,
                      color: Colors.white,
                      textSize: 25,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 30),
            child: ElevatedButton(
              style: ButtonStyle(
                  minimumSize: MaterialStateProperty.all(
                      const Size(double.infinity, 50)),
                  backgroundColor: MaterialStateProperty.all(
                      Theme.of(context).primaryColor)),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    //  builder: (context) => const UsersCheckbox(),

                    builder: (context) =>
                        PostScreen(userToPost: widget.consumerName),
                  ),
                );
              },
              child: const MyTextWidget(
                text: 'Post new transaction',
                isTitle: true,
                color: Colors.white,
                textSize: 17,
              ),
            ),
          ),
        ]),
      ),
      endDrawer: Drawer(
        width: 230,
        backgroundColor: Theme.of(context).secondaryHeaderColor,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(
                bottom: 10,
              ),
              child: ListTile(
                style: ListTileStyle.list,
                tileColor: Theme.of(context).primaryColorLight,
                title: const MyTextWidget(
                  text: 'View previous transcations',
                  isTitle: true,
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          TransactionsScreen(consumerName: widget.consumerName),
                    ),
                  ).then((value) {
                    Navigator.pop(context);
                  });
                },
              ),
            ),
            ListTile(
              style: ListTileStyle.list,
              tileColor: Theme.of(context).primaryColorLight,
              title: const MyTextWidget(
                text: 'Delete all transactions',
                isTitle: true,
              ),
              onTap: () async {
                DB user = DB();
                await user.deleteAllEntries(widget.consumerName);
                GlobalMethods.popUpDialog(
                    title: 'Deleted',
                    subtitle:
                        'Your all previous transcations have been deleted',
                    context: context,
                    haveIcon: false,
                    function: () {
                      Navigator.pop(context);
                    });
              },
            ),
          ],
        ),
      ),
    );
  }
}
