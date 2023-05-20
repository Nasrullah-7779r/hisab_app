import 'package:flutter/material.dart';
import 'package:hisaap_app/widgets/user_widget.dart';
import '../services/db.dart';

class UserScreen extends StatefulWidget {
  const UserScreen({super.key});

  @override
  State<UserScreen> createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  @override
  Widget build(BuildContext context) {
    DB db = DB();
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Users'),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 5),
          child: Center(
            child: FutureBuilder(
                future: db.getAllUsersFromFirebase(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    final usersList = snapshot.data;

                    return ListView.builder(
                      itemCount: usersList?.length,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return UserWidget(
                          userTitle: usersList!.elementAt(index),
                        );
                      },
                    );
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else {
                    return const CircularProgressIndicator();
                  }
                }),
          ),
        ),
      ),
    );
  }
}
