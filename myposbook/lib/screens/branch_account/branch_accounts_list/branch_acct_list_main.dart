import 'package:flutter/material.dart';
import 'package:myposbook/screens/branch_account/branch_accounts_list/components/body.dart';

class BranchAccountListMain extends StatelessWidget {
  const BranchAccountListMain({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BranchAcctListBody(),
    );
  }
}
