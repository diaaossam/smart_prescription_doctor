import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:smart_prescription/screens/main_layout/main_layout_screen.dart';
import 'package:smart_prescription/shared/helper/mangers/constants.dart';
import '../../../shared/helper/mangers/size_config.dart';
import '../../../../models/user_model.dart';
import '../../../shared/helper/methods.dart';
import '../../../components/custom_button.dart';
import '../../../components/custom_text_form_field.dart';
import '../../../components/form_error.dart';
import '../cubit/complete_profile_cubit.dart';
import '../cubit/complete_profile_state.dart';

class CompleteProfileForm extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();

  var userName = TextEditingController();
  var lastName = TextEditingController();
  var phoneNumber = TextEditingController();
  var address = TextEditingController();
  var dateOfBirth = TextEditingController();

  void addError({required CompleteProfileCubit cubit, String? error}) {
    if (!cubit.errors.contains(error)) cubit.setErrors(error!);
  }

  void removeError({required CompleteProfileCubit cubit, String? error}) {
    if (cubit.errors.contains(error)) cubit.removeErrors(error!);
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CompleteProfileCubit, CompleteProfileState>(
      listener: (context, state) {
        if (state is LoadingUploadUserInfoCompleteProfile) {
          showCustomProgressIndicator(context);
        } else if (state is ErrorUploadUserInfoCompleteProfile) {
          Navigator.pop(context);
          showSnackBar(context, state.errorMsg);
        } else if (state is SucessUploadUserInfoCompleteProfile) {
          navigateToAndFinish(context, MainLayout());
        }
      },
      builder: (context, state) {
        CompleteProfileCubit cubit = CompleteProfileCubit.get(context);
        return SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                CustomTextFormField(
                  controller: userName,
                  lableText: "User Name",
                  hintText: "Enter your User Name",
                  type: TextInputType.text,
                  suffixIcon: "assets/icons/User.svg",
                  onChange: (value) {
                    if (value.isNotEmpty) {
                      removeError(
                          cubit: cubit, error: ConstantsManger.kNamelNullError);
                    }
                    return null;
                  },
                  validate: (value) {
                    if (value!.isEmpty) {
                      addError(
                          cubit: cubit, error: ConstantsManger.kNamelNullError);
                      return "";
                    }
                    return null;
                  },
                  isPassword: false,
                ),
                SizedBox(height: getProportionateScreenHeight(30)),
                CustomTextFormField(
                  controller: phoneNumber,
                  lableText: "Phone Number",
                  hintText: "Enter your phone number",
                  type: TextInputType.phone,
                  suffixIcon: "assets/icons/Phone.svg",
                  onChange: (value) {
                    if (value.isNotEmpty) {
                      removeError(
                          cubit: cubit,
                          error: ConstantsManger.kPhoneNumberNullError);
                    }
                    return null;
                  },
                  validate: (value) {
                    if (value!.isEmpty) {
                      addError(
                          cubit: cubit,
                          error: ConstantsManger.kPhoneNumberNullError);
                      return "";
                    }
                    return null;
                  },
                  isPassword: false,
                ),
                SizedBox(height: getProportionateScreenHeight(30)),

                FormError(errors: cubit.errors),
                SizedBox(height: getProportionateScreenHeight(40)),
                CustomButton(
                    text: 'Continue',
                    press: () {
                      if (_formKey.currentState!.validate()) {
                        cubit.setUserInfo(
                            userModel: UserModel(
                          uid: cubit.getLoggedInUser().uid,
                          image: ConstantsManger.DEFAULT,
                          firstName: firstName.text,
                          lastName: lastName.text,
                          phone: phoneNumber.text,
                          address: address.text,
                          birthDate: '${dateOfBirth.text}',
                          isAdmin: false,
                              token: '',
                        ));
                      }
                    })
              ],
            ),
          ),
        );
      },
    );
  }
}
