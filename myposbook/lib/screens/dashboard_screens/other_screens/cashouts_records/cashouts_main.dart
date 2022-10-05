import 'package:flutter/material.dart';
import 'package:myposbook/screens/dashboard_screens/other_screens/cashouts_records/components/body.dart';

class CashoutRecordsMainScreen extends StatelessWidget {
  const CashoutRecordsMainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CashoutRecordBody(),
    );
  }
}
