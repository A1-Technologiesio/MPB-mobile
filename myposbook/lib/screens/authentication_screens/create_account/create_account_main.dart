import 'package:flutter/material.dart';
import 'package:myposbook/screens/authentication_screens/create_account/components/body.dart';

class CreateAccountMain extends StatelessWidget {
  const CreateAccountMain({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffffffff),
      body: CreateAccountBody(),
    );
  }
}
