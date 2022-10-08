import 'package:flutter/material.dart';
import 'package:myposbook/screens/dashboard_screens/other_screens/shared_components/transaction_details/body.dart';

class TransactionDetails extends StatelessWidget {
  final transactionID;
  const TransactionDetails({
    Key? key,
    this.transactionID = '',
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: TransactionDetailsBody(
        transactionID: transactionID,
      ),
    );
  }
}
