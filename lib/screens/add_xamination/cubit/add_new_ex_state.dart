part of 'add_new_ex_cubit.dart';

@immutable
abstract class AddNewExState {}

class AddNewExInitial extends AddNewExState {}
class UploadProductImageSuccessState extends AddNewExState {}
class UploadProductFailerState extends AddNewExState {}
class UploadExamitionInfoSuccess extends AddNewExState {}
class UploadExamitionInfoLoading extends AddNewExState {}
class ChoosePdfFile extends AddNewExState {}
class GetPatientInfoSuccess extends AddNewExState {}
class GetPatientInfoLoading extends AddNewExState {}
