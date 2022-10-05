import 'package:flutter/material.dart';
import '../../../dashboard_main/components/amount_display/amount_display_section.dart';
import '../../shared_components/transaction_items.dart';

class RecordAmountTransaction extends StatelessWidget {
  final recordAmount;
  final recordCharge;
  List transactions = [];

  RecordAmountTransaction({
    Key? key,
    required this.recordAmount,
    required this.recordCharge,
    required this.transactions,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Column(
      children: [
        // Amount row
        AmountDisplaySection(
          recordTitle: 'Amount',
          recordAmount: recordAmount.toString(),
          recordTotalCharge: recordCharge.toString(),
          leftSideColor: Color(0xff27142A),
          rightSideColor: Color(0xff225560),
        ),

        // Transactions section
        const Align(
          alignment: Alignment.centerLeft,
          child: Text('Transactions'),
        ),

        // transaction items
        if (transactions.isEmpty)
          Column(
            children: [
              Image.asset(
                'lib/assets/images/undraw_void_3ggu.png',
                height: screenHeight * 0.18,
              ),
              SizedBox(
                height: screenHeight * 0.015,
              ),
              Text(
                'You have no transactions today',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: screenHeight * 0.02,
                ),
              ),
            ],
          )
        else
          Column(
            children: [
              for (var transaction in transactions)
                transactionItem(
                  transaction['title'],
                  transaction['date_time'],
                  transaction['amount'].toString(),
                  transaction['charge'].toString(),
                  mediaHeight: screenHeight,
                  mediaWidth: screenWidth,
                )
            ],
          )

        // transactionItem(
        //   'transactionTitle',
        //   'transactionDate',
        //   '2000',
        //   '600',
        //   mediaHeight: screenHeight,
        //   mediaWidth: screenWidth,
        // ),
        // transactionItem(
        //   'transactionTitle',
        //   'transactionDate',
        //   '2000',
        //   '600',
        //   mediaHeight: screenHeight,
        //   mediaWidth: screenWidth,
        // ),
        // transactionItem(
        //   'transactionTitle',
        //   'transactionDate',
        //   '2000',
        //   '600',
        //   mediaHeight: screenHeight,
        //   mediaWidth: screenWidth,
        // ),
      ],
    );
  }
}
