import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:smart_prescription/components/custom_card.dart';
import 'package:smart_prescription/shared/helper/mangers/constants.dart';

import '../../components/custom_button.dart';
import '../../shared/helper/mangers/colors.dart';
import '../../shared/helper/mangers/size_config.dart';
import 'cubit/patient_icfo_cubit.dart';

class ProfileInfoScreen extends StatelessWidget {

  String patientId;


  ProfileInfoScreen({required this.patientId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
      PatientInfoCubit()
        ..getPatientInfo(id: patientId),
      child: BlocConsumer<PatientInfoCubit, PatientIcfoState>(
        listener: (context, state) {},
        builder: (context, state) {
          PatientInfoCubit cubit = PatientInfoCubit.get(context);
          return Scaffold(
            body: state is GetPatientInfoLoading ? Center(
              child: CircularProgressIndicator(),) : Padding(
              padding: const EdgeInsets.all(20.0),
              child: Container(
                child: GestureDetector(
                  onTap: () {
                    FocusScope.of(context).unfocus();
                  },
                  child: ListView(
                    children: [
                      SizedBox(
                        height: getProportionateScreenHeight(15.0),
                      ),
                      Center(
                        child: Stack(
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
                              backgroundImage: cubit.patientUserModel!.image !=
                                  ConstantsManger.DEFAULT ? NetworkImage(
                                  "${cubit
                                      .patientUserModel!.image}") : AssetImage(
                                  'assets/images/user.png') as ImageProvider,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: getProportionateScreenHeight(15),
                      ),
                      /* Row(
                        children: [
                          Container(
                            height: getProportionateScreenHeight(200),
                            width: getProportionateScreenHeight(200),
                            child: QrImage(
                              data: "${cubit.patientUserModel!.uid}",
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
                      ),*/
                      CustomCardInfo(title: 'Username', detials: cubit.patientUserModel!.userName??''),
                      SizedBox(
                        height: getProportionateScreenHeight(15.0),
                      ),
                      CustomCardInfo(title: 'Phone Number', detials: cubit.patientUserModel!.phone??''),
                      SizedBox(
                        height: getProportionateScreenHeight(15.0),
                      ),
                      CustomCardInfo(title: 'Address', detials: cubit.patientUserModel!.address??''),
                      SizedBox(
                        height: getProportionateScreenHeight(15.0),
                      ),
                      CustomCardInfo(title: 'birthDate', detials: cubit.patientUserModel!.birthDate??''),
                      SizedBox(
                        height: getProportionateScreenHeight(60),
                      ),
                      Container(
                          height: getProportionateScreenHeight(80.0),
                          width: getProportionateScreenHeight(150),
                          child: CustomButton(
                            press: () {},
                            text: 'History',
                          )),

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
}
