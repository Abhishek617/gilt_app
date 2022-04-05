
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:guilt_app/models/PageModals/faqs_model.dart';
import 'package:flutter/material.dart';
import 'package:guilt_app/widgets/custom_scaffold.dart';
import 'package:guilt_app/widgets/custom_scaffold.dart';
import '../../constants/colors.dart';
import '../../utils/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/rendering.dart';
import 'package:guilt_app/constants/assets.dart';
import 'package:guilt_app/data/repository.dart';
import 'package:guilt_app/di/components/service_locator.dart';
import 'package:guilt_app/models/PageModals/success_error_args.dart';
import 'package:guilt_app/stores/form/form_store.dart';
import 'package:guilt_app/stores/theme/theme_store.dart';
import 'package:guilt_app/stores/user/user_store.dart';
import 'package:guilt_app/utils/Global_methods/global.dart';
import 'package:guilt_app/utils/routes/routes.dart';
import 'package:guilt_app/widgets/app_logo.dart';
import 'package:guilt_app/widgets/textfield_widget.dart';
import 'package:provider/provider.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import '../../widgets/rounded_button_widget.dart';

class Attendees_profile extends StatefulWidget {
  const Attendees_profile({Key? key}) : super(key: key);

  @override
  State<Attendees_profile> createState() => _Attendees_profileState();
}

class _Attendees_profileState extends State<Attendees_profile> {
  @override
  Widget build(BuildContext context) {
    return ScaffoldWrapper(
        appBar: AppBar(
        shadowColor: Colors.transparent,
        centerTitle: true,
        title: const Text('Attendees'),
    ),
    child: Container(
    padding: EdgeInsets.all(16.0),
      child: Column(
        children: [
          SizedBox(
            height: 20,
          ),
          Center(child: Text("Welcome in Attendees", style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),)),
          SizedBox(
            height: 10,
          ),
          Text(
            'Lorem ipsum dolor sit amet, consectetur adipiscing elit.',
            style: TextStyle(
              fontSize: 13.0,
            ),
          ),
          AppLogoWidget(
            width: 140.0,
            height: 120.0,
          ),
          Text('Welcome', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),),
          Padding(
            padding: const EdgeInsets.only(left: 10, top: 20),
            child: ElevatedButtonWidget(
              buttonText: 'Add New Friends',
              buttonColor: AppColors.primaryColor,
              onPressed: () {
                Routes.navigateToScreen(context, Routes.add_contacts);
              },
            ),
          ),
        ],
      ),

    ),

    );
  }
}
