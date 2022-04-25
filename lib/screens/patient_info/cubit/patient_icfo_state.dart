part of 'patient_icfo_cubit.dart';

@immutable
abstract class PatientIcfoState {}

class PatientIcfoInitial extends PatientIcfoState {}
class GetPatientInfoLoading extends PatientIcfoState {}
class GetPatientInfoSuccess extends PatientIcfoState {}
