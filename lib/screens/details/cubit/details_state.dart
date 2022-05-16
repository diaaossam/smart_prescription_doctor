part of 'details_cubit.dart';

@immutable
abstract class DetailsState {}

class DetailsInitial extends DetailsState {}
class GetDetailsLoading extends DetailsState {}
class GetDetailsSuccess extends DetailsState {}
class UpdateSuccess extends DetailsState {}
