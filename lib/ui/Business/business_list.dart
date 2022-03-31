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


class Business_list extends StatefulWidget {
  const Business_list({Key? key}) : super(key: key);

  @override
  State<Business_list> createState() => _Business_listState();
}

class _Business_listState extends State<Business_list> {
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
          title: Padding(
            padding: const EdgeInsets.only(left: 55),
            child: Text('Business Listing'),
          ),
          shadowColor: Colors.transparent,
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(25),
            child: Center(
              child: Column(
                children: [
                  Container(
                    width: 350,
                    height: 240,
                    //color: Colors.grey,
                    child: Card(
                      elevation: 10,
                      child: Column(
                        children: [
                          Stack(
                            children: [
                              Center(
                                child: Container(
                                  height: 130,
                                  width: 334,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    image: DecorationImage(
                                      image: NetworkImage('https://media.istockphoto.com/photos/hotel-sign-picture-id487042276?k=20&m=487042276&s=612x612&w=0&h=NLfA9CVOjegM4lyIAEEj_Pof5VsahxfVYqTmO9F3Q3g='),
                                      fit: BoxFit.fill,
                                    ),
                                ),
                                ),
                              ),
                              Center(
                                child: Padding(
                                  padding: const EdgeInsets.only(top: 105),
                                  child: Card(

                                   elevation: 0,
                                    child: Container(
                                      height: 40,
                                      width: 150,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(40),
                                      ),
                                      child: Center(child: Text('\$ 320/ Night', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.blue),)),
                                    ),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20.0),
                                  ),
                                ),
                              ),
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: Row(
                              children: [
                                Row(
                                  children: [
                                    Text("Holoday Inn Express Albanay", style: TextStyle(fontWeight: FontWeight.bold),),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: Row(
                              children: [
                                Text('Private Room', style: TextStyle(fontSize: 13),),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 8),
                            child: Row(
                              children: [
                               Icon(Icons.location_on_outlined, size: 20, color: Colors.blueGrey,),
                                Text('300 Broadway, Albany, New York 1227', style: TextStyle(color: Colors.blueGrey),),
                                SizedBox(
                                  width: 30,
                                ),
                                Icon(Icons.send, color: Colors.blue,)
                              ],
                            ),
                          ),
                        ],
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                    ),
                  ),




                  SizedBox(
                    height: 20,
                  ),

                  Container(
                    width: 350,
                    height: 240,
                    //color: Colors.grey,
                    child: Card(
                      elevation: 10,
                      child: Column(
                        children: [
                          Stack(
                            children: [
                              Center(
                                child: Container(
                                  height: 130,
                                  width: 334,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    image: DecorationImage(
                                      image: NetworkImage('https://bsmedia.business-standard.com/_media/bs/img/article/2021-03/06/full/1614979411-2048.jpg'),
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                ),
                              ),
                              Center(
                                child: Padding(
                                  padding: const EdgeInsets.only(top: 105),
                                  child: Card(

                                    elevation: 0,
                                    child: Container(
                                      height: 40,
                                      width: 150,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(40),
                                      ),
                                      child: Center(child: Text('\$ 220/ Night', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.blue),)),
                                    ),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20.0),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: Row(
                              children: [
                                Row(
                                  children: [
                                    Text("Royal Hotel", style: TextStyle(fontWeight: FontWeight.bold),),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: Row(
                              children: [
                                Text('Private Room', style: TextStyle(fontSize: 13),),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 8),
                            child: Row(
                              children: [
                                Icon(Icons.location_on_outlined, size: 20, color: Colors.blueGrey,),
                                Text('300 Broadway, Albany, New York 1227', style: TextStyle(color: Colors.blueGrey),),
                                SizedBox(
                                  width: 30,
                                ),
                                Icon(Icons.send, color: Colors.blue,),
                              ],
                            ),
                          ),
                        ],
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                    ),
                  ),



                  SizedBox(
                    height: 20,
                  ),


                  Container(
                    width: 350,
                    height: 240,
                    //color: Colors.grey,
                    child: Card(
                      elevation: 10,
                      child: Column(
                        children: [
                          Stack(
                            children: [
                              Center(
                                child: Container(
                                  height: 130,
                                  width: 334,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    image: DecorationImage(
                                      image: NetworkImage('https://www.americanexpress.com/en-us/travel/discover/photos/301206/68847/530/Exterior.jpg?ch=310'),
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                ),
                              ),
                              Center(
                                child: Padding(
                                  padding: const EdgeInsets.only(top: 105),
                                  child: Card(

                                    elevation: 0,
                                    child: Container(
                                      height: 40,
                                      width: 150,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(40),
                                      ),
                                      child: Center(child: Text('\$ 420/ Night', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.blue),)),
                                    ),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20.0),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: Row(
                              children: [
                                Row(
                                  children: [
                                    Text(" Albanay Mark Hotel", style: TextStyle(fontWeight: FontWeight.bold),),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: Row(
                              children: [
                                Text('Private Room', style: TextStyle(fontSize: 13),),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 8),
                            child: Row(
                              children: [
                                Icon(Icons.location_on_outlined, size: 20, color: Colors.blueGrey,),
                                Text('300 Broadway, Albany, New York 1227', style: TextStyle(color: Colors.blueGrey),),
                                SizedBox(
                                  width: 30,
                                ),
                                Icon(Icons.send, color: Colors.blue,)
                              ],
                            ),
                          ),
                        ],
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                    ),
                  ),



                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    width: 350,
                    height: 240,
                    //color: Colors.grey,
                    child: Card(
                      elevation: 10,
                      child: Column(
                        children: [
                          Stack(
                            children: [
                              Center(
                                child: Container(
                                  height: 130,
                                  width: 334,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    image: DecorationImage(
                                      image: NetworkImage('https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRCYNMsniP-nPc4O9UXSlQCUUGL1oHCTo6mSxpB8WJJRdd4fpNo5OtMWwITO_q8oYNTprE&usqp=CAU'),
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                ),
                              ),
                              Center(
                                child: Padding(
                                  padding: const EdgeInsets.only(top: 105),
                                  child: Card(

                                    elevation: 0,
                                    child: Container(
                                      height: 40,
                                      width: 150,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(40),
                                      ),
                                      child: Center(child: Text('\$ 520/ Night', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.blue),)),
                                    ),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20.0),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: Row(
                              children: [
                                Row(
                                  children: [
                                    Text("Express Hotel", style: TextStyle(fontWeight: FontWeight.bold),),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: Row(
                              children: [
                                Text('Private Room', style: TextStyle(fontSize: 13),),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 8),
                            child: Row(
                              children: [
                                Icon(Icons.location_on_outlined, size: 20, color: Colors.blueGrey,),
                                Text('300 Broadway, Albany, New York 1227', style: TextStyle(color: Colors.blueGrey),),
                                SizedBox(
                                  width: 30,
                                ),
                                Icon(Icons.send, color: Colors.blue,)
                              ],
                            ),
                          ),
                        ],
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                    ),
                  ),




                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    width: 350,
                    height: 240,
                    //color: Colors.grey,
                    child: Card(
                      elevation: 10,
                      child: Column(
                        children: [
                          Stack(
                            children: [
                              Center(
                                child: Container(
                                  height: 130,
                                  width: 334,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    image: DecorationImage(
                                      image: NetworkImage('https://cdn.britannica.com/96/115096-050-5AFDAF5D/Bellagio-Hotel-Casino-Las-Vegas.jpg'),
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                ),
                              ),
                              Center(
                                child: Padding(
                                  padding: const EdgeInsets.only(top: 105),
                                  child: Card(

                                    elevation: 0,
                                    child: Container(
                                      height: 40,
                                      width: 150,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(40),
                                      ),
                                      child: Center(child: Text('\$ 320/ Night', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.blue),)),
                                    ),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20.0),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: Row(
                              children: [
                                Row(
                                  children: [
                                    Text("American Royal", style: TextStyle(fontWeight: FontWeight.bold),),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: Row(
                              children: [
                                Text('Private Room', style: TextStyle(fontSize: 13),),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 8),
                            child: Row(
                              children: [
                                Icon(Icons.location_on_outlined, size: 20, color: Colors.blueGrey,),
                                Text('300 Broadway, Albany, New York 1227', style: TextStyle(color: Colors.blueGrey),),
                                SizedBox(
                                  width: 30,
                                ),
                                Icon(Icons.send, color: Colors.blue,)
                              ],
                            ),
                          ),
                        ],
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                    ),
                  ),



                  Padding(
                    padding: const EdgeInsets.only(left: 10, top: 20),
                    child: ElevatedButtonWidget(
                      buttonText: 'Accept',
                      buttonColor: AppColors.primaryColour,
                      onPressed: () {

                      },
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
