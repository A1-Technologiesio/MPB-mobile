import 'package:flutter/material.dart';

import 'components/body.dart';

class DepositRecordsMainScreen extends StatelessWidget {
  const DepositRecordsMainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DepositRecordBody(),
    );
  }
}
