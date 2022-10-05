import 'package:flutter/material.dart';
import 'package:myposbook/screens/authentication_screens/create_account/create_account_main.dart';
import 'package:myposbook/screens/authentication_screens/create_merchant_account/create_merchant_account_main.dart';
import 'package:myposbook/screens/authentication_screens/sign_in/sign_in_main.dart';
import 'package:myposbook/screens/dashboard_screens/dashboard_main/components/create_records/cashout_records/cashout_main.dart';
import 'package:myposbook/screens/dashboard_screens/dashboard_main/components/create_records/deposit_records/deposit_main_screen.dart';
import 'package:myposbook/screens/dashboard_screens/dashboard_main/components/records_data/records_data_main_screen.dart';
import 'package:myposbook/screens/dashboard_screens/dashboard_main/dashboard_main_screen.dart';
import 'package:myposbook/screens/dashboard_screens/other_screens/cashouts_records/cashouts_main.dart';
import 'package:myposbook/screens/welcome_screen/welcome_screen_main.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/welcome_screen',
      routes: {
        // welcomescreen routes
        '/welcome_screen': (context) => WelcomeScreenMain(),

        // account createion
        '/create_account': (context) => CreateAccountMain(),
        '/login': (context) => SignInMain(),
        '/create_merchant_account': (context) => CreateMerchantAcctMain(),

        // dashboard main screen
        '/dashboard_main': (context) => DashboardMainScreen(),
        '/records_data': (context) => RecordsDataMainScreen(),
        '/create_cashout': (context) => CreateCashoutMain(),
        '/create_deposit': (context) => CreateDepositRecordMain(),

        // View records
        '/cashout_records': (context) => CashoutRecordsMainScreen(),
      },
    );
  }
}
