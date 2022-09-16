import 'package:flutter/material.dart';
import 'package:myposbook/screens/authentication_screens/create_merchant_account/components/body.dart';
import 'package:myposbook/screens/authentication_screens/sign_in/components/body.dart';

class CreateMerchantAcctMain extends StatelessWidget {
  const CreateMerchantAcctMain({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CreateMerchantAcctBody(),
    );
  }
}
