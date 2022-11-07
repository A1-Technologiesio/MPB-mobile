import 'package:flutter/material.dart';
import 'package:myposbook/constants.dart';
import 'package:http/http.dart' as http;
import 'package:myposbook/screens/dashboard_screens/other_screens/settings/settings_main.dart';

class ChangePasswordBody extends StatelessWidget {
  const ChangePasswordBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextFormField reusableField(hintText, formController, {validator: null}) {
      return TextFormField(
        validator: validator,
        controller: formController,
        obscureText: true,
        decoration: InputDecoration(
          hintText: hintText,
          border: InputBorder.none,
          fillColor: Color(0xffF5F5F5),
          filled: true,
        ),
      );
    }

    // mediaquery
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    // controllers
    TextEditingController oldPasswordController = TextEditingController();
    TextEditingController newPasswordController = TextEditingController();
    TextEditingController confirmNewPasswordController =
        TextEditingController();

    // form key
    final _formKey = GlobalKey<FormState>();

    // change password
    Future changePasswordLogic() async {
      // get access token
      dynamic tokenStorage = await secureStorage();
      String accessToken = tokenStorage['access_token'];

      Map<String, String> requestHeader = {
        // 'Content-type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $accessToken',
      };

      Map changePasswordData = {
        'old_password': oldPasswordController.text,
        'new_password': newPasswordController.text,
      };

      final merchantUrl = Uri.https(APIUrlRoot, 'api/change-password/');
      http.Response response = await http.put(
        merchantUrl,
        headers: requestHeader,
        body: changePasswordData,
      );

      if (response.statusCode == 200) {
        Navigator.pop(context);
        const loginSnackbar = SnackBar(
          content: Text('Password Changed'),
        );
        ScaffoldMessenger.of(context).showSnackBar(loginSnackbar);
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => SettingsMain(),
          ),
        );
      } else if (response.statusCode == 400) {
        print(response.body);
        const errorSnackBar = SnackBar(
          content: Text(
            'Error on One of the fields',
          ),
          backgroundColor: Colors.red,
          behavior: SnackBarBehavior.floating,
          elevation: 10,
        );
        ScaffoldMessenger.of(context).showSnackBar(errorSnackBar);
      }
    }

    return SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.06),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: screenHeight * 0.05,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'You can update your Password',
                  style: TextStyle(fontSize: screenHeight * 0.025),
                ),
                SizedBox(
                  height: screenHeight * 0.025,
                ),
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(
                          vertical: screenHeight * 0.015,
                        ),
                        child: reusableField(
                          'Old Password',
                          oldPasswordController,
                        ),
                      ),
                      reusableField(
                        'New Password',
                        newPasswordController,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                          vertical: screenHeight * 0.015,
                        ),
                        child: reusableField(
                          'Confirm New Password',
                          confirmNewPasswordController,
                          validator: (value) {
                            newPasswordController == value
                                ? null
                                : "Passwords Dont match";
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(
              height: screenHeight * 0.025,
            ),
            SizedBox(
              height: screenHeight * 0.06,
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    changePasswordLogic();
                    _formKey.currentState!.reset();
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: brandColor,
                ),
                child: const Text(
                  'Update Password',
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
