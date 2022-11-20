import 'package:flutter/material.dart';
import 'package:myposbook/constants.dart';
import 'package:myposbook/screens/dashboard_screens/dashboard_main/components/pos_terminals/components/body.dart';

class PosTerminalsMain extends StatelessWidget {
  const PosTerminalsMain({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarReusable('POS Terminals', context),
      body: const PosTerminalBody(),
    );
  }
}
