import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../models/user_model.dart';
import '../../../shared/helper/mangers/constants.dart';
import 'complete_profile_state.dart';

class CompleteProfileCubit extends Cubit<CompleteProfileState> {
  CompleteProfileCubit() : super(CompleteProfileInitial());

  static CompleteProfileCubit get(context) => BlocProvider.of(context);

  void setUserInfo({required UserModel userModel}) async {
    CollectionReference reference =
        FirebaseFirestore.instance.collection(ConstantsManger.USERS);

    await reference
        .doc(_getLoggedInUser().uid)
        .set(userModel.toMap())
        .then((value) {
      FirebaseMessaging.instance.getToken().then((value) {
        reference.doc(_getLoggedInUser().uid).update({'token': value});
      });

      emit(SucessUploadUserInfoCompleteProfile());
    });
  }

  List<bool> isDoctorList = [true, false];

  void changeToggleState(int index) {
    if (index == 0) {
      isDoctorList[0] = true; //Doctor
      isDoctorList[1] = false;
    } else {
      isDoctorList[0] = false; //User
      isDoctorList[1] = true;
    }
    emit(ChangeToggleState());
  }

  User _getLoggedInUser() {
    User firebaseUser = FirebaseAuth.instance.currentUser!;
    return firebaseUser;
  }

  String? doctorTitle;
  List<String> doctorTitleList = [
    ConstantsManger.Batna,
    ConstantsManger.Mokh,
    ConstantsManger.Nesa,
    ConstantsManger.Geldya,
    ConstantsManger.ezam,
  ];

  void chooseDoctorType({required String doctor}) {
    this.doctorTitle = doctor;
    emit(ChooseDoctorDescState());
  }
}
