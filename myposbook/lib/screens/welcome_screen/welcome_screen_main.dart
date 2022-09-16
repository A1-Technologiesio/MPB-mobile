import 'package:flutter/material.dart';
import 'package:myposbook/screens/welcome_screen/components/body.dart';

class WelcomeScreenMain extends StatelessWidget {
  const WelcomeScreenMain({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WelcomeScreenBody(),
    );
  }
}
