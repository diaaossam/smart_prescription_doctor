import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_prescription/screens/login_packages/on_boarding/on_boarding_screen.dart';
import 'package:smart_prescription/screens/main_doctor/main_layout_screen.dart';
import 'package:smart_prescription/screens/main_patient/main_patient_layout.dart';
import 'package:smart_prescription/shared/helper/mangers/assets_manger.dart';
import 'package:smart_prescription/shared/helper/lang_helper/app_local.dart';
import 'package:smart_prescription/shared/helper/methods.dart';
import 'package:smart_prescription/shared/helper/mangers/colors.dart';
import '../../../components/app_text.dart';
import '../../../shared/helper/mangers/size_config.dart';
import '../complete_profile/complete_profile_screen.dart';
import '../phone_screen/phone_screen.dart';
import 'cubit/splash_cubit.dart';
import 'package:lottie/lottie.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SizeConfigManger().init(context);
    return BlocProvider(
      create: (context) => SplashCubit()..checkUserState(context),
      child: BlocConsumer<SplashCubit, SplashState>(
        listener: (context, state) {
          if (state is SplashLoginState) {
            navigateToAndFinish(context, PhoneVerifactionScreen());
          } else if (state is SplashCompleteProfileState) {
            navigateToAndFinish(context, CompleteProfileScreen());
          } else if (state is SplashMainLayoutPatientState) {
            navigateToAndFinish(context, MainPatientLayout());
          }  else if (state is SplashMainLayouDoctortState) {
            navigateToAndFinish(context, MainDoctor());
          }else if (state is SplashOnBoardingState) {
            navigateToAndFinish(context, OnBoardingScreen());
          }
        },
        builder: (context, state) {
          return Scaffold(
            body: SafeArea(
              child: Column(
                children: [
                  SizedBox(height: SizeConfigManger.bodyHeight * 0.3),
                  SizedBox(height: getProportionateScreenHeight(25.0)),
                  Center(
                    child: Container(
                        width: getProportionateScreenHeight(250.0),
                        height: getProportionateScreenHeight(250.0),
                        child: Lottie.asset(AssetsManger.AppLogo)),
                  ),
                  SizedBox(height: getProportionateScreenHeight(25.0)),

                  Spacer(),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
