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

  static const String oauth = baseUrl + "admin/oauth";


  //Terms and conditions
  static const String terms_and_conditions =
      baseUrl + "api/home/term-condition";

  // Privacy policy
  static const String privacy_policy = baseUrl + "api/home/privacy-policy";

  // Get FAQs List
  static const String faqs = baseUrl + "api/home/faqs";

// Get Latest App Version Details
  static const String about_app_version = baseUrl + "api/home/about-version";

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

  //---------ResetPassword
  // update send otp
  static const String sendOtp = baseUrl + "admin/fp-send-otp";

  // Valid Otp
  static const String validOtp = baseUrl + "admin/fp-validate";

// UpComing and Past Event
  static const String upcomingPast = baseUrl + 'api/event/upcomingAndPast';
}
