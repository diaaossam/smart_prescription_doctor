part of 'main_cubit.dart';

@immutable
abstract class MainState {}

class MainInitial extends MainState {}
class ChangeBottomNavItemState extends MainState {}
class GetUserInfoSuccess extends MainState {}
class GetUserInfoLoading extends MainState {}
class GetPatientInfoFromQrLoading extends MainState {}
class GetPatientInfoFromQrSuccess extends MainState {
  UserModel userModel;
  GetPatientInfoFromQrSuccess(this.userModel);
}
