import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:myposbook/constants.dart';
import 'package:myposbook/screens/dashboard_screens/other_screens/cashouts_records/components/amount_transaction_section.dart';
import 'package:http/http.dart' as http;

class RecordButtonPageView extends StatefulWidget {
  final recordType;
  const RecordButtonPageView({
    Key? key,
    required this.recordType,
  }) : super(key: key);

  @override
  State<RecordButtonPageView> createState() => _RecordButtonPageViewState();
}

class _RecordButtonPageViewState extends State<RecordButtonPageView> {
  @override
  Widget build(BuildContext context) {
    final PageController pageController = PageController();
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Column(
      children: [
        SizedBox(
          height: screenHeight * 0.05,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: [
              ElevatedButton(
                onPressed: () {
                  pageController.animateToPage(
                    0,
                    duration: Duration(milliseconds: 350),
                    curve: Curves.easeInCubic,
                  );
                },
                child: Text('Today'),
              ),
              SizedBox(
                width: screenWidth * 0.015,
              ),
              ElevatedButton(
                onPressed: () {
                  pageController.animateToPage(
                    1,
                    duration: Duration(milliseconds: 350),
                    curve: Curves.easeInCubic,
                  );
                },
                child: Text('Yesterday'),
              ),
              SizedBox(
                width: screenWidth * 0.015,
              ),
              ElevatedButton(
                onPressed: () {
                  pageController.animateToPage(
                    2,
                    duration: Duration(milliseconds: 350),
                    curve: Curves.easeInCubic,
                  );
                },
                child: Text('This Week'),
              ),
              SizedBox(
                width: screenWidth * 0.015,
              ),
              ElevatedButton(
                onPressed: () {
                  pageController.animateToPage(
                    3,
                    duration: Duration(milliseconds: 350),
                    curve: Curves.easeInCubic,
                  );
                },
                child: Text('This Month'),
              ),
              SizedBox(
                width: screenWidth * 0.015,
              ),
              ElevatedButton(
                onPressed: () {
                  pageController.animateToPage(
                    4,
                    duration: Duration(milliseconds: 350),
                    curve: Curves.easeInCubic,
                  );
                },
                child: Text('This Year'),
              ),
            ],
          ),
        ),
        FutureBuilder(
          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
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
              }
              // using the data from the
              else if (snapshot.hasData) {
                dynamic data = snapshot.data;

                // decode json
                dynamic decodedJson = jsonDecode(data);

                // date ranges
                final today = decodedJson['today'];
                final yesterday = decodedJson['yesterday'];
                final thisWeek = decodedJson['this_week'];
                final thisMonth = decodedJson['this_month'];

                return SizedBox(
                  height: screenHeight * 0.8,
                  child: PageView(
                    controller: pageController,
                    // onPageChanged: (index) => print(index),
                    children: [
                      RecordAmountTransaction(
                        recordAmount: today['todays_total_amount'],
                        recordCharge: today['todays_total_charges'],
                        transactions: today['transactions'],
                      ),
                      RecordAmountTransaction(
                        recordAmount: yesterday['yesterdays_total_amount'],
                        recordCharge: yesterday['yesterdays_total_charges'],
                        transactions: yesterday['transactions'],
                      ),
                      RecordAmountTransaction(
                        recordAmount: thisWeek['week_total_amount'],
                        recordCharge: thisWeek['week_total_charges'],
                        transactions: thisWeek['transactions'],
                      ),
                      RecordAmountTransaction(
                        recordAmount: thisMonth['month_total_amount'],
                        recordCharge: thisMonth['month_total_charges'],
                        transactions: thisMonth['transactions'],
                      ),
                      RecordAmountTransaction(
                        recordAmount: decodedJson['this_years']
                            ['years_total_amount'],
                        recordCharge: decodedJson['this_years']
                            ['years_total_charges'],
                        transactions: today['transactions'],
                      ),
                    ],
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
          future: recordForThePeriod(recordType: widget.recordType),
        ),
      ],
    );
  }

  // get record for the periods
  Future recordForThePeriod({recordType}) async {
    // secure storage
    final storage = await secureStorage();
    final accessToken = storage['access_token'];

    // build the url and headers
    final apiURL = Uri.https(APIUrlRoot, 'api/$recordType/');

    Map<String, String> requestHeaders = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $accessToken',
    };

    // make the request
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
