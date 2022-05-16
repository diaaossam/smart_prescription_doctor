import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_prescription/components/app_text.dart';
import 'package:smart_prescription/shared/helper/mangers/constants.dart';
import 'package:smart_prescription/shared/helper/mangers/size_config.dart';
import 'package:smart_prescription/shared/helper/mangers/colors.dart';
import '../../../shared/helper/methods.dart';
import '../../../shared/services/local/cache_helper.dart';
import '../phone_screen/phone_screen.dart';
import 'components/body.dart';
import 'cubit/on_boarding_cubit.dart';
import 'cubit/on_boarding_states.dart';

class OnBoardingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => OnBoardingCubit(),
        child: BlocConsumer<OnBoardingCubit, OnBoardingStates>(
          listener: (context, state) {
            if (state is GoToSignIn) {
              //navigateToAndFinish(context, SignInScreen());
            } else if (state is GoToHome) {
              //navigateToAndFinish(context, MainLayout());
            } else if (state is GoToCompleteProfile) {
              //navigateToAndFinish(context, CompleteProfileScreen());
            }
          },
          builder: (context, state) {
            return Scaffold(
              body: Body(),
              appBar: AppBar(
                actions: [
                  TextButton(
                    onPressed: () {
                      submit(context);
                    },
                    child: Padding(
                      padding: EdgeInsetsDirectional.only(
                          end: getProportionateScreenHeight(20.0)),
                      child:AppText(text: 'Skip',textSize: 20.0),
                    ),
                  ),
                ],
              ),
            );
          },
        ));
  }

  static void submit(BuildContext context) {
    CachedHelper.saveData(key: ConstantsManger.ON_BOARDING, value: true)
        .then((value) {
      if (value) {
        navigateToAndFinish(context, PhoneVerifactionScreen());
      }
    });
  }
}
