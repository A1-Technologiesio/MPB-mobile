import 'package:flutter/material.dart';
import 'package:myposbook/screens/authentication_screens/create_account/create_account_main.dart';
import 'package:myposbook/screens/authentication_screens/create_merchant_account/create_merchant_account_main.dart';
import 'package:myposbook/screens/authentication_screens/sign_in/sign_in_main.dart';
import 'package:myposbook/screens/dashboard_screens/dashboard_main/dashboard_main_screen.dart';
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
        '/create_account': (context) => CreateAccountMain(),
        '/login': (context) => SignInMain(),
        '/create_merchant_account': (context) => CreateMerchantAcctMain(),
        '/dashboard_main': (context) => DashboardMainScreen(),
      },
    );
  }
}
