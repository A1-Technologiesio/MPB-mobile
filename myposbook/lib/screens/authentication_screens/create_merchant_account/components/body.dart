import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:myposbook/constants.dart';

class CreateMerchantAcctBody extends StatefulWidget {
  const CreateMerchantAcctBody({Key? key}) : super(key: key);

  @override
  State<CreateMerchantAcctBody> createState() => _CreateMerchantAcctBodyState();
}

class _CreateMerchantAcctBodyState extends State<CreateMerchantAcctBody> {
  // form controllers
  final TextEditingController _posBusinessName = TextEditingController();
  final TextEditingController _LGA = TextEditingController();

  // form key
  final _formKey = GlobalKey<FormState>();

  // dropdown value
  String dropDownValue = listOfStates.first;

  // chip value
  int chipValue = 0;
  String? item;

  // empty list to hold pos terminals from state
  List posTerminalsApiList = [];

  // items selected stored here.
  List selectedItems = [];

  // APi data future
  Future posTerminalsList() async {
    final url = Uri.https(APIUrlRoot, 'api/pos-terminals');
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

  void initState() {
    super.initState();
    posTerminalsList();
  }

  @override
  Widget build(BuildContext context) {
    // definition of variables
    const formBgColor = Color(0xffF5F5F5);
    var mediaHeight = MediaQuery.of(context).size.height;
    var mediaWidth = MediaQuery.of(context).size.width;

    // spacing between form items
    var spaceBetweenFormFIelds = SizedBox(
      height: mediaHeight * 0.02,
    );

    Future CreateMerchantAccount() async {
      // merchant account endpoint constructed
      var APIURL = Uri.https(APIUrlRoot, 'api/create/merchant-account/');

      // get the access token.
      final storage = await secureStorage();
      final accessToken = storage['access_token'];

      // convert List to comma separated string
      String myPosTerminals = selectedItems.join(', ');

      // user body and authorisation
      Map userData = {
        'pos_business_name': _posBusinessName.text,
        'local_government_area': _LGA.text,
        'state': dropDownValue,
        'my_pos_terminals': myPosTerminals,
        // ''
      };

      Map<String, String> requestHeaders = {
        // 'Content-type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $accessToken',
      };

      http.Response response = await http.post(
        APIURL,
        body: userData,
        headers: requestHeaders,
      );

      if (response.statusCode == 201) {
        // Navigator.pushReplacement(context, newRoute)
        const merchantSnackbarMessage = SnackBar(
          content: Text('Account Successfully Created.'),
        );
        ScaffoldMessenger.of(context).showSnackBar(merchantSnackbarMessage);
        Navigator.pushNamed(context, '/dashboard_main');
      }
      // on unauthorized error
      else if (response.statusCode == 401) {
        // where the login credentials provided a 401 error
        const errorSnackBar = SnackBar(
          content:
              Text('Oops, there was an error, Check your username or password'),
        );
        ScaffoldMessenger.of(context).showSnackBar(errorSnackBar);
        Navigator.pushNamed(context, '/login');
      }
    }

    return SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: mediaWidth * 0.07,
        ),
        child: ListView(
          children: [
            SizedBox(
              height: mediaHeight * 0.18,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    'Merchant Account Info',
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: mediaHeight * 0.029,
                    ),
                  ),
                ],
              ),
            ),
            spaceBetweenFormFIelds,
            Form(
              key: _formKey,
              child: Column(
                children: [
                  // POS Business Name
                  TextFormField(
                    controller: _posBusinessName,
                    decoration: InputDecoration(
                      // labelText: 'Username',
                      hintText: 'POS Business Name',
                      fillColor: formBgColor,
                      filled: true,
                      border: InputBorder.none,
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please Enter POS Business Name';
                      }
                      return null;
                    },
                  ),
                  spaceBetweenFormFIelds,

                  // Local Government Area field
                  TextFormField(
                    controller: _LGA,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'LGA',
                      fillColor: formBgColor,
                      filled: true,
                    ),
                  ),

                  spaceBetweenFormFIelds,

                  // Dropdown of states
                  SizedBox(
                    width: double.infinity,
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        color: formBgColor,
                      ),
                      child: DropdownButton<String>(
                        icon: const Visibility(
                          visible: false,
                          child: Icon(Icons.arrow_downward),
                        ),
                        underline: SizedBox(),
                        value: dropDownValue,
                        items: listOfStates
                            .map<DropdownMenuItem<String>>(
                                (String _value) => DropdownMenuItem<String>(
                                      value: _value,
                                      child: Text(_value),
                                    ))
                            .toList(),
                        onChanged: (String? value) {
                          setState(() {
                            dropDownValue = value!;
                          });
                        },
                      ),
                    ),
                  ),
                  spaceBetweenFormFIelds,

                  // choice chips
                  SizedBox(
                    width: double.infinity,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Select the POS Terminals you are currently using',
                        ),
                        Wrap(
                          runSpacing: 1.0,
                          spacing: 3.0,
                          crossAxisAlignment: WrapCrossAlignment.start,
                          children: List.generate(
                            posTerminalsApiList.length,
                            (index) {
                              return ChoiceChip(
                                label: Text(posTerminalsApiList[index]['name']),
                                selected: posTerminalsApiList[index]['status'],
                                onSelected: (value) {
                                  setState(() {
                                    if (selectedItems.contains(
                                        posTerminalsApiList[index]['name'])) {
                                      selectedItems.remove(
                                          posTerminalsApiList[index]['name']);
                                      posTerminalsApiList[index]['status'] =
                                          false;
                                    } else {
                                      selectedItems.add(
                                          posTerminalsApiList[index]['name']);
                                      posTerminalsApiList[index]['status'] =
                                          true;
                                    }
                                  });
                                },
                              );
                            },
                          ),
                          // []
                          // [
                          //   // posTerminalsApiList.map((e) {
                          //   //   return '';
                          //   // }).toList(),

                          // ],
                        ),
                      ],
                    ),
                  ),
                  spaceBetweenFormFIelds,

                  // submit button
                  SizedBox(
                    width: double.infinity,
                    height: mediaHeight * 0.06,
                    child: ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          _formKey.currentState!.save();
                          CreateMerchantAccount();
                        }
                      },
                      child: Text(
                        'Save Details',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xff27142A),
                      ),
                    ),
                  ),
                  //
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
