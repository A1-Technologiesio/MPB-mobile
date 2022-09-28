import 'package:flutter/material.dart';
import 'package:myposbook/screens/dashboard_screens/dashboard_main/components/records_data/components/graph.dart';
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

  // tooltip
  late TooltipBehavior _tooltipBehavior;

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    final spaceHorizontal = screenWidth * 0.04;
    final spaceVertical = screenHeight * 0.005;

    return SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: screenWidth * 0.035,
        ),
        child: ListView(
          children: [
            // Heading
            SizedBox(
              height: screenHeight * 0.12,
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
                          fontSize: screenHeight * 0.025,
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
                vertical: screenHeight * 0.03,
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
                      vertical: screenHeight * 0.01,
                    ),
                    child: Text(
                      '₦1,200,00.34',
                      style: TextStyle(
                        fontSize: screenHeight * 0.035,
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
                        fontSize: screenHeight * 0.02,
                      ),
                      children: [
                        TextSpan(
                          text: 'vs',
                          style: TextStyle(
                            color: Color(0xff777777),
                            fontWeight: FontWeight.bold,
                            fontSize: screenHeight * 0.02,
                          ),
                        ),
                        TextSpan(
                          text: ' ₦ 1,005,334',
                          style: TextStyle(
                            color: Color(0xff777777),
                            fontWeight: FontWeight.bold,
                            fontSize: screenHeight * 0.02,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // Graph chart
            // GraphChart(),
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

            // divider
            Divider(
              thickness: 2,
            ),

            // Transaction & charges
            Padding(
              padding: EdgeInsets.symmetric(
                vertical: screenHeight * 0.014,
              ),
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: screenHeight * 0.02,
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
                              height: screenHeight * 0.045,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: spaceHorizontal,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '₦ 1,200,000.34',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: screenHeight * 0.0295,
                              ),
                            ),
                            SizedBox(
                              height: spaceVertical,
                            ),
                            Text(
                              'Total Transactions',
                              style: TextStyle(
                                fontWeight: FontWeight.w400,
                              ),
                            ),
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
                            height: screenHeight * 0.045,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: spaceHorizontal,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '₦ 12,000.34',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: screenHeight * 0.0295,
                            ),
                          ),
                          SizedBox(
                            height: spaceVertical,
                          ),
                          Text(
                            'Total Charges',
                            style: TextStyle(
                              fontWeight: FontWeight.w400,
                            ),
                          ),
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
