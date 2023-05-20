import 'package:flutter/material.dart';
import 'package:hisaap_app/user.dart';

import '../components/text_widget.dart';
import '../services/db.dart';

class StatusWidget extends StatefulWidget {
  const StatusWidget({super.key});

  @override
  State<StatusWidget> createState() => _StatusWidgetState();
}

class _StatusWidgetState extends State<StatusWidget> {
  late Future<int>? totalAmount;

  Future<int> getTotalAmount() async {
    DB db = DB();
    final amount = await db.getTotalUsersAmount();
    return amount;
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context),
      child: Container(
        height: 300,
        width: 300,
        decoration: BoxDecoration(
            color: Theme.of(context).backgroundColor, shape: BoxShape.circle),
        child: Column(children: const [
          SizedBox(
            height: 70,
          ),
          Expanded(
            child:
                // child: FutureBuilder<int>(
                //     future: getTotalAmount(),
                //     builder: (BuildContext context, AsyncSnapshot<int> snapshot) {
                //       if (snapshot.connectionState == ConnectionState.waiting) {
                //         // Show a loading spinner while waiting for the future to complete
                //         return const CircularProgressIndicator();
                //       } else if (snapshot.hasError) {
                //         // Show an error message if the future encounters an error
                //         return Text('Error: ${snapshot.error}');
                //       } else {
                //         return
                MyTextWidget(
              text: 'Total Amount',
              //text: '${snapshot.data}',
              isTitle: true,
              textSize: 40,
              alignment: TextAlign.center,
            ),

            // ),
          ),
          Expanded(
            child: MyTextWidget(
              text: "PKR",
              isTitle: true,
              textSize: 30,
            ),
          ),
          Expanded(
            flex: 2,
            child: MyTextWidget(
              text: "Current Utilization",
              isTitle: true,
              textSize: 30,
            ),
          ),
        ]),
      ),
    );
  }
}
