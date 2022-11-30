import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:guilt_app/utils/device/device_utils.dart';
import 'package:guilt_app/widgets/custom_scaffold.dart';

import '../../utils/Global_methods/global.dart';
import '../../utils/routes/routes.dart';

import 'package:flutter/rendering.dart';

import 'package:guilt_app/stores/user/user_store.dart';

import 'package:guilt_app/utils/routes/routes.dart';

import 'package:provider/provider.dart';


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
    _feedbackStore = Provider.of<UserStore>(context);
    get_feedback_list();

  }


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
