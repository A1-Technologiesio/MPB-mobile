import 'package:flutter/material.dart';
import 'package:myposbook/screens/create_records/record_form.dart';

class CashoutCreateRecordBody extends StatelessWidget {
  CashoutCreateRecordBody({Key? key}) : super(key: key);

 
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [

          // image and intro text
          Image.asset('lib/assets/images/phone-alone.png'),
          Center(
            child: Text('Create New Cashout Record',
            style: TextStyle(
              color: Colors.white
            ),
            ),
          ),

          // forms
          RecordForm(),
          ],
      ),
    );
  }
}