import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:myposbook/constants.dart';

class TransactionDetailsBody extends StatelessWidget {
  final String transactionID;

  const TransactionDetailsBody({
    Key? key,
    required this.transactionID,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    transactionDetailData(dataTitle, dataInfo) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            dataTitle,
            style: TextStyle(
              // fontWeight: FontWeight.w400,
              color: Colors.grey,
            ),
          ),
          SizedBox(
            height: screenHeight * 0.008,
          ),
          Text(
            dataInfo,
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: screenHeight * 0.024,
            ),
          ),
        ],
      );
    }

    print(transactionID);
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: screenWidth * 0.028,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Transaction details header
            SizedBox(
              width: double.infinity,
              height: screenHeight * 0.1,
              // decoration: BoxDecoration(color: Color(0xff000000)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    'Transaction Details',
                    style: TextStyle(
                        // color: Colors.white,
                        fontSize: screenHeight * 0.028),
                  ),
                ],
              ),
            ),

            // transaction details section
            FutureBuilder(
              builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  if (snapshot.hasError) {
                  } else if (snapshot.hasData) {
                    return Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: screenHeight * 0.042,
                      ),
                      child: SizedBox(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            transactionDetailData(
                              'ID',
                              'f85b6bb8-ccd5-4c58-97dc-18f0462b063e',
                            ),
                            Divider(),
                            transactionDetailData(
                              'Amount',
                              '₦ 30,000',
                            ),
                            Divider(),
                            transactionDetailData(
                              'Charges',
                              '₦ 500',
                            ),
                            Divider(),
                            transactionDetailData(
                              'Actual Profits',
                              '₦ 450',
                            ),
                            Divider(),
                            transactionDetailData(
                              'Record date and TIme',
                              '08-10-22 11:29 am',
                            ),
                            Divider(),
                            transactionDetailData(
                              'Record Type',
                              'Cashout',
                            ),
                            Divider(),
                            transactionDetailData(
                              'POS Terminal / Bank',
                              'Kuda',
                            ),
                          ],
                        ),
                      ),
                    );
                  }
                }
                return Center(
                  child: SpinKitDoubleBounce(
                    color: brandColor,
                    size: 70,
                    duration: const Duration(seconds: 2),
                  ),
                );
              },
            ),
            // close button
            SizedBox(
              height: screenHeight * 0.06,
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red[500],
                ),
                onPressed: () => Navigator.pop(context),
                child: Text('Close'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
