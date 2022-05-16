import 'package:flutter/material.dart';
import 'package:smart_prescription/screens/login_packages/phone_screen/cubit/phone_cubit.dart';

import '../phone_screen/cubit/phone_state.dart';
import 'components/otp_body.dart';

class OtpScreen extends StatelessWidget {
  String number;

  OtpScreen({required this.number});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: OtpBody(number: number),
    );
  }
}
