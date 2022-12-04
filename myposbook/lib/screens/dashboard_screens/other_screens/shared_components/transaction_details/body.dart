import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:myposbook/constants.dart';
import 'package:http/http.dart' as http;
import 'package:myposbook/screens/dashboard_screens/dashboard_main/dashboard_main_screen.dart';

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

    showModalSheet(transID) => showModalBottomSheet(
          context: context,
          backgroundColor: Colors.transparent,
          builder: (BuildContext context) => Container(
            height: screenHeight * 0.4,
            decoration: BoxDecoration(color: Colors.white),
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: screenWidth * 0.18,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Are you sure you want to delete this record ?'),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // confirmation button
                      SizedBox(
                        width: screenWidth * 0.3,
                        child: ElevatedButton(
                          onPressed: () async {
                            removeTransactionItem(
                              transID,
                              context,
                            );
                          },
                          child: Text('Yes'),
                        ),
                      ),

                      // cancel button
                      SizedBox(
                        width: screenWidth * 0.3,
                        child: OutlinedButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text('No'),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        );
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: screenWidth * 0.028,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
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
                            // Transaction details header
                            SizedBox(
                              width: double.infinity,
                              height: screenHeight * 0.1,
                              // decoration: BoxDecoration(color: Color(0xff000000)),
                              child: Row(
                                // crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Transaction Details',
                                    style: TextStyle(
                                        // color: Colors.white,
                                        fontSize: screenHeight * 0.028),
                                  ),
                                  IconButton(
                                    onPressed: () {
                                      showModalSheet(
                                          decodeJson['transaction_id']);
                                    },
                                    icon: Icon(
                                      Icons.delete_outline_rounded,
                                      color: Colors.red[500],
                                    ),
                                  )
                                ],
                              ),
                            ),
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
                              '₦ ${decodeJson['true_profit']}',
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
                  backgroundColor: brandColor,
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

// Future function that call the api Endpoint to get transaction data
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

Future removeTransactionItem(transactionId, context) async {
  // access token
  final storage = await secureStorage();
  final accessToken = storage['access_token'];

  // build the delete url
  final apiURL =
      Uri.https(APIUrlRoot, 'api/transactions/delete/$transactionId/');

  // headers
  Map<String, String> requestHeaders = {
    'Content-type': 'application/json',
    // 'Accept': 'application/json',
    'Authorization': 'Bearer $accessToken',
  };

  // send the delete request
  http.Response response = await http.delete(
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
  // print(response.body);
  if (response.statusCode == 200) {
    Navigator.pop(context);
    const errorSnackBar = SnackBar(
      content: Text('Successfully removed this record'),
      backgroundColor: Colors.greenAccent,
      behavior: SnackBarBehavior.floating,
      elevation: 10,
    );
    ScaffoldMessenger.of(context).showSnackBar(errorSnackBar);

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const DashboardMainScreen(),
      ),
    );
    // return response.body;
  } else if (response.statusCode == 400) {
    Navigator.pop(context);
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const DashboardMainScreen(),
      ),
    );
  }
}
