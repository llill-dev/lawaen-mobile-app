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
  final double? userLatitude;
  final double? userLongitude;
  final CityModel? currentCity;

  // EVENTS
  final RequestState evetnsState;
  final List<EventModel> events;
  final String? eventsError;

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
    this.userLatitude,
    this.userLongitude,
    this.currentCity,
    this.evetnsState = RequestState.idle,
    this.events = const [],
    this.eventsError,
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
    double? userLatitude,
    double? userLongitude,
    CityModel? currentCity,

    // events
    final RequestState? evetnsState,
    final List<EventModel>? events,
    final String? eventsError,

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

      userLatitude: userLatitude ?? this.userLatitude,
      userLongitude: userLongitude ?? this.userLongitude,
      currentCity: currentCity ?? this.currentCity,

      evetnsState: citiesState ?? this.evetnsState,
      events: events ?? this.events,
      eventsError: eventsError ?? this.eventsError,

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

    userLatitude,
    userLongitude,
    currentCity,

    evetnsState,
    events,
    eventsError,

    globalError,
  ];
}
