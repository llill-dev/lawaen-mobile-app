part of 'home_cubit.dart';

class HomeState extends Equatable {
  // CITIES
  final RequestState citiesState;
  final List<CityModel> cities;
  final String? citiesError;

  // CATEGORIES
  final RequestState categoriesState;
  final List<CategoryModel> categories;
  final String? categoriesError;

  // LOCATION
  final RequestState locationState;
  final String? locationError;
  final String? userAddress;
  final double? userLatitude;
  final double? userLongitude;
  final CityModel? currentCity;

  // GLOBAL
  final String? globalError;

  const HomeState({
    this.citiesState = RequestState.idle,
    this.cities = const [],
    this.citiesError,
    this.categoriesState = RequestState.idle,
    this.categories = const [],
    this.categoriesError,
    this.locationState = RequestState.idle,
    this.locationError,
    this.userAddress,
    this.userLatitude,
    this.userLongitude,
    this.currentCity,
    this.globalError,
  });

  HomeState copyWith({
    // cities
    RequestState? citiesState,
    List<CityModel>? cities,
    String? citiesError,

    // categories
    RequestState? categoriesState,
    List<CategoryModel>? categories,
    String? categoriesError,

    // location
    RequestState? locationState,
    String? locationError,
    String? userAddress,
    double? userLatitude,
    double? userLongitude,
    CityModel? currentCity,

    // global
    String? globalError,
  }) {
    return HomeState(
      citiesState: citiesState ?? this.citiesState,
      cities: cities ?? this.cities,
      citiesError: citiesError,
      categoriesState: categoriesState ?? this.categoriesState,
      categories: categories ?? this.categories,
      categoriesError: categoriesError,
      locationState: locationState ?? this.locationState,
      locationError: locationError,
      userAddress: userAddress ?? this.userAddress,
      userLatitude: userLatitude ?? this.userLatitude,
      userLongitude: userLongitude ?? this.userLongitude,
      currentCity: currentCity ?? this.currentCity,
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
    locationState,
    locationError,
    userAddress,
    userLatitude,
    userLongitude,
    currentCity,
    globalError,
  ];
}
