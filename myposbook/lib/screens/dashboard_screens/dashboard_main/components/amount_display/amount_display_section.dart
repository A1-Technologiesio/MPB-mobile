import 'package:flutter/material.dart';

class AmountDisplaySection extends StatelessWidget {
  final String recordTitle;
  final String recordAmount;
  final String recordTotalCharge;
  final Color leftSideColor;
  final Color rightSideColor;
  const AmountDisplaySection({
    Key? key,
    required this.recordTitle,
    required this.recordAmount,
    required this.recordTotalCharge,
    required this.leftSideColor,
    required this.rightSideColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final mediaHeight = MediaQuery.of(context).size.height;
    final mediaWidth = MediaQuery.of(context).size.width;

    Column recordCharges(
            dynamic crossAxisAlign, String recordHeading, String amount) =>
        Column(
          crossAxisAlignment: crossAxisAlign,
          children: [
            Text(
              recordHeading,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: mediaHeight * 0.015,
                  fontWeight: FontWeight.w400),
            ),
            SizedBox(
              height: mediaHeight * 0.01,
            ),
            Text(
              '₦ $amount',
              style: TextStyle(
                color: Colors.white,
                fontSize: mediaHeight * 0.026,
                fontWeight: FontWeight.w800,
              ),
            ),
          ],
        );

    Padding accountHeadingCard() => Padding(
          padding: EdgeInsets.symmetric(
            vertical: mediaHeight * 0.035,
          ),
          child: Container(
            height: mediaHeight * 0.2,
            decoration: BoxDecoration(
                // color: Color(0xff27142A),
                gradient: LinearGradient(
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                    stops: [
                  0.1,
                  1.0,
                ],
                    colors: [
                  leftSideColor,
                  rightSideColor,
                ])),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: mediaWidth * 0.035),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Cashout and charges | Figures row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // left side
                      recordCharges(
                        CrossAxisAlignment.start,
                        recordTitle,
                        recordAmount,
                      ),

                      // right side
                      recordCharges(
                        CrossAxisAlignment.end,
                        'Charges',
                        recordTotalCharge,
                      )
                    ],
                  ),
                  SizedBox(
                    height: mediaHeight * 0.02,
                  ),
                  //  Record button row (new record and View Records button)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: mediaWidth * 0.4,
                        child: ElevatedButton(
                          child: Text(
                            'NEW RECORD',
                            style: TextStyle(color: Colors.black),
                          ),
                          onPressed: () => {
                            Navigator.pushNamed(context, '/create_cashout')
                          },
                          style:
                              ElevatedButton.styleFrom(primary: Colors.white),
                        ),
                      ),
                      SizedBox(
                        width: mediaWidth * 0.4,
                        child: OutlinedButton(
                          child: Text(
                            'VIEW RECORDS',
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                          onPressed: () => {},
                          style: OutlinedButton.styleFrom(
                            side: BorderSide(
                              color: Colors.white,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        );

    return accountHeadingCard();
  }
}
