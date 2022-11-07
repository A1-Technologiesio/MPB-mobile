import 'package:flutter/material.dart';
import 'package:myposbook/constants.dart';
import 'package:myposbook/screens/dashboard_screens/other_screens/settings/related_screens/about_mpb/components/body.dart';

class AboutMPBMain extends StatelessWidget {
  const AboutMPBMain({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarReusable('About My POS Book', context),
      body: AboutMPBBody(),
    );
  }
}
