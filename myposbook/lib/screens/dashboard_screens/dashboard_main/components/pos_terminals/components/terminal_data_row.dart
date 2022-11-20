import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:myposbook/constants.dart';

class TerminalDataRow extends StatefulWidget {
  const TerminalDataRow({Key? key}) : super(key: key);

  @override
  State<TerminalDataRow> createState() => _TerminalDataRowState();
}

class _TerminalDataRowState extends State<TerminalDataRow> {
  List posTerminalsApiList = [];

  Future posTerminalsList() async {
    final url = Uri.https(APIUrlRoot, 'api/pos-terminals/all-data/');
    http.Response response = await http.get(url);
    // convert list<dynamic> to List <String>
    final jsonData = jsonDecode(response.body) as List;

    // create map for name and status
    List posTerminals = jsonData.map((e) {
      return {
        'name': e,
        'status': false,
      };
    }).toList();

    setState(() {
      posTerminalsApiList = posTerminals;
    });

    return response.body;
  }

  @override
  void initState() {
    super.initState();
    posTerminalsList();
  }

  @override
  Widget build(BuildContext context) {
    return DataTable(
        columns: [
          DataColumn(
              label: Text('POS\nTerminal',
                  style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold))),
          DataColumn(
              label: Text('Percentage\nCharge',
                  style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold))),
          DataColumn(
              label: Text('Deposit \nRate',
                  style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold))),
        ],
        rows: List.generate(
          posTerminalsApiList.length,
          (index) => DataRow(
            cells: [
              DataCell(
                Text(posTerminalsApiList[index]['name']['terminal_name']),
              ),
              DataCell(Text(posTerminalsApiList[index]['name']
                      ['terminal_charges']
                  .toString())),
              DataCell(Text('20')),
            ],
          ),
        )
        // rows: [
        //   DataRow(
        //     cells: [
        //       DataCell(
        //         Text('MoniePoint'),
        //       ),
        //       DataCell(Text('0.5')),
        //       DataCell(Text('20')),
        //     ],
        //   ),
        //   DataRow(cells: [
        //     DataCell(
        //       Text('MoniePoint'),
        //     ),
        //     DataCell(Text('John')),
        //     DataCell(Text('Student')),
        //   ]),
        //   DataRow(cells: [
        //     DataCell(
        //       Text('MoniePoint'),
        //     ),
        //     DataCell(Text('Harry')),
        //     DataCell(Text('Leader')),
        //   ]),
        //   DataRow(cells: [
        //     DataCell(
        //       Text('MoniePoint'),
        //     ),
        //     DataCell(Text('Peter')),
        //     DataCell(Text('Scientist')),
        //   ]),
        // ],

        );
  }
}
