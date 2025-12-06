class Urls {
  //auth
  static const String _authPrefix = "auth";
  static const String login = "$_authPrefix/login";
  static const String register = "$_authPrefix/register";
  static const String refreshToken = "$_authPrefix/refresh_token";
  static const String changePassword = "$_authPrefix/change-password";

  //home
  static const String getCities = "cities/get";
  static const String getCategories = "category/get";
  static const String getMapMarkers = "category/get_main";

  //category details
  static const String getCategoryDetails = "/location/by_basic/{id}";
  static const String getCategoryDetailsBySecond = "/location/by_second/{id}";

  static const String getItemData = "/location/by_id/{second_id}/{id}";

  static const String searchLocation = "location/search";
}
