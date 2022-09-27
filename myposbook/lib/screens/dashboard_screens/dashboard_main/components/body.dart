import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:myposbook/constants.dart';
import 'package:myposbook/screens/dashboard_screens/dashboard_main/components/amount_display/amount_carousel.dart';
import 'package:http/http.dart' as http;
import 'package:myposbook/screens/dashboard_screens/dashboard_main/components/quicklink_button.dart';
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
              fontWeight: FontWeight.w300,
              fontSize: mediaHeight * 0.02,
            ),
          ),
        );

    transactionItem(
      transactionTitle,
      transactionDate,
      transactionAmount,
      transactionCharge,
    ) =>
        Padding(
          padding: EdgeInsets.symmetric(
            vertical: mediaHeight * 0.005,
          ),
          child: Container(
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: Colors.black12,
                ),
              ),
            ),
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
                                  fontSize: 16,
                                ),
                              ),
                              SizedBox(
                                height: mediaHeight * 0.005,
                              ),
                              Text(transactionDate.toString())
                            ],
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            transactionAmount,
                            style: TextStyle(
                              fontWeight: FontWeight.w800,
                              fontSize: 15,
                            ),
                          ),
                          SizedBox(
                            height: mediaHeight * 0.005,
                          ),
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

            // transactions
            var transactions = jsonDecoding['transactions'];

            // biz name
            var pos_name = jsonDecoding['pos_name'];

            // Amount and charges Data
            final cashoutAmount =
                jsonDecoding['cashout_record_sum']['amount_sum'].toString();
            final depositAmount =
                jsonDecoding['deposit_record_sum']['amount_sum'].toString();

            final cashoutCharges =
                jsonDecoding['cashout_record_sum']['charge_sum'].toString();
            final depositCharges =
                jsonDecoding['deposit_record_sum']['charge_sum'].toString();

            final totalChargesToday = jsonDecoding['todays_profit'].toString();
            final disbursedToday = jsonDecoding['total_disbursed'].toString();

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
                                    greetingDataPadding(pos_name)
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

                      // Record display section
                      AmountCarousel(
                        cashoutAmount: cashoutAmount,
                        depositAmount: depositAmount,
                        cashoutCharges: cashoutCharges,
                        depositCharges: depositCharges,
                        totalDisbursedToday: disbursedToday,
                        totalCharges: totalChargesToday,
                      ),

                      /* 
                      quicklinks section
                      */
                      Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: mediaHeight * 0.02,
                            horizontal: mediaWidth * 0.025),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Quick Links',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: mediaHeight * 0.02,
                              ),
                            ),
                          ],
                        ),
                      ),

                      Column(
                        children: [
                          // quicklinks row 1
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              // New Cashout button
                              TextButton(
                                onPressed: () {
                                  Navigator.pushNamed(
                                      context, '/create_cashout');
                                },
                                child: QuickLinkButton(
                                  iconColor: brandColor,
                                  buttonTitle: 'New \n Cashout',
                                  quickLinkIcon: Icons.upload,
                                ),
                              ),

                              // New Deposit Button
                              TextButton(
                                  onPressed: () {
                                    Navigator.pushNamed(
                                        context, '/create_deposit');
                                  },
                                  child: QuickLinkButton(
                                    iconColor: Color(0xff225560),
                                    buttonTitle: 'New \n Deposit',
                                    quickLinkIcon: Icons.download,
                                  )),

                              // Your Record Data
                              TextButton(
                                onPressed: () {},
                                child: QuickLinkButton(
                                  iconColor: Color(0xff000000),
                                  buttonTitle: 'Records \n Data',
                                  quickLinkIcon: Icons.auto_graph,
                                ),
                              ),

                              // View POS Terminals
                              TextButton(
                                  onPressed: () {},
                                  child: QuickLinkButton(
                                    iconColor: Color(0xffE3655B),
                                    buttonTitle: 'POS \n Terminals',
                                    quickLinkIcon: Icons.phone_android_rounded,
                                  )),

                              // apply for new POS Terminal
                            ],
                          )

                          // quicklinks row 2
                        ],
                      ),

                      // Transactions table
                      Padding(
                        padding: EdgeInsets.only(
                          top: mediaHeight * 0.02,
                          left: mediaWidth * 0.025,
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Transactions',
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                  fontSize: mediaHeight * 0.02,
                                  fontWeight: FontWeight.w900),
                            ),
                          ],
                        ),
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
                        Column(
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
