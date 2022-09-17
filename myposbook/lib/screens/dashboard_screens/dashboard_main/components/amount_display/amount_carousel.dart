import 'package:flutter/material.dart';
import 'package:myposbook/constants.dart';
import 'package:myposbook/screens/dashboard_screens/dashboard_main/components/amount_display/amount_display_section.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class AmountCarousel extends StatelessWidget {
  dynamic cashoutAmount;
  dynamic depositAmount;
  String cashoutCharges;
  String depositCharges;
  String totalCharges;
  String totalDisbursedToday;
  AmountCarousel({
    Key? key,
    required this.cashoutAmount,
    required this.depositAmount,
    required this.cashoutCharges,
    required this.depositCharges,
    required this.totalCharges,
    required this.totalDisbursedToday,
  }) : super(key: key);

  final _controller = PageController();
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.28,
          child: PageView(
            // scrollDirection: scrolldirec,
            controller: _controller,
            children: [
              AmountDisplaySection(
                recordTitle: 'Cashout',
                recordAmount: cashoutAmount,
                recordTotalCharge: cashoutCharges,
                leftSideColor: Color(0xff27142A),
                rightSideColor: Color(0xff225560),
              ),
              AmountDisplaySection(
                recordTitle: 'Deposit',
                recordAmount: depositAmount,
                recordTotalCharge: depositCharges,
                leftSideColor: Color(0xff386fa4),
                rightSideColor: Colors.black,
              ),
              AmountDisplaySection(
                recordTitle: 'Total Disbursed',
                recordAmount: totalDisbursedToday,
                recordTotalCharge: totalCharges,
                leftSideColor: Color(0xffE3655B),
                rightSideColor: Color(0xff2F3061),
              ),
            ],
          ),
        ),
        SmoothPageIndicator(
          controller: _controller,
          count: 3,
          axisDirection: Axis.horizontal,
          effect: ExpandingDotsEffect(activeDotColor: brandColor),
        ),
      ],
    );
  }
}
