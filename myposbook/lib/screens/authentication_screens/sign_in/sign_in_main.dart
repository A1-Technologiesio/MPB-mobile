import 'package:flutter/material.dart';
import 'package:myposbook/screens/authentication_screens/sign_in/components/body.dart';

class SignInMain extends StatelessWidget {
  const SignInMain({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SignInBody(),
    );
  }
}
