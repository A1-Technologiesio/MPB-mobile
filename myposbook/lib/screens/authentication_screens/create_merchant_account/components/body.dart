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
    final url = Uri.http(APIUrlRoot, 'api/pos-terminals');
    http.Response response = await http.get(url);

    // convert list<dynamic> to List <String>
    dynamic data = response.body;
    final jsonData = jsonDecode(response.body) as List;
    List<String> posTers = jsonData.map((e) => e.toString()).toList();

    setState(() {
      posTerminalsApiList = posTers;
    });
  }

  void initState() {
    super.initState();
    posTerminalsList();
    // chipValue = 0;
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

    print(selectedItems);

    Future CreateMerchantAccount() async {
      // set up the merchant link
      var APIURL = Uri.http(APIUrlRoot, 'api/create/merchant-account/');

      final storage = await secureStorage();
      final accessToken = storage['access_token'];

      // user body and authorisation
      Map userData = {
        'pos_business_name': _posBusinessName.text,
        'local_government_area': _LGA.text,
        'state': dropDownValue,
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
                        underline: SizedBox(),
                        value: dropDownValue,
                        icon: Padding(
                          padding: EdgeInsets.only(left: mediaWidth * 0.6),
                          child: const Icon(Icons.arrow_circle_down_sharp),
                        ),
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

                  // choice chips
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Select POS Terminals you use'),
                      Row(
                        // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: List.generate(
                          posTerminalsApiList.length,
                          (index) {
                            return ChoiceChip(
                              label: Text(posTerminalsApiList[index]),
                              selected: chipValue == index,
                              onSelected: (value) {
                                setState(() {
                                  // check if the pos terminal option added exists
                                  // else  remove it from the selected
                                  // items list
                                  if (selectedItems
                                      .contains(posTerminalsApiList[index])) {
                                    selectedItems
                                        .remove(posTerminalsApiList[index]);
                                  }
                                  // then add it
                                  else {
                                    selectedItems
                                        .add(posTerminalsApiList[index]);
                                  }
                                  // print(value);
                                  // print(selectedItems);
                                  chipValue = value ? index : chipValue;
                                });
                              },
                              selectedColor: brandColor,
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
                      Row(
                        children: [
                          ChoiceChip(
                            label: Text('Opay'),
                            selected: false,
                            onSelected: (selected) {
                              setState(() {
                                // chipValue = selected;
                              });
                            },
                          ),
                          ChoiceChip(
                            label: Text('Opay'),
                            selected: false,
                          ),
                          ChoiceChip(
                            label: Text('Opay'),
                            selected: false,
                          ),
                        ],
                      )
                    ],
                  ),

                  // submit button
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          _formKey.currentState!.save();
                          CreateMerchantAccount();
                        }
                      },
                      child: Text('Create Account'),
                      style: ElevatedButton.styleFrom(
                        primary: Color(0xff27142A),
                      ),
                    ),
                  ),
                  spaceBetweenFormFIelds,
                  SizedBox(
                    width: double.infinity,
                    child: TextButton(
                      onPressed: () {},
                      child: Text('I already have an Account'),
                      style: TextButton.styleFrom(
                        elevation: 0,
                        primary: Color(0xff726E6E),
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
