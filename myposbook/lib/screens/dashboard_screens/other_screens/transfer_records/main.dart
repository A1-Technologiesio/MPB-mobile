import 'package:flutter/material.dart';
import 'package:myposbook/screens/dashboard_screens/other_screens/transfer_records/components/body.dart';

class TransferRecordMainScreen extends StatelessWidget {
  const TransferRecordMainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: TransferRecordBody(),
    );
  }
}
