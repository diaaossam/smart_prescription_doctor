import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:smart_prescription/screens/main_layout/screens/profile/profile_screen.dart';
import 'package:smart_prescription/shared/helper/icon_broken.dart';

import '../../../shared/helper/mangers/constants.dart';

part 'main_state.dart';

class MainCubit extends Cubit<MainState> {
  MainCubit() : super(MainInitial());

  static MainCubit get(BuildContext context)=>BlocProvider.of(context);

  List<BottomNavigationBarItem> bottomListItem = [
    BottomNavigationBarItem(icon: Icon(IconBroken.Home),label: 'Home'),
    BottomNavigationBarItem(icon: Icon(IconBroken.Chat),label: 'Chat'),
    BottomNavigationBarItem(icon: Icon(IconBroken.Calendar),label: 'Calendar'),
    BottomNavigationBarItem(icon: Icon(IconBroken.Notification),label: 'Notification'),
    BottomNavigationBarItem(icon: Icon(IconBroken.User),label: 'Profile'),
  ];
  List<Widget> screensList = [
    HomeScreen(),
    ChatScreen(),
    NotificationScreen(),
    ReminderScreen(),
    ProfileScreen(),
  ];

  int currentIndex = 0;
  void changeBottomNav(int index){
    this.currentIndex = index;
    emit(ChangeBottomNavItemState());
  }


 void setUpToken(String uid) {
    FirebaseMessaging.instance.getToken().then((token) {
      FirebaseFirestore.instance
          .collection(ConstantsManger.USERS)
          .doc(uid)
          .update({'token':'${token}'});
    });
  }
}
