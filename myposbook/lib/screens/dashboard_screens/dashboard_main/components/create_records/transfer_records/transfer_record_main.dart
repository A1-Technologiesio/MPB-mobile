import 'package:flutter/material.dart';
import 'package:myposbook/constants.dart';
import 'package:myposbook/screens/dashboard_screens/dashboard_main/components/create_records/transfer_records/components/body.dart';

class CreateTransferRecordMain extends StatelessWidget {
  const CreateTransferRecordMain({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          decoration: const BoxDecoration(
            color: brandColor,
          ),
          child: CreateTransferRecordBody()),
    );
  }
}
