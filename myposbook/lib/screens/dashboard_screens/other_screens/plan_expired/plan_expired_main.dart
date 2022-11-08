import 'package:flutter/material.dart';
import 'package:myposbook/screens/dashboard_screens/other_screens/plan_expired/components/body.dart';

class PlanExpiredMain extends StatelessWidget {
  const PlanExpiredMain({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PlanExpiredBody(),
    );
  }
}
