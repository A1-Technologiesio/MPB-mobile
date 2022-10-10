import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:myposbook/constants.dart';
import 'package:http/http.dart' as http;

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
                    final decodeJson = jsonDecode(snapshot.data);

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
                              decodeJson['transaction_id'],
                            ),
                            Divider(),
                            transactionDetailData(
                              'Amount',
                              '₦ ${decodeJson['amount']}',
                            ),
                            Divider(),
                            transactionDetailData(
                              'Charges',
                              '₦ ${decodeJson['charge']}',
                            ),
                            Divider(),
                            transactionDetailData(
                              'Actual Profits',
                              '₦ ${decodeJson['charge']}',
                            ),
                            Divider(),
                            transactionDetailData(
                              'Record date and TIme',
                              decodeJson['date_time'],
                            ),
                            Divider(),
                            transactionDetailData(
                              'Record Type',
                              decodeJson['record_type'],
                            ),
                            Divider(),
                            transactionDetailData(
                              'POS Terminal / Bank',
                              decodeJson['pos_terminal'],
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
              future: getTransactionDetail(transactionID, context),
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

  Future getTransactionDetail(transactionID, context) async {
    // get the access token from secure Storage
    final storage = await secureStorage();
    final accessToken = storage['access_token'];

    // build the URL
    final apiURL = Uri.https(APIUrlRoot, 'api/transactions/$transactionID/');

    // headers
    Map<String, String> requestHeaders = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $accessToken',
    };

    // send the request
    http.Response response = await http.get(
      apiURL,
      headers: requestHeaders,
    );

    // when the token is expired
    if (response.statusCode == 401) {
      // where the login credentials provided a 401 error
      const errorSnackBar = SnackBar(
        content: Text('Session Expired you have been logged out.'),
        backgroundColor: Colors.red,
        behavior: SnackBarBehavior.floating,
        elevation: 10,
      );
      ScaffoldMessenger.of(context).showSnackBar(errorSnackBar);
      Navigator.pushNamed(context, '/login');
    }

    return response.body;
  }
}
