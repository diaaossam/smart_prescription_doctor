part of 'main_cubit.dart';

@immutable
abstract class MainDoctorState {}

class MainInitial extends MainDoctorState {}
class ChangeBottomNavItemState extends MainDoctorState {}
class GetUserInfoSuccess extends MainDoctorState {}
class GetUserInfoLoading extends MainDoctorState {}
class GetPatientInfoFromQrLoading extends MainDoctorState {}
class GetPatientInfoFromQrFalied extends MainDoctorState {}
class ChangeBottomNavBar extends MainDoctorState {}
class GetPatientInfoFromQrSuccess extends MainDoctorState {
  UserModel userModel;
  GetPatientInfoFromQrSuccess(this.userModel);
}
