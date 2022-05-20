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
import 'package:guilt_app/ui/home/home_explore_screen.dart';
import 'package:guilt_app/ui/Profile/organizer_profile.dart';
import 'package:guilt_app/ui/Profile/profile.dart';
import 'package:guilt_app/ui/Setting/setting.dart';
import 'package:guilt_app/ui/Tab/home_tab.dart';
import 'package:guilt_app/ui/attendees/add_contacts.dart';
import 'package:guilt_app/ui/attendees/addendees_profile.dart';
import 'package:guilt_app/ui/common/about_screen.dart';
import 'package:guilt_app/ui/common/before_login_Screen.dart';
import 'package:guilt_app/ui/common/change_old_password.dart';
import 'package:guilt_app/ui/common/faqs.dart';
import 'package:guilt_app/ui/common/otp_screen.dart';
import 'package:guilt_app/ui/common/privacy_policy.dart';
import 'package:guilt_app/ui/common/success_error_validation.dart';
import 'package:guilt_app/ui/common/help_and_support.dart';
import 'package:guilt_app/ui/common/terms_conditions.dart';
import 'package:guilt_app/ui/common/validate_otp_screen.dart';
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
import 'package:guilt_app/ui/payment/cards.dart';
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
import '../../utils/routes/routes.dart';
import '../../widgets/custom_scaffold.dart';
class Pay_Request extends StatefulWidget {
  const Pay_Request({Key? key}) : super(key: key);

  @override
  State<Pay_Request> createState() => _Pay_RequestState();
}

class _Pay_RequestState extends State<Pay_Request> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(20),
          ),
        ),
        toolbarHeight: 100,
        leading: GestureDetector(
          onTap: () {
    Routes.goBack(context);
    },
      child: Icon(
        Icons.arrow_back_ios_outlined,
        color: Colors.black,
        size: 15,
      ),
    ),
        title: Container(
          height  : 40,
          width: 300,
          child:         TextField(
            cursorColor: Colors.black,
            style: TextStyle(
                color: Colors.white
            ),
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.white,
              border: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.circular(50)
              ),
            ),
          ),
          padding: EdgeInsets.all(16.0),
        ),
        actions: [
        ],
        backgroundColor: Colors.pink[950],
      ),
    );
  }
}
