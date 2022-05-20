

import 'package:flutter/material.dart';
import 'package:guilt_app/constants/colors.dart';
import 'package:guilt_app/utils/device/device_utils.dart';
import 'package:guilt_app/utils/routes/routes.dart';
import 'package:guilt_app/widgets/custom_scaffold.dart';

class MyBusiness extends StatefulWidget {
  const MyBusiness({Key? key}) : super(key: key);

  @override
  State<MyBusiness> createState() => _MyBusinessState();
}
MyBusiness_list() => Column(children: [
  Card(
    child: Container(

      child: Row(
        children: [
          Align(
            alignment: Alignment.center,
            child: Stack(
              children: [
                Container(
                  child:  ClipRRect(
                    borderRadius: BorderRadius.only(topLeft:Radius.circular(2), bottomLeft: Radius.circular(2)),
                    child: Image.network(
                      'https://i.pinimg.com/474x/e7/0b/30/e70b309ec42e68dbc70972ec96f53839.jpg',
                      width:70,
                      height: 70,
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 10,
            width: 10,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Safari Menz Salon',
                style: TextStyle(
                  color: AppColors.primaryColor,
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(
                height: 8,
                width: 10,
              ),
              Text(
                'Location Name',
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 10,
                  fontWeight: FontWeight.w500,
                ),
              ),

            ],
          ),
          SizedBox(
           width: 88,
          ),
      Padding(padding: EdgeInsets.only(bottom: 22),
        child: PopupMenuButton(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(15.0))),
          offset: Offset(-22.0, 40.0),
          icon: Icon(Icons.more_vert),
          itemBuilder: (BuildContext context) => <PopupMenuEntry>[
            const PopupMenuItem(
              height: 10,
              padding: EdgeInsets.only(left: 30,top:10),
              child: Text('Edit',style: TextStyle(fontSize: 16),),
            ),
            const PopupMenuItem(
              height: 10,
              padding: EdgeInsets.only(left: 30,top: 15,bottom: 10),
               child: Text('Delete',style: TextStyle(fontSize: 16),),
            ),
            ],
        ),
      ),
        ],
      ),
    ),
  ),
  SizedBox(
    height: 10,
  )
],
);


List<String> item = [' b', 'c ', ' d', ' r', 'n ', 'y', 'f', 'm'];
class _MyBusinessState extends State<MyBusiness> {
  @override
  Widget build(BuildContext context) {
    return ScaffoldWrapper(
        isMenu: false,
        appBar: AppBar(
          shadowColor: Colors.transparent,
          leading: GestureDetector(
            onTap: () {
              Routes.goBack(context);
            },
            child: Icon(
              Icons.arrow_back_ios_outlined,
              //color: Colors.black,
              size: 16,
            ),
          ),
          title: Text('My Business',),
          centerTitle: true,

        ),
      child: Column(
        children: [
          SizedBox(
            height: 20,
          ),
          Padding(padding: EdgeInsets.only(left: 10,right: 10),
            child: Container(
              height: DeviceUtils.getScaledHeight(context, 0.844),
              child:ListView.builder(
                itemCount: item.length,
                itemBuilder: (context, index) => MyBusiness_list(),
            ),
    ),
          ),
        ],
      ),
    );
  }
}
