import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_prescription/components/app_text.dart';
import 'package:smart_prescription/screens/main_layout/cubit/main_cubit.dart';
import 'package:smart_prescription/screens/profile_screen/profile.dart';
import 'package:smart_prescription/shared/helper/mangers/size_config.dart';
import 'package:smart_prescription/shared/helper/methods.dart';
import 'package:tbib_toast/tbib_toast.dart';

import '../patient_info/patient_info_screen.dart';

class MainLayout extends StatelessWidget {
  const MainLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<MainCubit>(
      create: (context) => MainCubit()..getCurrentUser(),
      child: BlocConsumer<MainCubit, MainState>(
        listener: (context, state) {
          if (state is GetPatientInfoFromQrLoading) {}

          if (state is GetPatientInfoFromQrSuccess) {
            navigateTo(context, ProfileInfoScreen(patientId:state.userModel.uid??'',));
          }
        },
        builder: (context, state) {
          MainCubit cubit = MainCubit.get(context);
          return state is GetUserInfoLoading
              ? Scaffold(
                  body: Center(child: CircularProgressIndicator()),
                )
              : Scaffold(
                  appBar: AppBar(
                    actions: [],
                  ),
                  body: Column(
                    children: [
                      SizedBox(
                        height: SizeConfigManger.bodyHeight * 0.1,
                      ),
                      InkWell(
                        onTap: () {
                          scanQrCode( cubit);
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15.0),
                          child: Row(children: [
                            AppText(text: 'Search User By Qr Code'),
                            Spacer(),
                            Icon(Icons.qr_code),
                          ]),
                        ),
                      ),
                      Center(),
                    ],
                  ),
                );
        },
      ),
    );
  }

  Future<void> scanQrCode( MainCubit cubit) async {
    FlutterBarcodeScanner.scanBarcode("#ff6666", 'cancel', true, ScanMode.QR)
        .then((value) {
      cubit.searchUserInfo(value);
    });
  }
}
