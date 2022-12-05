import 'package:flutter/material.dart';

class BranchAcctListBody extends StatelessWidget {
  const BranchAcctListBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return SafeArea(
      child: Column(
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'Branch Accounts',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Text(
            'Add another account, So your Employees Keep the Records for you.',
          ),
          Column(
            children: [
              // Existing account heading and number counter
              Row(
                children: [
                  Text('Existing Account'),
                  Text('2/2 Used'),
                ],
              ),

              // Branch Account section
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: Colors.grey[300],
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.person_outline,
                        ),
                      ),
                      SizedBox(
                        width: screenWidth * 0.02,
                      ),
                      Column(
                        children: [
                          Text('James Dean'),
                          Text('newuser123'),
                        ],
                      ),
                    ],
                  ),
                  TextButton(
                    onPressed: () {},
                    child: Text('More'),
                  )
                ],
              )
            ],
          ),
        ],
      ),
    );
  }
}
