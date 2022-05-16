import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:smart_prescription/screens/main_doctor/screens/doctor_home/doctor_home_screen.dart';
import '../../../models/user_model.dart';
import '../../../shared/helper/mangers/constants.dart';
import '../../chat_screen/chat_screen.dart';
import '../../profile_screen/profile.dart';

part 'main_state.dart';

class MainDoctorCubit extends Cubit<MainDoctorState> {
  MainDoctorCubit() : super(MainInitial());

  static MainDoctorCubit get(BuildContext context) => BlocProvider.of(context);

  void setUpToken(String uid) {
    FirebaseMessaging.instance.getToken().then((token) {
      FirebaseFirestore.instance
          .collection(ConstantsManger.USERS)
          .doc(uid)
          .update({'token': '${token}'});
    });
  }

  UserModel? userModel;

  void getCurrentUser() {
    emit(GetUserInfoLoading());
    FirebaseFirestore.instance
        .collection(ConstantsManger.USERS)
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get()
        .then((value) {
      userModel = UserModel.fromJson(value.data() ?? {});
      emit(GetUserInfoSuccess());
    });
  }

  void searchUserInfo(String id) async {

    print('${id}');
    emit(GetPatientInfoFromQrLoading());

    if (id != null) {
      await FirebaseFirestore.instance
          .collection(ConstantsManger.USERS)
          .doc(id)
          .get()
          .then((value) {
        if (value.exists) {
          UserModel patientUserModel = UserModel.fromJson(value.data() ?? {});
          emit(GetPatientInfoFromQrSuccess(patientUserModel));
        } else {
          emit(GetPatientInfoFromQrFalied());
        }
      });
    }
  }

  int currentIndex = 0;

  void changeBottomIndex(int index) {
    this.currentIndex = index;
    emit(ChangeBottomNavBar());
  }

  List<Widget> screens = [
    DoctorHomeScreen(),
    ChatScreenLayout(),
    Profile(),
  ];
  List<String> title = ['Home', 'Chat', 'Profile'];
}
