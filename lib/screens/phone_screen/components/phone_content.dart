import 'package:flutter/material.dart';
import 'package:smart_prescription/components/app_text.dart';
import '../../../../models/phone_model.dart';
import '../../../shared/helper/mangers/size_config.dart';
import '../../../shared/helper/mangers/colors.dart';


class PhoneContent extends StatelessWidget {

  final PhoneModel phoneModel;

  PhoneContent({required this.phoneModel});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsDirectional.only(
        start: getProportionateScreenHeight(20.0),
        bottom: getProportionateScreenHeight(20.0),
        end: getProportionateScreenHeight(20.0)
      ),
      child: Container(
        width: double.infinity,
        child: Column(
          children: <Widget>[
            Image.asset(
              '${phoneModel.image}',
              height: getProportionateScreenHeight(250),
              width: getProportionateScreenWidth(300),
            ),
            SizedBox(height: SizeConfigManger.bodyHeight * 0.02),
            Padding(
              padding:  EdgeInsetsDirectional.only(start: getProportionateScreenHeight(25)),
              child:AppText(
                text: "${phoneModel.text}",
                textSize: getProportionateScreenHeight(22.0),
                color: Colors.black38,
              ),
            ),
            SizedBox(height: SizeConfigManger.bodyHeight * 0.08),
            Expanded(
              child: phoneModel.widget,
            ),
          ],
        ),
      ),
    );
  }
}
