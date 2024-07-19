import 'package:flutter/material.dart';

import '../number_pad/number_pad.dart';

class OtpNumberBox extends StatefulWidget {
  const OtpNumberBox({super.key});

  @override
  State<OtpNumberBox> createState() => _OtpNumberBoxState();
}

class _OtpNumberBoxState extends State<OtpNumberBox> {
  String code = "";
  int numDigitType = 6;
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Expanded(child: NumberKey2()),
          Expanded(child: NumberKey2()),
          Expanded(child: NumberKey2()),
          Expanded(child: NumberKey2()),
          Expanded(child: NumberKey2()),
          Expanded(child: NumberKey2()),
        ],
      ),
    );
  }
}
