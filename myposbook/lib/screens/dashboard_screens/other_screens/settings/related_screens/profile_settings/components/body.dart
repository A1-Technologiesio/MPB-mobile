import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:myposbook/constants.dart';

// import http stuff
import 'package:http/http.dart' as http;
import 'package:myposbook/screens/dashboard_screens/other_screens/settings/settings_main.dart';

class ProfileSettingsBody extends StatefulWidget {
  const ProfileSettingsBody({Key? key}) : super(key: key);

  @override
  State<ProfileSettingsBody> createState() => _ProfileSettingsBodyState();
}

class _ProfileSettingsBodyState extends State<ProfileSettingsBody> {
  // form key & controllers
  final _formKey = GlobalKey<FormState>();
  final TextEditingController posBusinessName = TextEditingController();
  final TextEditingController localGA = TextEditingController();

  // bunch of variables
  String updateRoute = 'api/update/merchant-account/';
  String posTerminals = '';
  List myTerminals = [];
  List listOfTerminalsSupported = [];
  String state = 'Abuja';

  // get merchant Account data to prefill the form
  Future RetrieveMerchantAcct() async {
    // get access token
    dynamic tokenStorage = await secureStorage();
    String accessToken = tokenStorage['access_token'];

    // login and take the response
    final merchantUrl = Uri.https(APIUrlRoot, updateRoute);
    Map<String, String> requestHeader = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $accessToken',
    };
    http.Response response =
        await http.get(merchantUrl, headers: requestHeader);

    final decodeJsonRes = jsonDecode(response.body);

    // get the list of pos terminals and set them in a map
    // {
    // 'name': POS TERMInal name,
    // 'status': false,
    // }

    List terminals = decodeJsonRes['pos_terminals'];

    // set the state to prefill the forms in flutter
    setState(() {
      posBusinessName.text =
          decodeJsonRes['merchant_account']['pos_business_name'];

      localGA.text = decodeJsonRes['merchant_account']['local_government_area'];
      state = decodeJsonRes['merchant_account']['state'];
      posTerminals = decodeJsonRes['merchant_account']['my_pos_terminals'];
      myTerminals = posTerminals.split(', ');

      listOfTerminalsSupported = terminals.map((e) {
        if (myTerminals.contains(e)) {
          return {
            'name': e,
            'status': true,
          };
        }
        return {
          'name': e,
          'status': false,
        };
      }).toList();
    });

    // return response;
  }

  Future UpdateMerchantAcct() async {
    // get access token
    dynamic tokenStorage = await secureStorage();
    String accessToken = tokenStorage['access_token'];

    Map<String, String> requestHeader = {
      // 'Content-type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $accessToken',
    };

    Map updatedData = {
      'pos_business_name': posBusinessName.text,
      'local_government_area': localGA.text,
      'state': state,
      'my_pos_terminals': myTerminals.join(', '),
    };

    final merchantUrl = Uri.https(APIUrlRoot, updateRoute);
    http.Response response = await http.put(
      merchantUrl,
      headers: requestHeader,
      body: updatedData,
    );

    if (response.statusCode == 200) {
      Navigator.pop(context);
      const loginSnackbar = SnackBar(
        content: Text('Profile Updated'),
      );
      ScaffoldMessenger.of(context).showSnackBar(loginSnackbar);
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => SettingsMain(),
        ),
      );
    } else if (response.statusCode == 400) {
      const errorSnackBar = SnackBar(
        content: Text(
          'Error on One of the fields',
        ),
        backgroundColor: Colors.red,
        behavior: SnackBarBehavior.floating,
        elevation: 10,
      );
      ScaffoldMessenger.of(context).showSnackBar(errorSnackBar);
    }
  }

  @override
  void initState() {
    RetrieveMerchantAcct();
    return super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // resuable form field
    TextField reusableField(hintText, controller) {
      return TextField(
        controller: controller,
        decoration: InputDecoration(
          hintText: hintText,
          border: InputBorder.none,
          fillColor: const Color(0xffF5F5F5),
          filled: true,
        ),
      );
    }

    // Media Queries
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.06),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: screenHeight * 0.05,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'You can update your account Information',
                  style: TextStyle(fontSize: screenHeight * 0.025),
                ),
                SizedBox(
                  height: screenHeight * 0.025,
                ),
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(
                          vertical: screenHeight * 0.015,
                        ),
                        child:
                            reusableField('POS Business Name', posBusinessName),
                      ),
                      reusableField('L.G.A', localGA),

                      // dropdown form
                      Padding(
                        padding: EdgeInsets.symmetric(
                          vertical: screenHeight * 0.015,
                        ),
                        child: SizedBox(
                          width: double.infinity,
                          child: DecoratedBox(
                            decoration: const BoxDecoration(
                              color: formBgColor,
                            ),
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: screenWidth * 0.035,
                              ),
                              child: DropdownButton<String>(
                                icon: const Visibility(
                                  visible: false,
                                  child: Icon(Icons.arrow_downward),
                                ),
                                underline: SizedBox(),
                                value: state,
                                items: listOfStates
                                    .map<DropdownMenuItem<String>>(
                                      (String value) =>
                                          DropdownMenuItem<String>(
                                              value: value, child: Text(value)),
                                    )
                                    .toList(),
                                onChanged: (String? value) {
                                  setState(() {
                                    state = value!;
                                  });
                                },
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Wrap(
                  runSpacing: 1.0,
                  spacing: 3.0,
                  crossAxisAlignment: WrapCrossAlignment.start,
                  children: List.generate(
                    listOfTerminalsSupported.length,
                    (index) {
                      return ChoiceChip(
                        label: Text(listOfTerminalsSupported[index]['name']),
                        selected: listOfTerminalsSupported[index]['status'],
                        onSelected: (value) {
                          setState(() {
                            if (myTerminals.contains(
                                listOfTerminalsSupported[index]['name'])) {
                              myTerminals.remove(
                                  listOfTerminalsSupported[index]['name']);
                              listOfTerminalsSupported[index]['status'] = false;
                            } else {
                              myTerminals
                                  .add(listOfTerminalsSupported[index]['name']);
                              listOfTerminalsSupported[index]['status'] = true;
                            }
                          });
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
            SizedBox(
              height: screenHeight * 0.025,
            ),
            SizedBox(
              height: screenHeight * 0.06,
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  UpdateMerchantAcct();
                  // Navigator.pop(context);
                },
                child: Text(
                  'Update',
                ),
                style: ElevatedButton.styleFrom(backgroundColor: brandColor),
              ),
            )
          ],
        ),
      ),
    );
  }
}
