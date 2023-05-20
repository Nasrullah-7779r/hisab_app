import 'package:flutter/material.dart';
import 'package:hisaap_app/screens/new_user_screen.dart';
import '../components/text_widget.dart';
import '../widgets/status_widget.dart';

class HomeScreen extends StatefulWidget {
  final String? title;
  const HomeScreen({
    super.key,
    this.title,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Home'),
      ),
      body: SafeArea(
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.only(top: 40),
              child: Center(child: StatusWidget()),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 100, 20, 30),
              child: OutlinedButton(
                style: ButtonStyle(
                  shape: MaterialStateProperty.all(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(17),
                    ),
                  ),
                  minimumSize: MaterialStateProperty.all(
                      const Size(double.infinity, 50)),
                  backgroundColor:
                      MaterialStateProperty.all(Theme.of(context).primaryColor),
                ),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const NewUserScreen(),
                      ));
                  print('onpressed');
                },
                child: const MyTextWidget(
                  text: 'Add new user',
                  isTitle: true,
                  color: Colors.white,
                  textSize: 19,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
