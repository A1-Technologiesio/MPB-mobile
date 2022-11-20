import 'package:flutter/material.dart';
import 'package:myposbook/constants.dart';
import 'package:myposbook/screens/dashboard_screens/dashboard_main/components/pos_terminals/components/terminal_data_row.dart';

class PosTerminalBody extends StatelessWidget {
  const PosTerminalBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ListView(children: [
        TerminalDataRow(),
      ]),
    );
    //   child: Column(
    //     mainAxisAlignment: MainAxisAlignment.start,
    //     children: [
    //       Row(
    //         mainAxisAlignment: MainAxisAlignment.spaceAround,
    //         children: [
    //           Text('Terminal/Bank Name'),
    //           Row(
    //             // mainAxisAlignment: MainAxisAlignment.spaceAround,
    //             children: [
    //               Text('% Charges'),
    //               SizedBox(
    //                 width: MediaQuery.of(context).size.width * 0.03,
    //               ),
    //               Text('Deposit Rate'),
    //             ],
    //           )
    //         ],
    //       ),
    //       Row(
    //         mainAxisAlignment: MainAxisAlignment.spaceAround,
    //         children: [
    //           Text('Moniepoint'),
    //           Row(
    //             // mainAxisAlignment: MainAxisAlignment.spaceAround,
    //             children: [
    //               Text('0.5'),
    //               SizedBox(
    //                 width: MediaQuery.of(context).size.width * 0.03,
    //               ),
    //               Text('20'),
    //             ],
    //           )
    //         ],
    //       )
    //     ],
    //   ),
    // );
  }
}
