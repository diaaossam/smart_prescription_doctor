import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:smart_prescription/models/user_model.dart';
import 'package:smart_prescription/screens/login_packages/complete_profile/components/custom_toggle_doctor.dart';
import 'package:smart_prescription/screens/login_packages/complete_profile/components/doctor_specialization.dart';
import 'package:smart_prescription/screens/main_doctor/main_layout_screen.dart';
import 'package:smart_prescription/screens/main_patient/main_patient_layout.dart';
import 'package:smart_prescription/shared/helper/mangers/constants.dart';
import 'package:smart_prescription/shared/helper/methods.dart';
import 'package:tbib_toast/tbib_toast.dart';
import '../../../../shared/helper/mangers/size_config.dart';
import '../../../../components/custom_button.dart';
import '../../../../components/custom_text_form_field.dart';
import '../cubit/complete_profile_cubit.dart';
import '../cubit/complete_profile_state.dart';

class CompleteProfileForm extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();

  var userName = TextEditingController();
  var natioalId = TextEditingController();
  var neqabaCardId = TextEditingController();
  var address = TextEditingController();
  var dateOfBirth = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CompleteProfileCubit, CompleteProfileState>(
      listener: (context, state) {
        if (state is SucessUploadDoctorInfoCompleteProfile) {
          navigateToAndFinish(context, MainDoctor());
        }
        if (state is SucessUploadUserInfoCompleteProfile) {
          navigateToAndFinish(context, MainPatientLayout());
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
                  validate: (value) {
                    if (value!.isEmpty) {
                      return "Please Enter Your name";
                    }
                  },
                  isPassword: false,
                ),
                SizedBox(height: getProportionateScreenHeight(20)),
                CustomTextFormField(
                  controller: natioalId,
                  lableText: "National Id",
                  hintText: "Enter your National Id",
                  type: TextInputType.streetAddress,
                  suffixIcon: "assets/icons/User.svg",
                  validate: (value) {
                    if (value!.isEmpty) {
                      return "Enter Your National Id";
                    }
                  },
                  isPassword: false,
                ),
                SizedBox(height: getProportionateScreenHeight(20)),
                CustomTextFormField(
                  controller: address,
                  lableText: "Address",
                  hintText: "Enter your address",
                  type: TextInputType.streetAddress,
                  suffixIcon: "assets/icons/Location point.svg",
                  validate: (value) {
                    if (value!.isEmpty) {
                      return "Enter Your Address";
                    }
                  },
                  isPassword: false,
                ),
                SizedBox(height: getProportionateScreenHeight(20)),
                CustomTextFormField(
                  controller: dateOfBirth,
                  lableText: "Birth Date",
                  hintText: "Enter your birth date",
                  type: TextInputType.datetime,
                  suffixIcon: "assets/icons/User.svg",
                  onTap: () {
                    showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(1930, 12, 31),
                      lastDate: DateTime.now(),
                    ).then((value) =>
                        dateOfBirth.text = DateFormat.yMMMd().format(value!));
                  },
                ),
                SizedBox(height: getProportionateScreenHeight(20)),
                CustomToggleButtonDesign(cubit),
                SizedBox(height: getProportionateScreenHeight(20)),
                cubit.isDoctorList[0] ? DoctorSpecialization() : Container(),
                SizedBox(height: getProportionateScreenHeight(20)),
                cubit.isDoctorList[0]
                    ? CustomTextFormField(
                        controller: neqabaCardId,
                        lableText: "Id",
                        hintText: "Enter your Id",
                        type: TextInputType.datetime,
                        suffixIcon: "assets/icons/User.svg",
                      )
                    : Container(),
                SizedBox(height: getProportionateScreenHeight(20)),
                CustomButton(
                    text: 'Continue',
                    press: () {
                      if (_formKey.currentState!.validate()) {
                        if (natioalId.text.length == 14) {
                          cubit.setUserInfo(
                              userModel: UserModel(
                                  uid: FirebaseAuth.instance.currentUser!.uid,
                                  birthDate: dateOfBirth.text,
                                  userName: userName.text,
                                  phone: FirebaseAuth
                                      .instance.currentUser!.phoneNumber,
                                  address: address.text,
                                  image: ConstantsManger.DEFAULT,
                                  isDoctor: cubit.isDoctorList[0],
                                  doctorId: cubit.isDoctorList[0]
                                      ? neqabaCardId.text
                                      : ConstantsManger.DEFAULT,
                                  doctorSpecialization: cubit.isDoctorList[0]
                                      ? cubit.doctorTitle
                                      : ConstantsManger.DEFAULT));
                        }else{
                          Toast.show('Neqaba Id Should Be 14 number', context);
                        }
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
