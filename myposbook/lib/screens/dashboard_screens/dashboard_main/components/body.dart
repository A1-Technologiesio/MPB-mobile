import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:myposbook/constants.dart';
import 'package:myposbook/screens/dashboard_screens/dashboard_main/components/amount_display/amount_carousel.dart';
import 'package:http/http.dart' as http;
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class DashboardMainBody extends StatelessWidget {
  const DashboardMainBody({Key? key}) : super(key: key);

  get mediahe => null;

  @override
  Widget build(BuildContext context) {
    final mediaHeight = MediaQuery.of(context).size.height;
    final mediaWidth = MediaQuery.of(context).size.width;

    // Greeting and Plan Heading
    final greetingHeadingStyle =
        TextStyle(fontWeight: FontWeight.bold, fontSize: mediaHeight * 0.022);

    // view dashboard data
    Future DashboardResponse() async {
      // get the access token from secure Storage
      final storage = await secureStorage();
      final accessToken = storage['access_token'];

      // build the URL
      final apiURL = Uri.http(APIUrlRoot, 'api/sum/today/');

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
        Navigator.pushNamed(context, '/login');
      }

      final body = response.body;
      return body;
    }

    // // dashboard data
    // dashboardData() async {
    //   final response = await DashboardResponse();
    //   print(response);
    // }

    // dashboardData();

    // final bodyResponse = DashboardResponse.;
    // print(bodyResponse);
    // if (dashboardResponse.statusCode == 401) {
    //   print('');
    // }
    Padding greetingDataPadding(String statement) => Padding(
          padding: EdgeInsets.symmetric(
            vertical: mediaHeight * 0.01,
          ),
          child: Text(
            statement,
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: mediaHeight * 0.02,
            ),
          ),
        );

    transactionItem(transactionTitle, transactionDate, transactionAmount,
            transactionCharge) =>
        Padding(
          padding: EdgeInsets.symmetric(
            vertical: mediaHeight * 0.005,
          ),
          child: Container(
            decoration: BoxDecoration(
                border: Border(
                    bottom: BorderSide(
              color: Colors.black12,
            ))),
            child: Padding(
              padding: EdgeInsets.symmetric(
                vertical: mediaHeight * 0.015,
                horizontal: mediaWidth * 0.02,
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Container(
                            height: mediaHeight * 0.05,
                            width: mediaWidth * 0.09,
                            decoration: BoxDecoration(
                              color: Color(0xff386FA4),
                              borderRadius: BorderRadius.circular(25),
                            ),
                            child: Icon(
                              Icons.savings,
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(width: mediaWidth * 0.04),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                transactionTitle,
                                style: TextStyle(
                                  fontWeight: FontWeight.w800,
                                ),
                              ),
                              Text(transactionDate)
                            ],
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(transactionAmount),
                          Text(transactionCharge),
                        ],
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        );

    return FutureBuilder(
      builder: (ctx, snapshot) {
        // if the connection is done
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasError) {
            return Center(
              child: Text(
                '${snapshot.error} occured',
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
            );
          } else if (snapshot.hasData) {
            // json data
            dynamic responseData = snapshot.data;
            var jsonDecoding = jsonDecode(responseData);

            var transactions = jsonDecoding['transactions'];

            // Amount heading section
            final cashoutData =
                jsonDecoding['cashout_record_sum']['amount_sum'].toString();
            final depositData =
                jsonDecoding['deposit_record_sum']['amount_sum'].toString();

            // Main dashboard Page
            return SafeArea(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: mediaWidth * 0.04),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      // Top bar section
                      SizedBox(
                        height: mediaHeight * 0.18,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                // left column
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Hello',
                                      style: greetingHeadingStyle,
                                    ),
                                    greetingDataPadding('James')
                                  ],
                                ),

                                // Right Column
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text(
                                      'My POS Book Plan',
                                      style: greetingHeadingStyle,
                                    ),
                                    greetingDataPadding('Free Plan'),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),

                      // Amount Section
                      AmountCarousel(
                        cashoutAmount: cashoutData,
                        depositAmount: depositData,
                      ),
                      // Weekly Records and Profits buttons
                      Padding(
                        padding:
                            EdgeInsets.symmetric(vertical: mediaHeight * 0.035),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              width: mediaWidth * 0.42,
                              child: OutlinedButton(
                                onPressed: () {},
                                child: Text(
                                  'Weekly Records',
                                  style: TextStyle(
                                      color: brandColor,
                                      fontWeight: FontWeight.w700),
                                ),
                                style: OutlinedButton.styleFrom(
                                  side: BorderSide(color: brandColor, width: 2),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: mediaWidth * 0.42,
                              child: ElevatedButton(
                                onPressed: () {},
                                child: Text('Weekly Profits'),
                                style: ElevatedButton.styleFrom(
                                    primary: brandColor),
                              ),
                            ),
                          ],
                        ),
                      ),

                      // Transactions table
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Transactions',
                            textAlign: TextAlign.start,
                            style: TextStyle(
                                fontSize: mediaHeight * 0.026,
                                fontWeight: FontWeight.w900),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: mediaHeight * 0.02,
                      ),

                      // when the transaction from the API is empty
                      if (transactions.isEmpty)
                        Column(
                          children: [
                            Image.asset(
                              'lib/assets/images/undraw_void_3ggu.png',
                              height: mediaHeight * 0.18,
                            ),
                            SizedBox(
                              height: mediaHeight * 0.015,
                            ),
                            Text(
                              'You have no transactions today',
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: mediaHeight * 0.02,
                              ),
                            ),
                          ],
                        )

                      // when the transaction has data
                      else
                        Container(
                          height: mediaHeight * 0.26,
                          child: ListView(
                            children: [
                              for (var item in transactions)
                                transactionItem(
                                  item['title'],
                                  item['date_time'],
                                  item['amount'],
                                  item['charge'],
                                )
                            ],
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            );
          }
        }

        // if the connection is still loading
        return Center(
          child: SpinKitDoubleBounce(
            color: brandColor,
            size: 70,
            duration: const Duration(seconds: 2),
          ),
        );
      },
      future: DashboardResponse(),
    );
  }
}
