import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smart_prescription/components/app_text.dart';
import 'package:smart_prescription/shared/helper/mangers/colors.dart';

import '../shared/helper/mangers/size_config.dart';

class CustomCardInfo extends StatelessWidget {
  IconData prefix;
  String title;
  String detials;

  CustomCardInfo(
      {required this.prefix, required this.title, required this.detials});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(getProportionateScreenHeight(20.0)),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Icon(
            prefix,
            size: getProportionateScreenHeight(30.0),
            color: Colors.blue,
          ),
          SizedBox(width: getProportionateScreenWidth(25)),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              AppText(
                text: '${title}',
                textSize: getProportionateScreenHeight(18),
              ),
              SizedBox(height: getProportionateScreenHeight(5)),
              AppText(
                text: '${detials}',
                color: Colors.grey[700],
                textSize: getProportionateScreenHeight(25.0),
              )
            ],
          ),
        ],
      ),
    );
  }
}
