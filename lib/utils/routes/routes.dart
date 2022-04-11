import 'package:guilt_app/models/PageModals/success_error_args.dart';
import 'package:guilt_app/models/PageModals/faqs_model.dart';
import 'package:guilt_app/ui/Event/create_event.dart';
import 'package:guilt_app/ui/Event/book_event.dart';
import 'package:guilt_app/ui/Event/book_event_details.dart';
import 'package:guilt_app/ui/Event/event_detail.dart';
import 'package:guilt_app/ui/Event/expense_screen.dart';
import 'package:guilt_app/ui/Intro_screens/intro_screen.dart';
import 'package:guilt_app/ui/Messages/ChatScreen.dart';
import 'package:guilt_app/ui/Profile/full_profile.dart';
import 'package:guilt_app/ui/Profile/main_profile.dart';
import 'package:guilt_app/ui/Profile/organizer_profile.dart';
import 'package:guilt_app/ui/Profile/profile.dart';
import 'package:guilt_app/ui/Setting/setting.dart';
import 'package:guilt_app/ui/attendees/add_contacts.dart';
import 'package:guilt_app/ui/attendees/addendees_profile.dart';
import 'package:guilt_app/ui/common/about_screen.dart';
import 'package:guilt_app/ui/common/before_login_Screen.dart';
import 'package:guilt_app/ui/common/faqs.dart';
import 'package:guilt_app/ui/common/otp_screen.dart';
import 'package:guilt_app/ui/common/privacy_policy.dart';
import 'package:guilt_app/ui/common/success_error_validation.dart';
import 'package:guilt_app/ui/common/help_and_support.dart';
import 'package:guilt_app/ui/common/terms_conditions.dart';
import 'package:guilt_app/ui/feedback/add_feedback.dart';
import 'package:guilt_app/ui/feedback/feedback_list.dart';
import 'package:guilt_app/ui/forgot_reset_password/change_password.dart';
import 'package:guilt_app/ui/forgot_reset_password/reset_password.dart';
import 'package:guilt_app/ui/home/home.dart';
import 'package:guilt_app/ui/Map/map.dart';
import 'package:guilt_app/ui/login/welcome_login.dart';
import 'package:guilt_app/ui/login/login.dart';
import 'package:guilt_app/ui/payment/AddMoney.dart';
import 'package:guilt_app/ui/payment/Payment_history.dart';
import 'package:guilt_app/ui/payment/bank_lists.dart';
import 'package:guilt_app/ui/payment/card_details.dart';
import 'package:guilt_app/ui/signUp/signUp.dart';
import 'package:guilt_app/ui/splash/splash.dart';
import 'package:flutter/material.dart';
import 'package:guilt_app/ui/Event/event.dart';
import '../../ui/Messages/message.dart';
import '../../ui/attendees/attendees.dart';
import '../../ui/notification/notification.dart';
import '../../ui/Business/add_business.dart';
import '../../ui/Business/business_list.dart';
import '../../ui/payment/expense.dart';
import '../../ui/payment/wallet.dart';

class Routes {
  Routes._();

  //static variables
  static const String map = '/map';
  static const String addmoney = '/addmoney';
  static const String wallet = '/wallet';
  static const String expensehistory = '/expensehistory';
  static const String paymenthistory = '/paymenthistory';
  static const String organizerprof = '/organizerprof';
  static const String chat = '/chat';
  static const String message = '/message';
  static const String setting = '/setting';
  static const String splash = '/splash';
  static const String login = '/login';
  static const String welcome_login = '/welcome_login';
  static const String before_login = '/before_login';
  static const String home = '/home';
  static const String intro = '/intro';
  static const String forgot_password = '/forgot_password';
  static const String reset_password = '/reset_password';
  static const String otp = '/otp';
  static const String signup = '/signup';
  static const String success_error_validate = '/success_error_validate';
  static const String privacy_policy = '/privacy_policy';
  static const String terms_conditions = '/terms_conditions';
  static const String faqs = '/faqs';
  static const String prof = '/prof';
  static const String events_home = '/events_home';
  static const String view_profile = '/view_profile';
  static const String add_business = '/add_business';
  static const String business_list = '/business_list';

