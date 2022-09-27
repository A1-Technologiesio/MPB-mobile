import 'package:flutter/material.dart';

class RecordDataBody extends StatelessWidget {
  const RecordDataBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ListView(
        children: [
          // Heading
          Row(
            children: [
              // record type  and timeline
              Column(
                children: [
                  Text(
                    'CASHOUTS',
                  ),
                  Text(
                    'Sept 25 - Oct 1, 22',
                  ),
                ],
              ),

              //timeframe dropdown
            ],
          ),
        ],
      ),
    );
  }
}
