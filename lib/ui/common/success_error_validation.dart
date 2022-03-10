import 'package:flutter/material.dart';
import 'package:guilt_app/constants/assets.dart';
import 'package:guilt_app/models/PageModals/success_error_args.dart';
import 'package:guilt_app/utils/device/device_utils.dart';
import 'package:guilt_app/utils/routes/routes.dart';
import 'package:guilt_app/widgets/app_logo.dart';
import 'package:guilt_app/widgets/rounded_button_widget.dart';

class SuccessErrorValidateScreen extends StatefulWidget {
  const SuccessErrorValidateScreen({Key? key}) : super(key: key);

  @override
  _SuccessErrorValidateScreenState createState() =>
      _SuccessErrorValidateScreenState();
}

class _SuccessErrorValidateScreenState
    extends State<SuccessErrorValidateScreen> {

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as SuccessErrorValidationPageArgs;
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(top: DeviceUtils.getScaledWidth(context, 0.40)),
                child:
                Container(
                  width: DeviceUtils.getScaledWidth(context, 0.40),
                  height:  DeviceUtils.getScaledWidth(context, 0.40),
                  //width: 200,
                  //height: 200,
                  decoration: BoxDecoration(
                    color: args.isSuccess ? Colors.green : Colors.redAccent,
                    borderRadius: BorderRadius.circular(100),

                  ),
                  child: Center(
                    child: Icon(
                      args.isSuccess ? Icons.check_rounded : Icons.close_rounded,
                      color: Colors.white,
                      size: DeviceUtils.getScaledWidth(context, 0.30),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: DeviceUtils.getScaledWidth(context, 0.10)),
                child: Text(
                  args.title,
                  style: TextStyle(
                    fontSize: 25.0, color: args.isSuccess ? Colors.green : Colors.redAccent,
                    fontWeight: FontWeight.bold
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Text(
                  args.description,
                  style: TextStyle(
                      fontSize: 20.0,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                    top: DeviceUtils.getScaledHeight(context, 0.30)),
                child: GestureDetector(
                  onTap: () {
                    if(args.isPreviousLogin){
                      Routes.navigateToScreen(context, Routes.login);
                    }else{
                      Routes.goBack(context);
                    }
                  },
                  child: Text(
                    'Go Back',
                    style: TextStyle(
                        color: Colors.blue,
                        decoration: TextDecoration.underline,
                        fontStyle: FontStyle.italic),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
