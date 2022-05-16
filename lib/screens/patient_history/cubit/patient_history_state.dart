part of 'patient_history_cubit.dart';

@immutable
abstract class PatientHistoryState {}

class PatientHistoryInitial extends PatientHistoryState {}
class UpdateSuccess extends PatientHistoryState {}
class GetAllPatientHistory extends PatientHistoryState {}
