import 'package:flutter/material.dart';
import 'package:hisaap_app/user_provider.dart';
import 'package:provider/provider.dart';
import '../components/text_widget.dart';
import '../services/db.dart';
import '../user.dart';

class TransactionsScreen extends StatefulWidget {
  const TransactionsScreen({super.key, required this.consumerName});
  final String consumerName;
  @override
  State<TransactionsScreen> createState() => _TransactionScreesnState();
}

class _TransactionScreesnState extends State<TransactionsScreen> {
  DB db = DB();

  List<String> fetchedDescription = [], fetchtedDateTime = [];
  List<int> fetchedAmount = [];

  @override
  void initState() {
    super.initState();
    db.fetchAmountFromFirebase(widget.consumerName).then((list) {
      fetchedAmount = list.cast<int>();
    });

    db.fetchDateTimeFromFirebase(widget.consumerName).then((list) {
      fetchtedDateTime = list!;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(widget.consumerName),
      ),
      body: Consumer<DB>(
        builder: (context, value, child) {
          return FutureBuilder(
            future: value.fetchDesFromFirebase(widget.consumerName),
            builder: (context, snapshot) {
              if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                fetchedDescription = snapshot.data!;

                return ListView.builder(
                  itemCount: fetchedDescription.length,
                  itemBuilder: (context, index) {
                    return Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.purple.shade100),
                      margin: const EdgeInsets.all(10),
                      child: Column(
                        children: [
                          MyTextWidget(
                              text: fetchtedDateTime[index], isTitle: true),
                          ListTile(
                            leading: const Icon(Icons.description),
                            title: MyTextWidget(
                              text: fetchedDescription[index],
                              isTitle: true,
                            ),
                            trailing: MyTextWidget(
                                text: '${fetchedAmount[index]}', isTitle: true),
                          ),
                        ],
                      ),
                    );
                  },
                );
              } else if (!snapshot.hasData || snapshot.data == null) {
                return const Center(child: CircularProgressIndicator());
              } else {
                return const Center(
                  child: MyTextWidget(
                    text: 'There are no entries against this user',
                    isTitle: true,
                    textSize: 25,
                    color: Colors.black,
                    alignment: TextAlign.center,
                  ),
                );
              }
            },
          );
        },
      ),
    );
  }
}
