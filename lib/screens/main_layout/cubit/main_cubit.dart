import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import '../../../models/user_model.dart';
import '../../../shared/helper/mangers/constants.dart';

part 'main_state.dart';

class MainCubit extends Cubit<MainState> {
  MainCubit() : super(MainInitial());

  static MainCubit get(BuildContext context) => BlocProvider.of(context);

  void setUpToken(String uid) {
    FirebaseMessaging.instance.getToken().then((token) {
      FirebaseFirestore.instance
          .collection(ConstantsManger.USERS)
          .doc(uid)
          .update({'token': '${token}'});
    });
  }

  UserModel ? userModel;

  void getCurrentUser() {
    emit(GetUserInfoLoading());
    FirebaseFirestore.instance.collection(ConstantsManger.USERS).doc(
        FirebaseAuth.instance.currentUser!.uid).get().then((value) {
       userModel = UserModel.fromJson(value.data()??{});
       emit(GetUserInfoSuccess());
    });
  }

  void searchUserInfo(String id)async {
    emit(GetPatientInfoFromQrLoading());
    await FirebaseFirestore.instance.collection(ConstantsManger.USERS).doc(id).get().then((value){
      UserModel patientUserModel = UserModel.fromJson(value.data()??{});
      emit(GetPatientInfoFromQrSuccess(patientUserModel));
    });
  }

}
