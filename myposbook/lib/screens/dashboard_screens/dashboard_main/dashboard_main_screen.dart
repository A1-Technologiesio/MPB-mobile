import 'package:flutter/material.dart';
import 'package:myposbook/constants.dart';
import 'package:myposbook/screens/dashboard_screens/dashboard_main/components/body.dart';
import 'package:myposbook/screens/dashboard_screens/other_screens/cashouts_records/cashouts_main.dart';
import 'package:myposbook/screens/dashboard_screens/other_screens/settings/settings_main.dart';
import 'package:myposbook/screens/welcome_screen/welcome_screen_main.dart';

class DashboardMainScreen extends StatefulWidget {
  const DashboardMainScreen({Key? key}) : super(key: key);

  @override
  State<DashboardMainScreen> createState() => _DashboardMainScreenState();
}

class _DashboardMainScreenState extends State<DashboardMainScreen> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    const pageOptions = [
      DashboardMainBody(),
      CashoutRecordsMainScreen(),
      WelcomeScreenMain(),
      SettingsMain(),
    ];

    navBarItem(icon, String title) {
      return BottomNavigationBarItem(
        icon: Icon(
          icon,
          color: Colors.white,
        ),
        label: title,
      );
    }

    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: pageOptions,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (int index) {
          setState(() {
            _currentIndex = index;
          });
        },
        unselectedItemColor: Colors.white70,
        selectedItemColor: Colors.white,
        type: BottomNavigationBarType.fixed,
        backgroundColor: brandColor,
        items: <BottomNavigationBarItem>[
          navBarItem(Icons.home, 'Home'),
          navBarItem(Icons.save, "Cashouts"),
          navBarItem(Icons.download_rounded, "Deposits"),
          navBarItem(Icons.settings, "Settings"),
        ],
      ),
    );
  }
}
