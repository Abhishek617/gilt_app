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

  // Get Registered Users of contact List
  static const String checkContacts = baseUrl + "api/contact/check";

  //---------Auth
  //logout
  static const String logout = baseUrl + "admin/logout";

  //Refresh Token
  static const String refreshToken = baseUrl + "admin/refreshToken";

  //signup
  static const String register = baseUrl + "api/admin";

  //change password
  static const String changePassword = baseUrl + "api/admin/changepassword";

  //---------Business
  // Add Business
  static const String addBusiness = baseUrl + "api/business/add";
  // delete Business
  static const String deleteBusiness = baseUrl + "api/business";
  // My Business List
  static const String myBusinessList = baseUrl + "api/business/search";
  //Get Business Places
  static const String getBusinessPlaces = baseUrl + "api/business-places";

  //Get Business Spaces
  static const String getBusinessSpaces = baseUrl + "api/business-spaces";
  static const String uploadChatImage = baseUrl + "api/chatImage/upload";

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

  //otp validate
  static const String OtpValidate = baseUrl + "admin/otp-validate";

  // Getting Event Details
  static const String eventDetail = baseUrl + 'api/event';

// UpComing and Past Event
  static const String upcomingPast = baseUrl + 'api/event/upcomingAndPast';

  // setting
  static const String setting = baseUrl + 'api/settings';

  //feedback_add
  static const String feedbackadd = baseUrl + 'api/eventFeedback/add';

  //Feddback List
  static const String feedbacklist = baseUrl + 'api/eventFeedback/';

//Notificationlist
  static const String notificationlist = baseUrl + 'api/notification';

//--------Events------------>
//EventView
  static const String userEvents = baseUrl + 'api/event';

  //Search Event List
  static const String searchEvent = baseUrl + 'api/event/search';

  //My Booked Event List
  static const String myBookedEvent = baseUrl + 'api/event/myBookedEvents';

//CreateEvent
  static const String addEvent = baseUrl + 'api/event/add';
}
