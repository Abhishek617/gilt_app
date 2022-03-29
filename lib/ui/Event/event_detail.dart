import 'package:flutter/material.dart';
import 'package:full_screen_image/full_screen_image.dart';
import 'package:guilt_app/constants/colors.dart';
import 'package:guilt_app/utils/device/device_utils.dart';
import 'package:guilt_app/widgets/rounded_button_with_icon.dart';

import '../../utils/routes/routes.dart';

class EventDetails extends StatefulWidget {
  const EventDetails({Key? key}) : super(key: key);

  @override
  State<EventDetails> createState() => _EventDetailsState();
}

class _EventDetailsState extends State<EventDetails> {
  @override
  Widget build(BuildContext context) {
   return Scaffold(
     floatingActionButton: FloatingActionButton.extended(
       onPressed: (){
         Routes.navigateToScreen(context, Routes.atendees);
       },

          icon: Icon(Icons.supervised_user_circle_rounded, color: Colors.grey,),
          label: Text('+20 Attendees', style: TextStyle(color: AppColors.primaryColour, fontSize: 12),),


         backgroundColor: Colors.white,
     ),
    floatingActionButtonLocation: FloatingActionButtonLocation.centerTop,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(DeviceUtils.getScaledHeight(context, 0.18)),
    child: AppBar(
      title: Text('         Event Details'),
      shadowColor: Colors.transparent,
        flexibleSpace:Column(
          children: [
            Padding(
                padding: EdgeInsets.only(
                    left: 25.0, top: 90.0, bottom: 5.0, right: 25.0),
                child: Icon(Icons.image,
                    size: 40,
                    color: Colors.white)),
        ],),
    ),
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
                padding: EdgeInsets.only(left: 0, top: 0, right: 00, bottom: 10),
                child: Column(
                  children: [
                    Row(children: [
                      Padding(
                        padding: EdgeInsets.only(
                            right: 10, bottom: 30, top: 40, left: 25),
                        child: Text('A Virtual Evening of \nSmooth Jazz ',
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 18,
                                fontWeight: FontWeight.w700)),
                      ),
                      Padding(
                          padding: EdgeInsets.only(
                              left: 110.0, top: 40.0, bottom: 30.0, right: 20.0),
                          child: Icon(Icons.message_rounded,
                              size: 20,
                              color: Theme.of(context).colorScheme.primary)),
                    ]),
                    Row(children: [
                      Padding(
                          padding: EdgeInsets.only(
                              left: 20.0, top: 0.0, bottom: 00.0, right: 5.0),
                          child: Icon(Icons.date_range_rounded,
                              size: 40,
                              color: Theme.of(context).colorScheme.primary)),
                      Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(
                                left: 0.0, top: 0.0, bottom: 00.0, right: 10.0),
                            child: Text(
                              '13 January, 2022',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                                left: 10.0, top: 5.0, bottom: 00.0, right: 00.0),
                            child: Text(
                              'Thursday, 2:00PM - 6:00PM',
                              style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ]),
                    Row(children: [
                      Padding(
                          padding: EdgeInsets.only(
                              left: 20.0, top: 15.0, bottom: 00.0, right: 5.0),
                          child: Icon(Icons.location_on,
                              size: 40,
                              color: Theme.of(context).colorScheme.primary)),
                      Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(
                                left: 9.0, top: 15.0, bottom: 00.0, right: 10.0),
                            child: Text(
                              'Gala Convention Center',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                                left: 00.0, top: 5.0, bottom: 00.0, right: 23.0),
                            child: Text(
                              '36, Guild Street London, UK',
                              style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ]),
                    Row(children: [
                      Padding(
                          padding: EdgeInsets.only(
                              left: 20.0, top: 15.0, bottom: 00.0, right: 5.0),
                          child: Icon(Icons.person_rounded,
                              size: 40,
                              color: Theme.of(context).colorScheme.primary)),
                      Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(
                                left: 0.0, top: 15.0, bottom: 00.0, right: 32.0),
                            child: Text(
                              'Michael Scott',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                                left: 10.0, top: 5.0, bottom: 00.0, right: 21.0),
                            child: Text(
                              'Dance Party (Organizer)',
                              style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ]),
                  ],
                )),
            Divider(
              color: Colors.black12,
              //color of divider
              height: 20,
              //height spacing of divider
              thickness: 1,
              //thickness of divier line
              indent: 20,
              //spacing at the start of divider
              endIndent: 20, //spacing at the end of divider
            ),
            Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(
                      left: 20.0, top: 5.0, bottom: 5.0, right: 215.0),
                  child: Text(
                    'About Event',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w900),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      left: 20.0, top: 5.0, bottom: 5.0, right: 20.0),
                  child: Text(
                    'age elle-même. Lavantage du Lorem Ipsum sur un texte générique comme Du texte.'
                    ' Du texte.est quil possède une distribution de lettres plus ou '
                    'moins normale, et en tout cas comparable avec celle du français standard',
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                  ),
                ),
              ],
            ),
            Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(
                      left: 20.0, top: 20.0, bottom: 5.0, right: 255.0),
                  child: Text(
                    'Photos',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w900),
                  ),
                ),
                Row(
                  children: [
                    FullScreenWidget(
                      child:Container(
                       child: Padding(
                          padding: EdgeInsets.only(
                              left: 20.0, top: 00.0, bottom: 10.0, right: 10.0),
                          child: Image.network(
                            'https://i.pinimg.com/474x/e7/0b/30/e70b309ec42e68dbc70972ec96f53839.jpg',
                            width: 210,
                            height: 200,
                          ),
                        ),
                        ),
                        ),
                        Column(
                          children: [
                            FullScreenWidget(child:
                            Container(
                              child: Padding(
                                padding: EdgeInsets.only(
                                    left: 0.0, top: 10.0, bottom: 10.0, right: 10.0),
                                child: Image.network(
                                  'https://i.pinimg.com/474x/e7/0b/30/e70b309ec42e68dbc70972ec96f53839.jpg',
                                  width: 100,
                                  height: 90,
                                ),
                              ),
                            ),
                            ),
                          FullScreenWidget(child:
                            Container(
                              child: Padding(
                                padding: EdgeInsets.only(
                                    left: 0.0, top: 10.0, bottom: 18.0, right: 10.0),
                                child: Image.network(
                                  'https://i.pinimg.com/474x/e7/0b/30/e70b309ec42e68dbc70972ec96f53839.jpg',
                                  width: 100,
                                  height: 90,
                                ),
                              ),
                            ),
                          ),
                          ],
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),

    );
  }
}
