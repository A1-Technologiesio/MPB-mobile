import 'package:flutter/material.dart';
import 'package:myposbook/screens/dashboard_screens/dashboard_main/components/amount_display/amount_display_section.dart';
import 'package:myposbook/screens/dashboard_screens/other_screens/shared_components/transaction_items.dart';

class CashoutRecordBody extends StatelessWidget {
  const CashoutRecordBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Column(
        children: [
          // Heading and go back button
          Row(
            children: [
              IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.arrow_back,
                ),
              ),
              Text('Cashout Records'),
            ],
          ),

          // Amount row
          AmountDisplaySection(
            recordTitle: 'Amount',
            recordAmount: 2000.toString(),
            recordTotalCharge: 2000.toString(),
            leftSideColor: Color(0xff27142A),
            rightSideColor: Color(0xff225560),
          ),

          // Transactions section
          Align(
            alignment: Alignment.centerLeft,
            child: Text('Transactions'),
          ),
          transactionItem(
            'transactionTitle',
            'transactionDate',
            '2000',
            '600',
            mediaHeight: screenHeight,
            mediaWidth: screenWidth,
          )
        ],
      ),
    );
  }
}
