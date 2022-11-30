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

  // Search User List
  static const String searchUser = baseUrl + "api/admin/search";

  //---------Business
  // Add Business
  static const String addBusiness = baseUrl + "api/business/add";
  // update Business
  static const String updateBusiness = baseUrl + "api/business";

  // delete Business
  static const String deleteBusiness = baseUrl + "api/business";

  // My Business List
  static const String myBusinessList = baseUrl + "api/business/search";

  // All Business List
  static const String allBusinessList = baseUrl + "api/business";

  // Business Details
  static const String businessDetail = baseUrl + "api/business";


  // Search Business List of User
  static const String searchByNameBusinessList =
      baseUrl + "api/business/getByName";
  // Search own Business List of User
  static const String searchOwnBusinessList =
      baseUrl + "api/business/getOwnBusinessByName";
  // Request for Business by Business Owner to User
  static const String requestPaymentBusiness =
      baseUrl + "api/paymentRequest/add";

  // Pay by Business Owner to User
  static const String payToUser = baseUrl + "api/payments/chargeProfile";

  // Pay to event
  static const String padToEvent = baseUrl + "api/payments/paidToEvent";

  // Add money to wallet
  static const String addMoneyToWallet =
      baseUrl + "api/payments/addMoneyToWallet";

  // My wallet balance
  static const String myWalletBalance = baseUrl + "api/payments/myBalance";

  // Send money to bank/Credit bank account
  static const String creditBankAccount =
      baseUrl + "api/payments/creditBankAccount";

  // Saved card list
  static const String savedCardList = baseUrl + "api/payments/myCards";

  // Pay for Business by User to Business Owner
  static const String payForBusiness = baseUrl + "api/business";

  //Add Card/Bank account
  static const String addCardOrBank = baseUrl + "api/payments/add";

  //Edit Card/Bank account
  static const String editCardOrBank = baseUrl + "api/payments/update";

  //Payment history
  static const String paymentHistory = baseUrl + "api/payments/history";

  //Remove Payment method
  static const String removePaymentMethod = baseUrl + "api/payments";

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

  //My  Event List
  static const String myEvent = baseUrl + 'api/event/myBookedEvents';

//CreateEvent
  static const String addEvent = baseUrl + 'api/event/add';

  //CreateEvent
  static const String updateEvent = baseUrl + 'api/event';

  //CreateEvent
  static const String cancelEvent = baseUrl + 'api/event/cancel';

  // Accept or Reject Event
  static const String acceptRejectEvent = baseUrl + 'api/event/acceptReject';

  // Help and support
  static const String helpAndSupport = baseUrl + 'api/support/';
}