  static const String event = '/event';
  static const  String event_details = '/event_details';
  static const  String atendees = '/atendees';
  static const  String notifi = '/notifi';
  static const  String book_event = '/book_event ';
  static const  String book_event_details = '/book_event_details ';
  static const  String help_and_support = '/help_and_support';
  static const  String about_screen = '/about_screen';
  static const  String create_event = '/createevent';
  static const  String expense_screen = '/expense_screen';
  static const  String attendees_profile= '/attendees_profile';
  static const  String add_contacts= '/add_contacts';
  static const  String bank_lists= '/Bank_lists';
  static const  String card_details= '/card_details';
  static const  String add_feedback= '/add_feedback';
  static const  String feedback_list= '/feedback_list';



  static final routes = <String, WidgetBuilder>{
    map: (BuildContext context) => Map(),
    addmoney: (BuildContext context) => AddMoney(),
    wallet: (BuildContext context) => Wallet(),
    expensehistory: (BuildContext context) => Expense(),
    paymenthistory: (BuildContext context) => PaymentHistory(),
    organizerprof: (BuildContext context) => OrganizerProfile(),
    chat: (BuildContext context) => ChatScreen(),
    message: (BuildContext context) => Messages(),
    setting: (BuildContext context) => Setting(),
    splash: (BuildContext context) => SplashScreen(),
    intro: (BuildContext context) => OnBoardingPage(),
    welcome_login: (BuildContext context) => WelcomeLogin(),
    before_login: (BuildContext context) => Before_LoginScreen(),
    login: (BuildContext context) => Login(),
    home: (BuildContext context) => HomeScreen(),
    otp: (BuildContext context) => Otp_screen(),
    forgot_password: (BuildContext context) => Reset_password(),
    reset_password: (BuildContext context) => Change_password(),
    signup: (BuildContext context) => SignUp(),
    success_error_validate: (BuildContext context) =>
        SuccessErrorValidateScreen(),
    privacy_policy: (BuildContext context) => Privacy_Policy(),
    terms_conditions: (BuildContext context) => Terms_Condition(),
    faqs: (BuildContext context) => FaqScreen(),
    prof: (BuildContext context) => Profile(),
    view_profile: (BuildContext context) => FullProfile(),
    events_home: (BuildContext context) => MainProfile(),
    add_business: (BuildContext context) => Add_business(),
    business_list: (BuildContext context) => Business_list(),

    events_home: (BuildContext context) => MainProfile(),
    event: (BuildContext context) => Event(),
    event_details: (BuildContext context) => EventDetails(),
    atendees: (BuildContext context) => Attendees(),
    notifi: (BuildContext context) => Notifications(),
    book_event: (BuildContext context) => BookEvent(),
    book_event_details: (BuildContext context) => BookEventDetails(),
    notifi: (BuildContext context) => Notifications(),
    help_and_support: (BuildContext context) => HelpAndSupport(),
    about_screen: (BuildContext context) => About_screen(),
    create_event: (BuildContext context) => Create_event(),
    expense_screen: (BuildContext context) => Expense_Screen(),
    attendees_profile: (BuildContext context) => Attendees_profile(),
    add_contacts: (BuildContext context) => Add_contacts(),
    bank_lists: (BuildContext context) => Bank_lists(),
    card_details: (BuildContext context) => Card_details(),
    add_feedback: (BuildContext context) => Add_feedback(),
    feedback_list: (BuildContext context) => Feedback_list(),




  };

  static navigateToScreen(BuildContext context, route) {
    Navigator.of(context).pushNamed(route);
  }

  static navigateRootToScreen(BuildContext context, route) {
    Navigator.of(context)
        .pushNamedAndRemoveUntil(route, (Route route) => false);
  }

  static navigateToScreenWithArgs(
      BuildContext context, route, successErrorValidationPageArgs) {
    Navigator.of(context)
        .pushNamed(route, arguments: successErrorValidationPageArgs);
  }

  static goBack(BuildContext context) {
    Navigator.of(context).pop();
  }
}
