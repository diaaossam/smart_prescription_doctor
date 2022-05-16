import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_prescription/components/app_text.dart';
import 'package:smart_prescription/screens/profile_screen/profile.dart';
import 'package:smart_prescription/shared/helper/icon_broken.dart';
import 'package:smart_prescription/shared/helper/mangers/colors.dart';
import 'package:smart_prescription/shared/helper/mangers/size_config.dart';
import 'package:smart_prescription/shared/helper/methods.dart';
import 'package:tbib_toast/tbib_toast.dart';
import 'cubit/main_cubit.dart';

class MainDoctor extends StatelessWidget {
  const MainDoctor({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<MainDoctorCubit>(
      create: (context) => MainDoctorCubit()..getCurrentUser(),
      child: BlocConsumer<MainDoctorCubit, MainDoctorState>(
        listener: (context, state) {

        },
        builder: (context, state) {
          MainDoctorCubit cubit = MainDoctorCubit.get(context);
          return Scaffold(
            body: cubit.screens[cubit.currentIndex],
            bottomNavigationBar: BottomNavigationBar(
              items: [
                BottomNavigationBarItem(
                    icon: Icon(IconBroken.Home), label: 'Home'),
                BottomNavigationBarItem(
                    icon: Icon(IconBroken.Chat), label: 'Chat'),
                BottomNavigationBarItem(
                    icon: Icon(IconBroken.Profile), label: 'Profile'),
              ],
              onTap: (int index) {
                cubit.changeBottomIndex(index);
              },
              currentIndex: cubit.currentIndex,
            ),
          );
        },
      ),
    );
  }
}
