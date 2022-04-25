import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:smart_prescription/models/user_model.dart';
import 'package:smart_prescription/shared/helper/mangers/constants.dart';

part 'patient_icfo_state.dart';

class PatientInfoCubit extends Cubit<PatientIcfoState> {
  PatientInfoCubit() : super(PatientIcfoInitial());

  static PatientInfoCubit get(BuildContext context) => BlocProvider.of(context);

  UserModel  ? patientUserModel;
  void getPatientInfo({required String id}) {
    emit(GetPatientInfoLoading());
    FirebaseFirestore.instance.collection(ConstantsManger.USERS).doc(id)
        .get()
        .then((value) {
      patientUserModel = UserModel.fromJson(value.data()??{});
      emit(GetPatientInfoSuccess());
    });
  }
}
