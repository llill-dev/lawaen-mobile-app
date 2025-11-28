part of 'home_cubit.dart';

enum RequestState { idle, loading, success, error }

class HomeState extends Equatable {
  final RequestState citiesState;
  final List<CityModel> cities;
  final String? citiesError;

  final RequestState categoriesState;
  final List<CategoryModel> categories;
  final String? categoriesError;
  final String? globalError;

  const HomeState({
    this.citiesState = RequestState.idle,
    this.cities = const [],
    this.citiesError,

    this.categoriesState = RequestState.idle,
    this.categories = const [],
    this.categoriesError,

    this.globalError,
  });

  HomeState copyWith({
    RequestState? citiesState,
    List<CityModel>? cities,
    String? citiesError,

    RequestState? categoriesState,
    List<CategoryModel>? categories,
    String? categoriesError,

    String? globalError,
  }) {
    return HomeState(
      citiesState: citiesState ?? this.citiesState,
      cities: cities ?? this.cities,
      citiesError: citiesError,

      categoriesState: categoriesState ?? this.categoriesState,
      categories: categories ?? this.categories,
      categoriesError: categoriesError,

      globalError: globalError,
    );
  }

  @override
  List<Object?> get props => [
    citiesState,
    cities,
    citiesError,
    categoriesState,
    categories,
    categoriesError,
    globalError,
  ];
}
