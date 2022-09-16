import 'package:flutter/material.dart';

class RecordForm extends StatefulWidget {
  const RecordForm({Key? key}) : super(key: key);

  @override
  State<RecordForm> createState() => _RecordFormState();
}

class _RecordFormState extends State<RecordForm> {
 
  // to be replaced with api data 
  List<String> posTerminals = [
    'Select Terminal',
    'Opay',
    'Accelerex',
  ];
  final _formKey = GlobalKey<FormState>();
  print();
  // String dropDownValue = posTerminals.first;

  TextField recordDataForm(String label, controller)=>  TextField(
                controller: controller,
                style: const TextStyle(
                  color: Colors.white70
                ),
                decoration: InputDecoration(
                  labelText: label,
                  labelStyle: const TextStyle(
                    color: Colors.white,
                  ),
                  enabledBorder: const UnderlineInputBorder(      
                      borderSide: BorderSide(color: Colors.white),   
                      ),
                  focusedBorder: const UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.white54)
                  )
                ),
              );


  @override
  Widget build(BuildContext context) {
      final _amountController = TextEditingController();
  final _chargesController = TextEditingController();
return Form(
            key: _formKey,
            child: Column(
            children: [
              // amount and charge fields
              recordDataForm('Amount', _amountController,),
              recordDataForm('Charge', _chargesController,),

              // Pos Terminals List
                DropdownButton<String>(
                  items: posTerminals
                            .map<DropdownMenuItem<String>>(
                                (String _value) => DropdownMenuItem<String>(
                                      value: _value,
                                      child: Text(_value),
                                    ))
                            .toList(),
                            onChanged: (String? value) {
                          setState(() {
                            // dropDownValue = value!;
                          });
                        },
                            ),
              
              // save button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: (){},
                  child: Text('Save',),)
                  ),
              
            ],
          ));
        
  }
}