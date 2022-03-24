class Endpoints {
  Endpoints._();

// Global
  // base url
  static const String baseUrl = "https://guilt.developmentlabs.co/";

  // receiveTimeout
  static const int receiveTimeout = 15000;

  // connectTimeout
  static const int connectionTimeout = 30000;

  // login endpoints
  static const String login = baseUrl + "admin/login";

  //---------Auth
  //logout
  static const String logout = baseUrl + "admin/logout";

  //signup
  static const String register = baseUrl + "api/admin";

  //---------Profile
  // get profile details
  static const String getProfile = baseUrl + "profile";

  // update profile details
  static const String updateProfile = baseUrl + "profile";
}
