import 'package:flutter/material.dart';

import 'package:guilt_app/utils/device/device_utils.dart';
import 'package:guilt_app/widgets/custom_scaffold.dart';

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

  late UserStore _postStore;
  Feedback? contentData;


  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _postStore = Provider.of<UserStore>(context);
    _postStore.getAppContent('Feedback').then((value) {
      print(value);
      setState(() {
        contentData = Feedback_list.fromJson(value);
        print('feedback');

       // print(contentData!.?.title.toString());
      });
    }).catchError((error) {
      print(error.toString());
    });
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
