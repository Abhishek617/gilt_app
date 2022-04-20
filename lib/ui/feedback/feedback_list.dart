import 'dart:convert';
import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:guilt_app/models/Auth/feedback_add_model.dart';
import 'package:guilt_app/models/Auth/feedback_list_model.dart';
import 'package:guilt_app/models/PageModals/faqs_model.dart';
import 'package:flutter/material.dart';
import 'package:guilt_app/ui/feedback/feedback_list_model.dart';
import 'package:guilt_app/ui/feedback/feedback_list_model.dart';
import 'package:guilt_app/ui/feedback/feedback_list_model.dart';
import 'package:guilt_app/ui/feedback/feedback_list_model.dart';
import 'package:guilt_app/ui/feedback/feedback_list_model.dart';
import 'package:guilt_app/ui/feedback/feedback_list_model.dart';
import 'package:guilt_app/ui/feedback/feedback_list_model.dart';
import 'package:guilt_app/ui/feedback/feedback_list_model.dart';
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
import 'feedback_list_model.dart';
import 'feedback_list_model.dart';
import 'feedback_list_model.dart';
import 'feedback_list_model.dart';
import 'feedback_list_model.dart';
import 'feedback_list_model.dart';


class Feedback_list extends StatefulWidget {
  const Feedback_list({Key? key}) : super(key: key);

  @override
  State<Feedback_list> createState() => _Feedback_listState();

  static Feedback? fromJson(value) {}
}

class _Feedback_listState extends State<Feedback_list> {
  List<dynamic> Feedback_list_data = [];
  late UserStore _feedbackStore;
  Feedback? contentData;
   get_feedback_list() => _feedbackStore.Feedback_list(5,(value) {
     setState(() {
       this.Feedback_list_data = value.eventFeedbacks;
     });
   },(error) {
     print(error);
    final data = json.decode(json.encode(error.data)) as Map<String, dynamic>;
    GlobalMethods.showErrorMessage(context,data['message'], 'Log In Exception');
   });
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _feedbackStore= Provider.of<UserStore>(context);
    get_feedback_list();
  }
  // Widget getConditionsWidgets() {
  //   if (contentData != null) {
  //     return Column(
  //       children: contentData.map(
  //               (feedback_list) => Feedback_list_data( )
  //       )
  //           .toList(),
  //     );
  //   }
  //   else {
  //     return Text('No Data found');
  //   }
  // }



  // Widget feedback(description, eventId, rate) {
  //   return Column(
  //     children: [
  //       Card(
  //         shadowColor: AppColors.grayTextColor,
  //         elevation: 2.5,
  //         child: Container(
  //           margin: EdgeInsets.all(5),
  //           width: DeviceUtils.getScaledWidth(context, 0.90),
  //
  //           child: Row(
  //             children: [
  //
  //               Expanded(
  //                 child: Column(
  //                   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  //                   crossAxisAlignment: CrossAxisAlignment.start,
  //                   children: [
  //                     Text('13 JAN 2022, 2:00PM - Past Event',
  //                         style: TextStyle(
  //                             color: AppColors.primaryColor,
  //                             fontSize: 12,
  //                             fontWeight: FontWeight.w400)),
  //                     Text(description.name,
  //                         style: TextStyle(
  //                             fontSize: 18, fontWeight: FontWeight.w700)),
  //                     Row(
  //                       children: [
  //                         Icon(
  //                           Icons.location_on,
  //                           size: 12,
  //                           color: AppColors.grayTextColor,
  //                         ),
  //
  //                         Text(description.location,
  //                           style: TextStyle(
  //                               fontSize: 12,
  //                               fontWeight: FontWeight.w500,
  //                               color: AppColors.grayTextColor),
  //                         ),
  //                       ],
  //                     ),
  //                   ],
  //                 ),
  //               ),
  //             ],
  //           ),
  //         ),
  //       ),
  //       Divider(
  //         color: Colors.black12,
  //         //color of divider
  //         height: 20,
  //         //height spacing of divider
  //         thickness: 1,
  //         //thickness of divier line
  //         indent: 20,
  //         //spacing at the start of divider
  //         endIndent: 20, //spacing at the end of divider
  //       ),
  //     ],
  //   );
  //
  // }


  // Widget getConditionsWidgets() {
  //   if (contentData != null) {
  //     return Column(
  //       children: contentData!.eventId.listData
  //           .map(
  //               (Feedback) => eventId(Feedback_list_data, Colors.white,
  //              )
  //       )
  //           .toList(),
  //     );
  //   }
  //   else {
  //     return Text('No Data found');
  //   }
  // }




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
                  (Feedback_list_data.length > 0)?
                  Container(
                    width: DeviceUtils.getScaledWidth(context, 0.90),
                    height: DeviceUtils.getScaledHeight(context, 1.100),
                    child:ListView.builder(
                        itemCount: Feedback_list_data.length,
                        itemBuilder: (BuildContext context,int index){
                          return Card(
                            elevation: 5,
                            child: ListTile(
                                title:Row(
                                  children: [
                                    Icon(Icons.tag_faces_outlined, color: Colors.purple),
                                    SizedBox(
                                      width: 3,
                                    ),
                                    Text(Feedback_list_data[index].rate,style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),),
                                  ],
                                ),
                                subtitle: Row(
                                  children: [
                                  SizedBox(
                                    height: 3,
                                  ),
                                   Padding(
                                     padding: const EdgeInsets.only(left: 5),
                                     child: Text(Feedback_list_data[index].description,style: TextStyle(fontSize: 13,fontWeight: FontWeight.bold),),
                                   )
                              ],
                            )
                            ),
                          );
                        }
                    ),
                  ):
                      Center(
                        child: Text("No Data found"),
                      )
                ],
              ),
            ),
          ),
        )
    );
  }
}
