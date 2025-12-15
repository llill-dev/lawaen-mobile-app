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

  // CATEGORY DETAILS
  final RequestState categoryDetailsState;
  final List<CategoryDetailsModel> categoryDetails;
  final String? categoryDetailsError;
  final bool isLoadMore;
  final int homeDataCurrentPage;
  final int homeDataLimit;
  final bool homeDataHasMore;

  // CONTACT
  final RequestState contactState;
  final List<ContactModel> contact;
  final String? contactError;

  // WEATHER
  final RequestState weatherState;
  final WeatherModel? weather;
  final String? weatherError;

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
    this.categoryDetailsState = RequestState.idle,
    this.categoryDetails = const [],
    this.categoryDetailsError,
    this.isLoadMore = false,
    this.homeDataCurrentPage = 1,
    this.homeDataLimit = 10,
    this.homeDataHasMore = true,
    this.contactState = RequestState.idle,
    this.contact = const [],
    this.contactError,
    this.weatherState = RequestState.idle,
    this.weather,
    this.weatherError,
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

    // category details
    final RequestState? categoryDetailsState,
    final List<CategoryDetailsModel>? categoryDetails,
    final String? categoryDetailsError,
    final bool? isLoadMore,
    final int? homeDataCurrentPage,
    final int? homeDataLimit,
    final bool? homeDataHasMore,

    // contact
    final RequestState? contactState,
    final List<ContactModel>? contact,
    final String? contactError,

    // weather
    final RequestState? weatherState,
    final WeatherModel? weather,
    final String? weatherError,

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

      evetnsState: evetnsState ?? this.evetnsState,
      events: events ?? this.events,
      eventsError: eventsError,

      categoryDetailsState: categoryDetailsState ?? this.categoryDetailsState,
      categoryDetails: categoryDetails ?? this.categoryDetails,
      categoryDetailsError: categoryDetailsError,
      isLoadMore: isLoadMore ?? this.isLoadMore,

      homeDataCurrentPage: homeDataCurrentPage ?? this.homeDataCurrentPage,
      homeDataLimit: homeDataLimit ?? this.homeDataLimit,
      homeDataHasMore: homeDataHasMore ?? this.homeDataHasMore,

      contactState: contactState ?? this.contactState,
      contact: contact ?? this.contact,
      contactError: contactError,

      weatherState: weatherState ?? this.weatherState,
      weather: weather ?? this.weather,
      weatherError: weatherError,

      globalError: globalError,
    );
  }

  @override
  List<Object?> get props => [
    // cities
    citiesState,
    cities,
    citiesError,

    // categories
    categoriesState,
    categories,
    categoriesError,

    // location
    locationState,
    locationError,
    userLatitude,
    userLongitude,
    currentCity,

    // events
    evetnsState,
    events,
    eventsError,

    // category details
    categoryDetailsState,
    categoryDetails,
    categoryDetailsError,
    isLoadMore,
    homeDataCurrentPage,
    homeDataLimit,
    homeDataHasMore,

    // contact
    contactState,
    contact,
    contactError,

    // weather
    weatherState,
    weather,
    weatherError,

    globalError,
  ];
}
