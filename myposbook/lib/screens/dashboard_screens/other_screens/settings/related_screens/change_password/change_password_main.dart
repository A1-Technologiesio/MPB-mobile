import 'package:flutter/material.dart';
import 'package:myposbook/constants.dart';
import 'package:myposbook/screens/dashboard_screens/other_screens/settings/related_screens/change_password/components/body.dart';

class ChangePasswordMain extends StatelessWidget {
  const ChangePasswordMain({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Change Password',
          style: TextStyle(
            color: brandColor,
          ),
        ),
        backgroundColor: Colors.grey[50],
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back,
            color: brandColor,
          ),
        ),
        elevation: 0.0,
      ),
      body: ChangePasswordBody(),
    );
  }
}
