import 'package:flutter/material.dart';
import 'package:myposbook/constants.dart';
import 'package:myposbook/screens/dashboard_screens/dashboard_main/components/create_records/cashout_records/components/body.dart';

class CreateCashoutMain extends StatelessWidget {
  const CreateCashoutMain({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          decoration: const BoxDecoration(
            color: brandColor,
            // gradient: LinearGradient(
            //     colors: [
            //       brandColor,
            //       Color(0xff225560),
            //     ],
            //     begin: Alignment.topCenter,
            //     end: Alignment.bottomCenter,
            //     stops: [0.3, 1.0]),
          ),
          child: CashoutCreateRecordBody()),
    );
  }
}
