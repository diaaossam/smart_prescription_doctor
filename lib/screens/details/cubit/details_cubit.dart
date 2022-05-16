import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:smart_prescription/models/pateint_history_model.dart';
import 'package:smart_prescription/shared/helper/mangers/constants.dart';

part 'details_state.dart';

class DetailsCubit extends Cubit<DetailsState> {
  DetailsCubit() : super(DetailsInitial());

  static DetailsCubit get(BuildContext context) => BlocProvider.of(context);

  late PatientHistoryModel historyModel;

  void getDetails({required String examId}) {
    emit(GetDetailsLoading());

    FirebaseFirestore.instance
        .collection(ConstantsManger.PATIENTS)
        .doc(examId)
        .snapshots()
        .listen((event) {
      historyModel = PatientHistoryModel.fromJson(event.data() ?? {});
      emit(GetDetailsSuccess());
    });
  }

}
