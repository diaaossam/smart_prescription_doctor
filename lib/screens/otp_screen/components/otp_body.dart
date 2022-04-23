import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:smart_prescription/shared/helper/mangers/assets_manger.dart';
import 'package:smart_prescription/shared/helper/mangers/colors.dart';
import '../../../shared/helper/mangers/size_config.dart';
import '../../../components/custom_button.dart';
import '../../../models/phone_model.dart';
import '../../../shared/helper/methods.dart';
import '../../complete_profile/complete_profile_screen.dart';
import '../../main_layout/main_layout_screen.dart';
import '../../phone_screen/components/phone_content.dart';
import '../../phone_screen/cubit/phone_cubit.dart';
import '../../phone_screen/cubit/phone_state.dart';

class OtpBody extends StatelessWidget {
  var pinCode = TextEditingController();
  String number;


  OtpBody({required this.number});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PhoneCubit, PhoneState>(
      listener: (context, state) {
        if (state is Loading) {
          showCustomProgressIndicator(context);
        }

        if (state is PhoneOTPVerifiedCompleteProfile) {
          Navigator.pop(context);
          navigateToAndFinish(context,CompleteProfileScreen());
        }
        if (state is PhoneOTPVerifiedMainLayout) {
          Navigator.pop(context);
          navigateToAndFinish(context, MainLayout());
        }
        if (state is ErrorOccurred) {
          showSnackBar(context, (state).errorMsg);
        }
      },
      builder: (context, state) {
        PhoneModel model1 = PhoneModel(
            image: AssetsManger.PhoneScreen2,
            widget: PinCodeTextField(
              controller: pinCode,
              appContext: context,

              autoFocus: true,
              cursorColor: Colors.black,
              keyboardType: TextInputType.number,
              length: 6,
              obscureText: false,
              
              animationType: AnimationType.scale,
              pinTheme: PinTheme(
                shape: PinCodeFieldShape.box,
                borderRadius: BorderRadius.circular(5),
                fieldHeight: 50,
                fieldWidth: 40,
                borderWidth: 1,
                activeColor: ColorsManger.primaryColor,
                inactiveColor: ColorsManger.primaryColor,
                inactiveFillColor: Colors.white,
                activeFillColor: ColorsManger.primaryColorLight,
                selectedColor: ColorsManger.primaryColor,
                selectedFillColor: Colors.white,
              ),
              animationDuration: Duration(milliseconds: 300),
              backgroundColor: Colors.white,
              enableActiveFill: true,
              onChanged: (String value) {},
            ),
            text: 'Enter your 6 digit code numbers sent to  .. $number !');
        PhoneCubit cubit = PhoneCubit.get(context);
        return Padding(
          padding: EdgeInsets.all(getProportionateScreenHeight(18.0)),
          child: Column(
            children: [
              Expanded(
                child: PhoneContent(
                  phoneModel: model1,
                ),
              ),
              CustomButton(
                text: 'Verfiy PinCode',
                press: () {
                  cubit.submitOTP(pinCode.text);
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
