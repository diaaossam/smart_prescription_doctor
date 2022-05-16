import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:smart_prescription/screens/login_packages/phone_screen/components/phone_content.dart';
import 'package:smart_prescription/shared/helper/mangers/assets_manger.dart';
import '../../../../shared/helper/mangers/size_config.dart';
import '../../../../components/custom_button.dart';
import '../../../../models/phone_model.dart';
import '../../../../shared/helper/methods.dart';
import '../../otp_screen/otp_screen.dart';
import '../cubit/phone_cubit.dart';
import '../cubit/phone_state.dart';

class PhoneBody extends StatelessWidget {
  var phoneNumber = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PhoneCubit, PhoneState>(
      listener: (context, state) {
        if (state is Loading) {
          showCustomProgressIndicator(context);
        }
        if (state is PhoneNumberSubmited) {
          Navigator.pop(context);
          navigateTo(
              context,
              OtpScreen(
                  number: phoneNumber.text,));
        }
        if (state is ErrorOccurred) {
          Navigator.pop(context);

          String errorMsg = (state).errorMsg;
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(errorMsg),
              backgroundColor: Colors.black,
              duration: Duration(seconds: 5),
            ),
          );
        }
      },
      builder: (context, state) {
        PhoneCubit cubit = PhoneCubit.get(context);
        PhoneModel model = PhoneModel(
            image: AssetsManger.PhoneScreen1,
            widget: IntlPhoneField(
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp('[0-9]')),
                FilteringTextInputFormatter.deny(RegExp(r'^0+')),
              ],
              decoration: const InputDecoration(
                labelText: 'Phone Number',
                border: OutlineInputBorder(
                  borderSide: BorderSide(),
                ),
              ),
              initialCountryCode: 'EG',
              keyboardType: TextInputType.phone,
              onChanged: (value) {
                phoneNumber.text = value.completeNumber;
              },
            ),
            text: 'Please enter your Phone Number .. !');
        return Padding(
          padding: EdgeInsets.all(getProportionateScreenHeight(18.0)),
          child: Column(
            children: [
              Expanded(
                child: PhoneContent(
                  phoneModel: model,
                ),
              ),
              CustomButton(
                text: 'Send Pin Code ',
                press: () {
                  cubit.submitPhoneNumber(phoneNumber.text);
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
