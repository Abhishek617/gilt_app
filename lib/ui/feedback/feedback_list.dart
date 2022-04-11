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


class Feedback_list extends StatefulWidget {
  const Feedback_list({Key? key}) : super(key: key);

  @override
  State<Feedback_list> createState() => _Feedback_listState();
}

class _Feedback_listState extends State<Feedback_list> {
  @override
  Widget build(BuildContext context) {
    return ScaffoldWrapper(
        isMenu: false,
        appBar: AppBar(
          leading: GestureDetector(
            onTap: () {
              Routes.goBack(context);
            },
            child: Icon(
              Icons.arrow_back_ios_outlined,
              //color: Colors.black,
              size: 15,
            ),
          ),
          title: Text('Feedbacks'),
          shadowColor: Colors.transparent,
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(25),
            child: Center(
              child: Column(
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    width: DeviceUtils.getScaledWidth(context, 0.90),
                    height: DeviceUtils.getScaledHeight(context, 1.100),
                    child:ListView.builder(
                        itemCount: 20,
                        itemBuilder: (BuildContext context,int index){
                          return Card(
                            elevation: 5,
                            child: ListTile(
                              title:Text("A Virtual Evening of somoothJazz", style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),),
                              subtitle: Row(
                                children: [Icon(Icons.tag_faces_outlined, color: Colors.purple,),
                                  Text(" We got good feedback,",style: TextStyle(fontSize: 13),)],
                              )
                          ),
                          );
                        }
                    ),
                  ),
                ],
              ),
            ),
          ),
        )
    );
  }
}
