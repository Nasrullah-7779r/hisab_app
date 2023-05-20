import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:hisaap_app/screens/user_screen.dart';

import '../screens/home_screen.dart';
import '../screens/setting_screen.dart';
import '../screens/utilization_screen.dart';

class BottomBarWidget extends StatefulWidget {
  const BottomBarWidget({super.key});

  @override
  State<BottomBarWidget> createState() => _BottomBarWidgetState();
}

class _BottomBarWidgetState extends State<BottomBarWidget> {
  int currentScreenIndex = 3;
  List<Map<String, dynamic>> screens = [
    {'screen': const HomeScreen(), 'title': 'Home'},
    {'screen': const UserScreen(), 'title': 'Users'},
    {'screen': const UtilizationScreen(), 'title': 'Utilization'},
    {'screen': const SettingScreen(), 'title': 'Setting'},
  ];

  void selectedScreenIndex(int screenIndex) {
    setState(() {
      currentScreenIndex = screenIndex;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[currentScreenIndex]['screen'],
      bottomNavigationBar: BottomNavigationBar(
        onTap: selectedScreenIndex,
        enableFeedback: true,
        type: BottomNavigationBarType.fixed,
        currentIndex: currentScreenIndex,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(IconlyBold.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(IconlyBold.user2), label: 'Users'),
          BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.money_dollar), label: 'Utilization'),
          BottomNavigationBarItem(
              icon: Icon(IconlyBold.setting), label: 'Setting')
        ],
      ),
    );
  }
}
