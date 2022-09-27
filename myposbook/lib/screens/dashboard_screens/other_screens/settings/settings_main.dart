import 'package:flutter/material.dart';
import 'package:myposbook/screens/dashboard_screens/other_screens/settings/components/body.dart';

class SettingsMain extends StatelessWidget {
  const SettingsMain({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text('Settings'),
      // ),
      body: SettingsBody(),
    );
  }
}
