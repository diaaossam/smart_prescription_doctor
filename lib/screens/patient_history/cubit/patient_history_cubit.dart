import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:smart_prescription/models/user_model.dart';
import 'package:smart_prescription/shared/helper/mangers/constants.dart';

import '../../../models/pateint_history_model.dart';

part 'patient_history_state.dart';

class PatientHistoryCubit extends Cubit<PatientHistoryState> {
  PatientHistoryCubit() : super(PatientHistoryInitial());

  static PatientHistoryCubit get(context) => BlocProvider.of(context);

  List<PatientHistoryModel> patientHistoryList = [];

  void getPatientHistory({String? patientId}) {
    if (patientId != null) {
      FirebaseFirestore.instance
          .collection(ConstantsManger.PATIENTS)
          .where('patientId', isEqualTo: patientId)
          .snapshots()
          .listen((event) {
        patientHistoryList.clear();
        event.docs.forEach((element) {
          patientHistoryList.add(PatientHistoryModel.fromJson(element.data()));
        });
        emit(GetAllPatientHistory());
      });
    } else {
      FirebaseFirestore.instance
          .collection(ConstantsManger.PATIENTS)
          .where('patientId', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
          .snapshots()
          .listen((event) {
        patientHistoryList.clear();
        event.docs.forEach((element) {
          patientHistoryList.add(PatientHistoryModel.fromJson(element.data()));
        });
        emit(GetAllPatientHistory());
      });
    }
  }

  void deleteModel({required String id}){
    FirebaseFirestore.instance.collection(ConstantsManger.PATIENTS).doc(id).delete();
  }
  void updateUserData({required Map<String, dynamic> map, required String id}) {
    FirebaseFirestore.instance
        .collection(ConstantsManger.PATIENTS)
        .doc(id)
        .update(map)
        .then((value) {
      emit(UpdateSuccess());
    });
  }
}

