import 'package:flutter/material.dart';

class GlobalMethods {
  static pageRoute(BuildContext context, String routeName) {
    Navigator.pushNamed(context, routeName);
  }

  static popUpDialog(
      {required String title,
      required subtitle,
      required Function? function,
      required BuildContext context,
      required bool haveIcon,
      IconData? icon}) async {
    await showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(haveIcon ? icon : null),
                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            content: Text(subtitle),
            actions: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                    onPressed: () {
                      function!();
                      // Navigator.canPop(context) ? Navigator.pop(context) : null;
                    },
                    child: const Text(
                      'Ok',
                      style: TextStyle(color: Colors.cyan),
                    ),
                  ),
                  // TextButton(
                  //   onPressed: () {
                  //     function();
                  //     Navigator.canPop(context) ? Navigator.pop(context) : null;
                  //   },
                  //   child: Text(
                  //     'Ok',
                  //     style: TextStyle(color: Colors.red),
                  //   ),
                  // ),
                ],
              )
            ],
          );
        });
  }

  static Future<void> errorDialog({
    required String title,
    required subtitle,
    Function? function,
    required BuildContext context,
  }) async {
    await showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            content: Text(subtitle),
            actions: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                    onPressed: () {
                      function!();
                      // Navigator.canPop(context) ? Navigator.pop(context) : null;
                    },
                    child: const Text(
                      'Ok',
                      style: TextStyle(color: Colors.cyan),
                    ),
                  ),
                ],
              )
            ],
          );
        });
  }
}
