import 'package:flutter/material.dart';

class QuickLinkButton extends StatelessWidget {
  String buttonTitle;
  dynamic quickLinkIcon;
  Color iconColor;
  QuickLinkButton({
    Key? key,
    required this.buttonTitle,
    required this.quickLinkIcon,
    required this.iconColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final mediaHeight = MediaQuery.of(context).size.height;
    final mediaWidth = MediaQuery.of(context).size.width;

    return Column(
      children: [
        Container(
          padding: EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: iconColor,
            borderRadius: BorderRadius.circular(40),
          ),
          child: Icon(
            quickLinkIcon,
            color: Colors.white,
          ),
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.01,
        ),
        Text(
          buttonTitle,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Color(0xff000000),
            fontWeight: FontWeight.w700,
            fontSize: mediaHeight * 0.018,
          ),
        )
      ],
    );
  }
}
