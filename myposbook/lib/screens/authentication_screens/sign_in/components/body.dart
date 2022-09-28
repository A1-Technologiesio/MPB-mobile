import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:myposbook/constants.dart';

class SignInBody extends StatefulWidget {
  const SignInBody({Key? key}) : super(key: key);

  @override
  State<SignInBody> createState() => _SignInBodyState();
}

class _SignInBodyState extends State<SignInBody> {
  // controllers
  final TextEditingController _username = TextEditingController();
  final TextEditingController _password = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    // definition of variables
    const formBgColor = Color(0xffF5F5F5);
    var mediaHeight = MediaQuery.of(context).size.height;
    var mediaWidth = MediaQuery.of(context).size.width;

    // spacing between form items
    var spaceBetweenFormFIelds = SizedBox(
      height: mediaHeight * 0.02,
    );

    return SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: mediaWidth * 0.07,
        ),
        child: ListView(
          children: [
            SizedBox(
              height: mediaHeight * 0.18,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    'Welcome Back, Login!',
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: mediaHeight * 0.029,
                    ),
                  ),
                ],
              ),
            ),
            spaceBetweenFormFIelds,
            Form(
              key: _formKey,
              child: Column(
                children: [
                  // username form field
                  TextFormField(
                    controller: _username,
                    decoration: InputDecoration(
                      // labelText: 'Username',
                      hintText: 'Username',
                      fillColor: formBgColor,
                      filled: true,
                      border: InputBorder.none,
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please Enter ';
                      }
                      return null;
                    },
                  ),
                  spaceBetweenFormFIelds,

                  // password
                  TextFormField(
                    controller: _password,
                    obscureText: true,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Password',
                      fillColor: formBgColor,
                      filled: true,
                    ),
                  ),

                  SizedBox(
                    height: mediaHeight * 0.03,
                  ),
                  // submit button
                  SizedBox(
                    width: double.infinity,
                    height: mediaHeight * 0.06,
                    child: ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          SignInUser();

                          // clear the form
                          _formKey.currentState!.reset();

                          // collapse the keyboard
                          FocusScope.of(context).unfocus();
                        }
                      },
                      child: Text(
                        'Login',
                        style: TextStyle(fontWeight: FontWeight.w700),
                      ),
                      style: ElevatedButton.styleFrom(
                        primary: Color(0xff27142A),
                      ),
                    ),
                  ),
                  spaceBetweenFormFIelds,
                  SizedBox(
                    width: double.infinity,
                    child: TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/create_account');
                      },
                      child: Text('No Account yet? Sign Up Here.'),
                      style: TextButton.styleFrom(
                        elevation: 0,
                        primary: Color(0xff726E6E),
                      ),
                    ),
                  ),

                  //
                ],
              ),
            ),

            // divider
            const Divider(
              color: Color(0xff726E6E),
            ),

            // social buttons

            // Google button
            SizedBox(
              height: mediaHeight * 0.06,
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  primary: Color(0xffF5F5F5),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Image.asset('lib/assets/icons/google-icon.png'),
                    const Text(
                      'Continue with Google',
                      style: TextStyle(
                        color: Color(0xff000000),
                      ),
                    )
                  ],
                ),
              ),
            ),

            spaceBetweenFormFIelds,
            // fb button
            SizedBox(
              height: mediaHeight * 0.06,
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  primary: Color(0xffF5F5F5),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Image.asset('lib/assets/icons/facebook-icon.png'),
                    const Text(
                      'Continue with Facebook',
                      style: TextStyle(
                        color: Color(0xff000000),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future CheckMerchantAcctStatus() async {
    // get request check
    var APIURL = Uri.https(APIUrlRoot, 'api/create/merchant-account/');

    dynamic token_storage = await secureStorage();
    String access_token = token_storage['access_token'];

    // get token
    Map<String, String> requestHeaders = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $access_token',
    };

    http.Response response = await http.get(
      APIURL,
      headers: requestHeaders,
    );
    return response;
  }

  Future SignInUser() async {
    var APIURL = Uri.https(APIUrlRoot, 'api/login/');

    Map userData = {
      'username': _username.text,
      'password': _password.text,
      // ''
    };
    try {
      http.Response response = await http.post(
        APIURL,
        body: userData,
      );

      // given the response was successful
      if (response.statusCode == 200) {
        /*
      save the tokens
      */
        final tokenData = jsonDecode(response.body);
        final refreshToken = tokenData['refresh'];
        final accessToken = tokenData['access'];

        final storage = FlutterSecureStorage();
        await storage.deleteAll();
        await storage.write(
          key: 'access_token',
          value: accessToken,
        );

        await storage.write(
          key: 'refresh_token',
          value: refreshToken,
        );

        // Navigator.pushReplacement(context, newRoute)
        const loginSnackbar = SnackBar(
          content: Text('Login Succesful'),
        );
        ScaffoldMessenger.of(context).showSnackBar(loginSnackbar);

        // call the checkMerchantAcctStatus fn and run the check
        //to see if the merchant Acct
        var checkMerchantStatus = await CheckMerchantAcctStatus();
        if (checkMerchantStatus.statusCode == 200) {
          Navigator.popUntil(context, (route) => route.isFirst);
          Navigator.pushNamed(context, '/dashboard_main');
        } else if (checkMerchantStatus.statusCode == 401) {
          Navigator.pushNamed(context, '/login');
        } else if (checkMerchantStatus.statusCode == 403) {
          Navigator.pushNamed(context, '/create_merchant_account');
        }
      } else if (response.statusCode == 401) {
        // where the login credentials provided a 401 error
        const errorSnackBar = SnackBar(
          content:
              Text('Oops, there was an error, Check your username or password'),
          backgroundColor: Colors.red,
          behavior: SnackBarBehavior.floating,
          elevation: 10,
        );
        ScaffoldMessenger.of(context).showSnackBar(errorSnackBar);
      }
    } catch (e) {
      // catch the error
      const errorSnackBar = SnackBar(
        content:
            Text('Unable to connect to our servers. Please try again shortly.'),
        backgroundColor: Colors.red,
        behavior: SnackBarBehavior.floating,
        elevation: 10,
      );
      ScaffoldMessenger.of(context).showSnackBar(errorSnackBar);
    }

    // print('${response.statusCode}');
    // print('${response.body}');
  }
}
