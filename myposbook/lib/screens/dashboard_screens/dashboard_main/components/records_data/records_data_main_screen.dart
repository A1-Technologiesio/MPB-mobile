import 'package:flutter/material.dart';
import 'package:myposbook/screens/dashboard_screens/dashboard_main/components/records_data/components/body.dart';

class RecordsDataMainScreen extends StatelessWidget {
  const RecordsDataMainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RecordDataBody(),
    );
  }
}
