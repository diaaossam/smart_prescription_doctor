import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:smart_prescription/components/app_text.dart';
import 'package:smart_prescription/components/custom_button.dart';
import 'package:smart_prescription/models/user_model.dart';
import 'package:smart_prescription/shared/helper/mangers/size_config.dart';
import 'package:smart_prescription/shared/helper/methods.dart';
import 'package:tbib_toast/tbib_toast.dart';
import '../../shared/helper/mangers/colors.dart';
import '../../shared/helper/mangers/constants.dart';
import '../add_xamination/add_xamination.dart';
import 'cubit/profile_cubit.dart';

class Profile extends StatelessWidget {
  var ssn = TextEditingController();
  var username = TextEditingController();
  var phone = TextEditingController();
  var address = TextEditingController();
  var birthDate = TextEditingController();
  var pin = TextEditingController();
  var doctorSpecialization = TextEditingController();
  var doctorId = TextEditingController();



  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProfileCubit()..getCurrentUserProfileInfo(),
      child: BlocConsumer<ProfileCubit, ProfileState>(
        listener: (context, state) {
          if (state is ErrorOccurred) {
            Toast.show(state.errorMsg, context,
                gravity: Toast.bottom, duration: 2);
          }
        },
        builder: (context, state) {
          ProfileCubit cubit = ProfileCubit.get(context);
          return Scaffold(
            appBar: AppBar(
              elevation: 1,
              centerTitle: true,
              leading: BackButton(),
              title: AppText(text: ' My Account'),
            ),
            body: state is LoadingUserInfoState
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Container(
                      child: GestureDetector(
                        onTap: () {
                          FocusScope.of(context).unfocus();
                        },
                        child: ListView(
                          children: [
                            Center(
                                    child: Stack(
                                      alignment: AlignmentDirectional.bottomEnd,
                                      children: [
                                        Stack(
                                          alignment: Alignment.center,
                                          children: [
                                            CircleAvatar(
                                              radius: 72,
                                              backgroundColor:
                                                  ColorsManger.primaryColor,
                                            ),
                                            CircleAvatar(
                                              radius: 70,
                                              backgroundColor: Colors.white,
                                              backgroundImage: setImage(cubit),
                                            ),
                                          ],
                                        ),
                                        CircleAvatar(
                                          backgroundColor:
                                              ColorsManger.primaryColor,
                                          radius: 25,
                                          child: IconButton(
                                              onPressed: () {
                                                cubit.getProfileImage();
                                              },
                                              icon: Icon(Icons.camera_alt)),
                                        )
                                      ],
                                    ),
                                  ),
                            SizedBox(
                              height: getProportionateScreenHeight(15),
                            ),
                            Row(
                              children: [
                                Container(
                                  height: getProportionateScreenHeight(200),
                                  width: getProportionateScreenHeight(200),
                                  child: QrImage(
                                    data: "${cubit.userModel!.uid}",
                                  ),
                                ),
                                Spacer(),
                                Container(
                                    height: getProportionateScreenHeight(50.0),
                                    width: getProportionateScreenHeight(150),
                                    child: CustomButton(
                                      press: () {},
                                      text: 'History',
                                    ))
                              ],
                            ),
                            SizedBox(
                              height: getProportionateScreenHeight(30),
                            ),
                            TextFormField(
                              controller: username
                                ..text = cubit.userModel!.userName ?? '',
                              keyboardType: TextInputType.text,
                              decoration: const InputDecoration(
                                hintText: "+User name",
                                prefixIcon: Icon(
                                  Icons.phone,
                                ),
                              ),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Enter Your name';
                                }
                              },
                            ),
                            SizedBox(
                              height: getProportionateScreenHeight(15.0),
                            ),
                            TextFormField(
                              controller: phone
                                ..text = cubit.userModel!.phone ?? '',
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                hintText: "+020",
                                prefixIcon: const Icon(
                                  Icons.phone,
                                ),
                                suffixIcon: TextButton(
                                  onPressed: () {
                                    /*    if (phone.text !=
                                        '${cubit.userModel!.phone}') {
                                      cubit.changePhoneNumber(
                                          newPhone: phone.text);
                                    }*/
                                  },
                                  child: const Text(
                                    "Change",
                                    style: TextStyle(
                                        color: Color(0xff0D47A1), fontSize: 16),
                                  ),
                                ),
                              ),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return '';
                                }
                                return null;
                              },
                            ),
                            SizedBox(
                              height: getProportionateScreenHeight(15.0),
                            ),
                            TextFormField(
                              controller: birthDate
                                ..text = "${cubit.userModel!.birthDate}",
                              keyboardType: TextInputType.datetime,
                              decoration: const InputDecoration(
                                hintText: "BirthDate",
                                prefixIcon: Icon(
                                  Icons.calendar_today_outlined,
                                ),
                              ),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Enter Your Birthdate';
                                }
                              },
                              onTap: () {
                                showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime(2021, 12, 31),
                                  lastDate: DateTime.now(),
                                ).then((value) => birthDate.text =
                                    DateFormat.yMMMd().format(value!));
                              },
                            ),
                            /* CustomTextFormField(
                              controller: ,
                              lableText: "Birth Date",
                              hintText: "Enter your birth date",
                              type: TextInputType.datetime,
                              onTap: () {
                                showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime(2021, 12, 31),
                                  lastDate: DateTime.now(),
                                ).then((value) =>
                                birthDate.text = DateFormat.yMMMd().format(value!));
                              },
                            ),*/
                            SizedBox(
                              height: getProportionateScreenHeight(15.0),
                            ),
                            TextFormField(
                              controller: address
                                ..text = cubit.userModel!.address ?? '',
                              keyboardType: TextInputType.streetAddress,
                              decoration: const InputDecoration(
                                hintText: "Address",
                                prefixIcon: Icon(
                                  Icons.location_city,
                                ),
                              ),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Enter Your address';
                                }
                              },
                            ),
                            SizedBox(
                              height: getProportionateScreenHeight(40.0),
                            ),
                            CustomButton(
                              text: 'Save Changes',
                              press: () {
                                navigateTo(
                                    context,
                                    AddExaminationScreen(
                                      userModel: cubit.userModel!,
                                    ));
                              },
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
          );
        },
      ),
    );
  }

  ImageProvider setImage(ProfileCubit cubit) {
    if ("${cubit.userModel!.image}" == ConstantsManger.DEFAULT) {
      return AssetImage('assets/images/user.png');
    } else {
      if (cubit.profileImage != null) {
        return FileImage(cubit.profileImage ?? File(''));
      } else {
        return NetworkImage(cubit.userModel!.image ?? '');
      }
    }
  }
}
