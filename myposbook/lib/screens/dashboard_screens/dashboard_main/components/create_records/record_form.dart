import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:myposbook/constants.dart';
import 'package:http/http.dart' as http;

class RecordForm extends StatefulWidget {
  String recordRoute;
  RecordForm({
    Key? key,
    required this.recordRoute,
  }) : super(key: key);

  @override
  State<RecordForm> createState() => _RecordFormState();
}

class _RecordFormState extends State<RecordForm> {
  final _formKey = GlobalKey<FormState>();
  String dropDownValue = '';

  TextField recordDataForm(String label, controller) => TextField(
        keyboardType: TextInputType.number,
        controller: controller,
        style: const TextStyle(color: Colors.white70),
        decoration: InputDecoration(
            labelText: label,
            labelStyle: const TextStyle(
              color: Colors.white70,
            ),
            enabledBorder: const UnderlineInputBorder(
              borderSide: BorderSide(
                color: Colors.white,
              ),
            ),
            focusedBorder: const UnderlineInputBorder(
                borderSide: BorderSide(
              color: Colors.white54,
            ))),
      );

  // override initState
  List posTerminalsApiList = [];

  // List of Terminals future
  Future posTerminalsList() async {
    final url = Uri.https(APIUrlRoot, 'api/cashout/create/');
    dynamic tokenStorage = await secureStorage();
    String accessToken = tokenStorage['access_token'];

    // get token
    Map<String, String> requestHeaders = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $accessToken',
    };

    http.Response response = await http.get(url, headers: requestHeaders);

    // convert list<dynamic> to List <String>
    final jsonData = jsonDecode(response.body) as List;
    List<String> posTers = jsonData.map((e) => e.toString()).toList();

    setState(() {
      posTerminalsApiList = posTers;
      dropDownValue = posTerminalsApiList.first;
    });
  }

  @override
  void initState() {
    super.initState();
    posTerminalsList();
  }

  @override
  Widget build(BuildContext context) {
    final _amountController = TextEditingController();
    final _chargesController = TextEditingController();

    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    final spaceBetweenForm = SizedBox(
      height: screenHeight * 0.02,
    );

    // create record async function
    Future createRecord() async {
      // form data
      final amount = _amountController.text;
      final charges = _chargesController.text;
      final posTerminal = dropDownValue;

      Map<String, String> formData = {
        'amount': amount,
        'charge': charges,
        'pos_terminal': posTerminal
      };

      // get token from secureStorage
      final storage = await secureStorage();
      final accessToken = storage['access_token'];

      // API
      var constructAPIRoute = Uri.https(
        APIUrlRoot,
        widget.recordRoute,
      );

      Map<String, String> requestHeaders = {
        'Accept': 'application/json',
        'Authorization': 'Bearer $accessToken',
      };

      http.Response response = await http.post(
        constructAPIRoute,
        body: formData,
        headers: requestHeaders,
      );

      if (response.statusCode == 201) {
        // pop all the pages
        Navigator.pop(context);

        // display success message
        const errorSnackBar = SnackBar(
          content: Text('Record successfully stored.'),
          backgroundColor: Colors.green,
          behavior: SnackBarBehavior.floating,
          elevation: 10,
        );
        ScaffoldMessenger.of(context).showSnackBar(errorSnackBar);

        // push to the dashboard main screen.
        Navigator.pushNamed(context, '/dashboard_main');
      }
    }

    return Form(
      key: _formKey,
      child: Column(
        children: [
          // Pos Terminals List
          SizedBox(
            width: double.infinity,
            child: DropdownButton<String>(
              underline: Container(
                height: 1,
                color: Colors.white,
              ),
              value: dropDownValue,
              icon: Padding(
                padding: EdgeInsets.only(
                  left: screenWidth * 0.55,
                  bottom: screenHeight * 0.03,
                ),
                child: const Icon(
                  Icons.arrow_circle_down_sharp,
                  color: brandColor,
                ),
              ),

              // pos terminals
              items:
                  posTerminalsApiList.map<DropdownMenuItem<String>>((_value) {
                return DropdownMenuItem(
                  value: _value,
                  child: Text(
                    _value,
                    style: TextStyle(),
                  ),
                );
              }).toList(),

              // to change the color of the selected item
              selectedItemBuilder: (BuildContext context) => posTerminalsApiList
                  .map((value) => Text(dropDownValue,
                      style: const TextStyle(
                        color: Colors.white70,
                      )))
                  .toList(),

              // on changed
              onChanged: (String? value) {
                setState(() {
                  dropDownValue = value!;
                });
              },
            ),
          ),

          // amount and charge fields
          recordDataForm(
            'Amount',
            _amountController,
          ),
          spaceBetweenForm,

          recordDataForm(
            'Charge',
            _chargesController,
          ),

          spaceBetweenForm,
          spaceBetweenForm,

          // save button
          SizedBox(
              width: double.infinity,
              height: screenHeight * 0.06,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    primary: Color(0xffffffff),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18))),
                onPressed: () {
                  _formKey.currentState!.reset();
                  createRecord();
                },
                child: Text(
                  'Save',
                  style: TextStyle(
                      color: Color(0xff000000),
                      fontWeight: FontWeight.w400,
                      fontSize: 16),
                ),
              )),
        ],
      ),
    );
  }
}
