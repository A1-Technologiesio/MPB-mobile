import 'package:flutter/material.dart';

import 'transaction_details/transactions_details.dart';

transactionItem(
  transactionTitle,
  transactionDate,
  transactionAmount,
  transactionCharge,
  context,
  transactionID, {
  mediaHeight,
  mediaWidth,
}) =>
    Padding(
      padding: EdgeInsets.symmetric(
        vertical: mediaHeight * 0.005,
      ),
      child: Container(
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: Colors.black12,
            ),
          ),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(
            vertical: mediaHeight * 0.015,
            horizontal: mediaWidth * 0.02,
          ),
          child: TextButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      TransactionDetails(transactionID: transactionID),
                ),
              );
            },
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Container(
                          height: mediaHeight * 0.05,
                          width: mediaWidth * 0.09,
                          decoration: BoxDecoration(
                            color: Color(0xff386FA4),
                            borderRadius: BorderRadius.circular(25),
                          ),
                          child: Icon(
                            Icons.savings,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(width: mediaWidth * 0.04),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              transactionTitle,
                              style: TextStyle(
                                fontWeight: FontWeight.w800,
                                fontSize: mediaHeight * 0.022,
                              ),
                            ),
                            SizedBox(
                              height: mediaHeight * 0.005,
                            ),
                            Text(transactionDate.toString(),
                                style: TextStyle(
                                  fontSize: mediaHeight * 0.02,
                                ))
                          ],
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          transactionAmount,
                          style: TextStyle(
                            fontWeight: FontWeight.w800,
                            fontSize: mediaHeight * 0.022,
                          ),
                        ),
                        SizedBox(
                          height: mediaHeight * 0.005,
                        ),
                        Text(transactionCharge,
                            style: TextStyle(
                              fontSize: mediaHeight * 0.02,
                            )),
                      ],
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
