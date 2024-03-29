import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:myposbook/constants.dart';
import 'package:myposbook/screens/authentication_screens/sign_in/sign_in_main.dart';
import 'package:myposbook/screens/branch_account/create_branch_account/components/functions/validators.dart';

class CreateBranchAccountBody extends StatefulWidget {
  const CreateBranchAccountBody({Key? key}) : super(key: key);

  @override
  State<CreateBranchAccountBody> createState() =>
      _CreateBranchAccountBodyState();
}

class _CreateBranchAccountBodyState extends State<CreateBranchAccountBody> {
  // controllers
  final TextEditingController _username = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _firstName = TextEditingController();
  final TextEditingController _lastName = TextEditingController();
  final TextEditingController _phoneNumber = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final TextEditingController _confirmPassword = TextEditingController();

  // form key
  final _formKey = GlobalKey<FormState>();

  // password visibility
  var _confirmPasswordVisibility = false;
  var _passwordVisibility = false;
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
                    'Create Branch Account',
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
                      prefixIcon: Icon(
                        Icons.person_outline_rounded,
                      ),
                    ),
                    validator: (value) =>
                        validateForm(value, 'Enter your Username'),
                  ),
                  spaceBetweenFormFIelds,

                  // email form field
                  TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    controller: _email,
                    decoration: InputDecoration(
                      // labelText: 'Username',
                      hintText: 'Email',
                      fillColor: formBgColor,
                      filled: true,
                      border: InputBorder.none,
                      prefixIcon: Icon(
                        Icons.mail_outline_rounded,
                      ),
                    ),
                    validator: (value) => validateEmail(value),
                  ),
                  spaceBetweenFormFIelds,

                  // first Name form field
                  TextFormField(
                    controller: _firstName,
                    decoration: InputDecoration(
                      // labelText: 'Username',
                      hintText: 'First Name',
                      fillColor: formBgColor,
                      filled: true,
                      border: InputBorder.none,
                      prefixIcon: Icon(
                        Icons.person_outline_rounded,
                      ),
                    ),
                    validator: (value) =>
                        validateForm(value, 'Enter First Name'),
                  ),
                  spaceBetweenFormFIelds,

                  // Lastname form field
                  TextFormField(
                    controller: _lastName,
                    decoration: InputDecoration(
                      // labelText: 'Username',
                      hintText: 'Last Name',
                      fillColor: formBgColor,
                      filled: true,
                      border: InputBorder.none,
                      prefixIcon: Icon(
                        Icons.person_outline_rounded,
                      ),
                    ),
                    validator: (value) =>
                        validateForm(value, 'Enter Last Name'),
                  ),
                  spaceBetweenFormFIelds,

                  // phone number filed
                  TextFormField(
                    controller: _phoneNumber,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Phone Number',
                      fillColor: formBgColor,
                      filled: true,
                      prefixIcon: Icon(
                        Icons.phone_outlined,
                      ),
                    ),
                  ),
                  spaceBetweenFormFIelds,

                  // password
                  TextFormField(
                    controller: _password,
                    obscureText: _passwordVisibility,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Password',
                      fillColor: formBgColor,
                      filled: true,
                      prefixIcon: Icon(
                        Icons.lock_outline,
                      ),
                      suffixIcon: IconButton(
                        icon: Icon(
                          _passwordVisibility
                              ? Icons.visibility
                              : Icons.visibility_off,
                          color: brandColor,
                        ),
                        onPressed: () {
                          setState(() {
                            _passwordVisibility = !_passwordVisibility;
                          });
                        },
                      ),
                    ),
                  ),
                  spaceBetweenFormFIelds,

                  // confirm password
                  TextFormField(
                      controller: _confirmPassword,
                      obscureText: _confirmPasswordVisibility,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Confirm Password',
                        fillColor: formBgColor,
                        filled: true,
                        prefixIcon: Icon(
                          Icons.lock_outline,
                        ),
                        suffixIcon: IconButton(
                          icon: Icon(
                            _confirmPasswordVisibility
                                ? Icons.visibility
                                : Icons.visibility_off,
                            color: brandColor,
                          ),
                          onPressed: () {
                            setState(() {
                              _confirmPasswordVisibility =
                                  !_confirmPasswordVisibility;
                            });
                          },
                        ),
                      ),
                      validator: (value) =>
                          _password.text == value ? null : 'Password Mismatch'),

                  spaceBetweenFormFIelds,
                  // submit button
                  SizedBox(
                    height: mediaHeight * 0.06,
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          RegisterUser();
                          _formKey.currentState!.reset();
                        }
                      },
                      child: Text('Create Account'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(
                          0xff27142A,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: mediaHeight * 0.015,
                    ),
                    child: SizedBox(
                      height: mediaHeight * 0.06,
                      width: double.infinity,
                      child: TextButton(
                        child: Text(
                          'I already have an Account',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                        onPressed: () {
                          Navigator.pushNamed(context, '/login');
                        },
                        style: TextButton.styleFrom(
                          elevation: 0,
                          backgroundColor: Color(0xff726E6E),
                        ),
                      ),
                    ),
                  ),

                  //
                ],
              ),
            ),

            // // divider
            // const Divider(
            //   color: Color(0xff726E6E),
            // ),

            // // social buttons

            // // Google button
            // ElevatedButton(
            //   onPressed: () {},
            //   style: ElevatedButton.styleFrom(
            //     primary: Color(0xffF5F5F5),
            //   ),
            //   child: Row(
            //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            //     children: [
            //       Image.asset('lib/assets/icons/google-icon.png'),
            //       Text(
            //         'Continue with Google',
            //         style: TextStyle(
            //           color: Color(0xff000000),
            //         ),
            //       )
            //     ],
            //   ),
            // ),

            // // fb button
            // ElevatedButton(
            //   onPressed: () {},
            //   style: ElevatedButton.styleFrom(
            //     primary: Color(0xffF5F5F5),
            //   ),
            //   child: Row(
            //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            //     children: [
            //       Image.asset('lib/assets/icons/facebook-icon.png'),
            //       Text(
            //         'Continue with Facebook',
            //         style: TextStyle(
            //           color: Color(0xff000000),
            //         ),
            //       )
            //     ],
            //   ),
            // ),
          ],
        ),
      ),
    );
  }

  Future RegisterUser() async {
    // using http to create the api url
    final APIURL = Uri.https(APIUrlRoot, 'api/sign-up/');

    Map userData = {
      'username': _username.text,
      'email': _email.text,
      'phone_number': _phoneNumber.text,
      'first_name': _firstName.text,
      'last_name': _lastName.text,
      'password': _password.text,
      // ''
    };

    // make the api Request
    http.Response response = await http.post(APIURL, body: userData);

    // given the status code was successful
    if (response.statusCode == 201) {
      // display success message
      var snackbarResponse = SnackBar(content: Text('Account Created'));

      ScaffoldMessenger.of(context).showSnackBar(snackbarResponse);

      // push the next page
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => SignInMain(),
        ),
      );
    }

    // given the api provides a failed response
    // decode the json

    // display the message
    final jsonResponse = jsonDecode(response.body);
    final snackbarResponse =
        SnackBar(content: Text(jsonResponse['username'][0]));

    ScaffoldMessenger.of(context).showSnackBar(snackbarResponse);
  }
}
