import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_prescription/screens/main_doctor/cubit/main_cubit.dart';
import 'package:tbib_toast/tbib_toast.dart';

import '../../../../components/app_text.dart';
import '../../../../shared/helper/mangers/colors.dart';
import '../../../../shared/helper/methods.dart';
import '../../../profile_screen/profile.dart';

class DoctorHomeScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MainDoctorCubit, MainDoctorState>(
      listener: (context, state) {
        if (state is GetPatientInfoFromQrLoading) {
            showCustomProgressIndicator(context);
          }

          if (state is GetPatientInfoFromQrSuccess) {
            Navigator.pop(context);
            navigateTo(
                context,
                Profile(
                  patientInfo: state.userModel,
                ));
          }
        else if (state is GetPatientInfoFromQrFalied) {
            Navigator.pop(context);
            Toast.show('No Patient', context, duration: 2);
          }
      },
      builder: (context, state) {
        MainDoctorCubit cubit = MainDoctorCubit.get(context);
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: InkWell(
                onTap: () {
                  scanQrCode(cubit);
                },
                child: Container(
                  height: 200,
                  width: 200,
                  decoration: BoxDecoration(
                      color: ColorsManger.primaryColorLight,
                      borderRadius: BorderRadius.circular(20),
                      image: DecorationImage(
                        image: AssetImage('assets/images/scanme.png'),
                      )),
                ),
              ),
            ),
            SizedBox(height: 20.0),
            AppText(
                text: 'Scan Patient QR CODE ',
                textSize: 25.0,
                color: ColorsManger.primaryColor),
          ],
        );
      },
    );
  }

  Future<void> scanQrCode(MainDoctorCubit cubit) async {
    FlutterBarcodeScanner.scanBarcode("#ff6666", 'cancel', true, ScanMode.QR)
        .then((value) {
      if (value != null) {
        cubit.searchUserInfo(value);
      }
    });
  }
}
