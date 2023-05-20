import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hisaap_app/screens/home_screen.dart';
import 'package:hisaap_app/screens/post_screen.dart';
import 'package:hisaap_app/services/db.dart';
import 'package:hisaap_app/user_provider.dart';
import 'package:hisaap_app/widgets/bottom_bar_widget.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => UserProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => DB(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(primarySwatch: Colors.deepPurple),
        home: const BottomBarWidget(),
      ),
    );
  }
}
