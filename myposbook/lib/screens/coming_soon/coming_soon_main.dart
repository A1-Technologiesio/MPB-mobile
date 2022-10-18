import 'package:flutter/material.dart';
import 'package:myposbook/constants.dart';
import 'package:myposbook/screens/coming_soon/components/body.dart';

class ComingSoonMain extends StatelessWidget {
  final header;
  final supportingText;
  final imagePath;
  const ComingSoonMain({
    Key? key,
    required this.header,
    required this.supportingText,
    required this.imagePath,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: brandColor,
        title: Center(
            child: Text(
          header,
        )),
      ),
      body: ComingSoonBody(
        header: header,
        supportingText: supportingText,
        imagePath: imagePath,
      ),
    );
  }
}
