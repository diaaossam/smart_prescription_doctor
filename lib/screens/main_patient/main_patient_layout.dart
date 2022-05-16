import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_prescription/screens/main_patient/cubit/main_patient_cubit.dart';
import 'package:smart_prescription/shared/helper/icon_broken.dart';

import '../../components/app_text.dart';
import '../../shared/helper/mangers/colors.dart';

class MainPatientLayout extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MainPatientCubit(),
      child: BlocConsumer<MainPatientCubit, MainPatientState>(
        listener: (context, state) {

        },
        builder: (context, state) {
          MainPatientCubit cubit = MainPatientCubit.get(context);
          return DefaultTabController(
            length: 2,
            child: Scaffold(
              appBar: cubit.currentIndex ==1 ?AppBar(
                centerTitle: true,
                title: AppText(
                  text: 'Chat',
                  textSize: 30.0,
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                ),
                backgroundColor: ColorsManger.primaryColor,
                bottom: TabBar(
                  tabs: [
                    Tab(icon: Icon(IconBroken.Chat, color: Colors.white),),
                    Tab(icon: Icon(IconBroken.User1, color: Colors.white),),
                  ],
                ),
              ):null,
              body:cubit.screens[cubit.currentIndex],
              bottomNavigationBar: BottomNavigationBar(
                items: [
                  BottomNavigationBarItem(icon: Icon(IconBroken.Home), label: 'Home'),
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
            ),
          );
        },
      ),
    );
  }
}
