part of 'home_cubit.dart';

sealed class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object> get props => [];
}

final class HomeInitial extends HomeState {}

final class GetCitiesLoading extends HomeState {}

final class GetCitiesSuccess extends HomeState {
  final List<CityModel> cities;

  const GetCitiesSuccess({required this.cities});
}

final class GetCitiesError extends HomeState {
  final String errorMessage;

  const GetCitiesError({required this.errorMessage});
}
