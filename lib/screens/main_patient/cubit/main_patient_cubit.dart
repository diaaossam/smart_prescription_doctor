import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:smart_prescription/screens/chat_screen/chat_screen.dart';
import 'package:smart_prescription/screens/profile_screen/profile.dart';

import '../../patient_history/patient_history.dart';

part 'main_patient_state.dart';

class MainPatientCubit extends Cubit<MainPatientState> {
  MainPatientCubit() : super(MainPatientInitial());

  static MainPatientCubit get(context)=>BlocProvider.of(context);

  int currentIndex = 0;
  void changeBottomIndex(int index){
    this.currentIndex= index;
    emit(ChangeBottomNavBar());
  }
  List<Widget> screens= [
    PatientHistory(),
    ChatScreenLayout(),
    Profile(),
  ];
  List<String> title=[
    'History',
    'Chat',
    'Profile'
  ];
}
