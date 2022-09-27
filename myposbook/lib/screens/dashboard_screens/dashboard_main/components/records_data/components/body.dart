import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

List<String> dropDownList = [
  'Yesterday',
  'Today',
  'This Week',
  'This Month',
  'This Year',
];

class RecordDataBody extends StatefulWidget {
  const RecordDataBody({Key? key}) : super(key: key);

  @override
  State<RecordDataBody> createState() => _RecordDataBodyState();
}

class _RecordDataBodyState extends State<RecordDataBody> {
  // dropDownValue
  String dropDownValue = 'Today';

  // chart data
  List<_SalesData> data = [
    _SalesData('Jan', 35),
    _SalesData('Feb', 28),
    _SalesData('Mar', 34),
    _SalesData('Apr', 32),
    _SalesData('May', 40),
  ];

  @override
  Widget build(BuildContext context) {
    final screeHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: screenWidth * 0.035,
        ),
        child: ListView(
          children: [
            // Heading
            SizedBox(
              height: screeHeight * 0.12,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // record type  and timeline
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        'CASHOUTS',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: screeHeight * 0.025,
                        ),
                      ),
                      Text(
                        'Sept 25 - Oct 1, 22',
                        style: TextStyle(
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                    ],
                  ),

                  //timeframe dropdown
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      DropdownButton<String>(
                        value: dropDownValue,
                        underline: const SizedBox(),
                        items: dropDownList
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                        onChanged: (value) => print(value),
                      )
                    ],
                  )
                ],
              ),
            ),

            // divider
            Divider(
              thickness: 2,
            ),

            // Transactions header
            Padding(
              padding: EdgeInsets.symmetric(
                vertical: screeHeight * 0.03,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Transactions this week.',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: screeHeight * 0.006,
                    ),
                    child: Text(
                      '₦1,200,00.34',
                      style: TextStyle(
                        fontSize: screeHeight * 0.035,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  RichText(
                    text: TextSpan(
                      text: '+5.3% ',
                      style: TextStyle(
                        color: Colors.green,
                        fontWeight: FontWeight.bold,
                      ),
                      children: [
                        TextSpan(
                          text: 'vs',
                          style: DefaultTextStyle.of(context).style,
                        ),
                        TextSpan(
                            text: ' ₦ 1,005,334',
                            style: DefaultTextStyle.of(context).style),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // Graph chart
            Column(
              children: [
                SfCartesianChart(
                  primaryXAxis: CategoryAxis(),
                  // title: ChartTitle(
                  //   text: 'Half yearly sales analysis',
                  // ),
                  tooltipBehavior: TooltipBehavior(
                    enable: true,
                  ),
                  series: <ChartSeries<_SalesData, String>>[
                    LineSeries(
                      dataSource: data,
                      xValueMapper: (_SalesData sales, _) => sales.year,
                      yValueMapper: (_SalesData sales, _) => sales.sales,
                      name: 'Sales',
                      dataLabelSettings: const DataLabelSettings(
                        isVisible: true,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Divider(
              thickness: 2,
            ),

            // Transaction & charges
            Padding(
              padding: EdgeInsets.symmetric(
                vertical: screeHeight * 0.014,
              ),
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: screeHeight * 0.02,
                    ),
                    child: Row(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                              border: Border.all(
                                width: 2,
                              ),
                              borderRadius: BorderRadius.circular(50)),
                          child: Padding(
                            padding: const EdgeInsets.all(12),
                            child: Image.asset(
                              'lib/assets/icons/naija-coin-cash.png',
                              height: screeHeight * 0.045,
                            ),
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '₦ 1,200,000.34',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: screeHeight * 0.026,
                              ),
                            ),
                            Text('Total Transactions'),
                          ],
                        )
                      ],
                    ),
                  ),
                  Row(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            border: Border.all(
                              width: 2,
                            ),
                            borderRadius: BorderRadius.circular(50)),
                        child: Padding(
                          padding: const EdgeInsets.all(12),
                          child: Image.asset(
                            'lib/assets/icons/naija-bag.png',
                            height: screeHeight * 0.045,
                          ),
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '₦ 12,000.34',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: screeHeight * 0.026,
                            ),
                          ),
                          Text('Total Charges'),
                        ],
                      )
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SalesData {
  _SalesData(this.year, this.sales);
  final String year;
  final double sales;
}
