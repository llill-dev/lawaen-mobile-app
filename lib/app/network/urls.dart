class Urls {
  //auth
  static const String _authPrefix = "auth";
  static const String login = "$_authPrefix/login";
  static const String register = "$_authPrefix/register";
  static const String refreshToken = "$_authPrefix/refresh_token";
  static const String changePassword = "$_authPrefix/change_password";
  static const String updateProfile = "$_authPrefix/update_profile";
  static const String forgotPassword = "$_authPrefix/forgot_password/forgot";
  static const String sendPasscode = "$_authPrefix/forgot_password/send_passcode";
  static const String resetPasswordAfterActive = "$_authPrefix/forgot_password/reset_password_after_active";
  static const String logout = "$_authPrefix/account/logout";
  static const String deleteAccount = "$_authPrefix/account/delete_account";

  //home
  static const String getCities = "cities/get";
  static const String getCategories = "category/get";
  static const String getMapMarkers = "category/get_main";
  static const String getHomeEvents = "event/event_home";
  static const String registerFcmToken = "fcm/save_fcm";
  static const String homeData = "location/home_data";
  static const String getMune = "menu/get";
  static const String getBanners = "banner/get";
  static const String getContact = "other/contact";
  static const String getWeather = "https://api.open-meteo.com/v1/forecast";

  //event
  static const String getEventTypes = "event/event_type";
  static const String getEvents = "event/event_by_category/{id}";

  //add to app
  static const String addEvent = "req_data/add_event";
  static const String addMissingPlace = "req_data/add_missing_place";
  static const String addOffer = "req_data/add_offer";

  //category details
  static const String getCategoryDetails = "location/by_basic/{id}";
  static const String getCategoryDetailsBySecond = "location/by_second/{id}";

  // category item details
  static const String getItemData = "location/by_id/{second_id}/{id}";
  static const String toggleFavorite = "user_activity/toggle_save/{second_id}/{id}";
  static const String rateItem = "user_activity/rate_item/{second_id}/{id}";
  static const String sendFeedBack = "user_activity/add_message/{second_id}/{id}";
  static const String claimItem = "user_activity/claim/{second_id}/{id}";
  static const String reportItem = "user_activity/add_report/{second_id}/{id}";
  static const String getMessages = "user_activity/get_message/{second_id}/{id}";

  //map
  static const String searchLocation = "location/search";

  //offers
  static const String getOfferType = "offer/offer_type";
  static const String getOffers = "offer/get_offer";

  //explore
  static const String getExplore = "location/by_explore/{id}";
  static const String getUserPreferences = "category/get_explore_category";

  //profile
  static const String contactUS = "req_data/send_message";
  static const String getProfilePages = "pages/get";
  static const String getProfilePage = "pages/get_by_id/{id}";
  static const String getCounts = "profile/get_count";
  static const String getSaved = "profile/get_saved";
  static const String getRated = "profile/get_rated";

  //onboarding
  static const String adminMessage = "message/admin_message";
}
