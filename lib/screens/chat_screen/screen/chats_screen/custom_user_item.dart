import 'package:flutter/material.dart';
import 'package:smart_prescription/shared/helper/mangers/assets_manger.dart';
import 'package:smart_prescription/shared/helper/mangers/colors.dart';
import 'package:smart_prescription/shared/helper/mangers/constants.dart';

import '../../../../components/app_text.dart';
import '../../../../models/user_model.dart';
import '../../../../shared/helper/mangers/size_config.dart';
import '../../../../shared/helper/methods.dart';
import '../../../messages_screen/message_screen.dart';

class CustomUserItem extends StatelessWidget {
  UserModel userModel;

  CustomUserItem({required this.userModel});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        navigateToWithAnimation(context, MessageScreen(userModel));
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                CircleAvatar(
                  backgroundColor: ColorsManger.primaryColorLight,
                  radius: getProportionateScreenHeight(37.0),
                ),
                CircleAvatar(
                  child: Image(
                    height: getProportionateScreenHeight(50),
                    width: getProportionateScreenHeight(50),
                    image: userModel.image != ConstantsManger.DEFAULT
                      ? NetworkImage('${userModel.image}'):AssetImage('assets/images/user.png') as ImageProvider,
                  ),
                  backgroundColor: Colors.white,
                  radius: getProportionateScreenHeight(35.0),
                ),
              ],
            ),
            SizedBox(
              width: getProportionateScreenHeight(10.0),
            ),
            AppText(
              text: '${userModel.userName}',
              textSize: 22.0,
            ),
          ],
        ),
      ),
    );
  }
}
