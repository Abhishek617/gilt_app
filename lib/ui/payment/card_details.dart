import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:guilt_app/models/PageModals/faqs_model.dart';
import 'package:flutter/material.dart';
import 'package:guilt_app/utils/device/device_utils.dart';
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
class Card_details extends StatefulWidget {
  const Card_details({Key? key}) : super(key: key);

  @override
  State<Card_details> createState() => _Card_detailsState();
}

class _Card_detailsState extends State<Card_details> {
  bool agree = false;

  @override
  Widget build(BuildContext context) {

    return ScaffoldWrapper(
     // backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        leading: GestureDetector(
          onTap: () {
            Routes.navigateRootToScreen(context, Routes.bank_lists);
          },
          child: Icon(
            Icons.arrow_back_ios_outlined,
            color: Colors.white,
            size: 15,
          ),
        ),
      ),
      child:Center(
      child: Column(
        children: [
          SizedBox(
            height: 15,
           // width: 15,
          ),
          Text("Details of Accounts",style: TextStyle(fontWeight: FontWeight.bold),),
          SizedBox(
            height: 24,
          ),
          Container(
            width: 350,
          child: TextField(
            decoration: InputDecoration(
              hintText: "visa****2525",
              border: OutlineInputBorder(),
              prefixIcon: IconButton(
                onPressed: () {
                  print('search button pressed');
                },
                icon: Icon(Icons.credit_card),
              ),
              suffixIcon: Container(
                width: DeviceUtils.getScaledWidth(context, 0.23),
                child: Row(
                  children: [
                    Container(
                      width: DeviceUtils.getScaledWidth(context, 0.09),
                      height: DeviceUtils.getScaledHeight(context, 0.06),
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.blue),
                      child: IconButton(
                        onPressed: () {
                          print('mic button pressed');
                        },
                        icon: Icon(Icons.delete,color: Colors.white
                          , size: 15,),
                      ),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Container(
                      width: DeviceUtils.getScaledWidth(context, 0.09),
                      height: DeviceUtils.getScaledHeight(context, 0.06),

                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.blue),
                      child: IconButton(
                        onPressed: () {
                          print('mic button pressed');
                        },
                        icon: Icon(Icons.edit,color: Colors.white
                          , size: 15,),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

    ),
          SizedBox(
            height: 15,
          ),
          Container(
            width: DeviceUtils.getScaledWidth(context, 0.88),
    child: TextField(
      decoration: InputDecoration(
        hintText: "visa****2525",
        border: OutlineInputBorder(),
        prefixIcon: IconButton(
          onPressed: () {
            print('search button pressed');
          },
          icon: Icon(Icons.credit_card),
        ),
        suffixIcon: Container(
          width: DeviceUtils.getScaledWidth(context, 0.23),
          child: Row(
            children: [
              Container(
                width: DeviceUtils.getScaledWidth(context, 0.09),
                height: DeviceUtils.getScaledHeight(context, 0.06),
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.blue),
                child: IconButton(
                  onPressed: () {
                    print('mic button pressed');
                  },
                  icon: Icon(Icons.delete,color: Colors.white
                    , size: 15,),
                ),
              ),
              SizedBox(
                width: 5,
              ),
              Container(
                width: DeviceUtils.getScaledWidth(context, 0.09),
                height: DeviceUtils.getScaledHeight(context, 0.06),

                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.blue),
                child: IconButton(
                  onPressed: () {
                    print('mic button pressed');
                  },
                  icon: Icon(Icons.edit,color: Colors.white
                    , size: 15,),
                ),
              ),
            ],
          ),
        ),
      ),
    ),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            //width: DeviceUtils.getScaledWidth(context, 0.09),
            height: DeviceUtils.getScaledHeight(context, 0.30),
            child: ListTile(
              leading: Container(
                  width: DeviceUtils.getScaledWidth(context, 0.09),
                  height: DeviceUtils.getScaledHeight(context, 0.06),
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('assets/images/card.png'),
                        fit: BoxFit.fitWidth
                    ),
                  )
              ),
              title: Text('Add New'),
              trailing: Checkbox(
                shape: CircleBorder(),
                value: agree,
                onChanged: (value) {
                  setState(() {
                    agree = value ?? false;
                    Routes.navigateRootToScreen(context, Routes.bank_lists);

                  });
                },
              ),


            ),
          )



        ],
      ),
      ),
    );
  }
}
