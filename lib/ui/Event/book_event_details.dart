import 'package:flutter/material.dart';
import 'package:guilt_app/constants/colors.dart';
import 'package:guilt_app/widgets/custom_scaffold.dart';

import '../../utils/routes/routes.dart';

class BookEventDetails extends StatefulWidget {
  const BookEventDetails({Key? key}) : super(key: key);

  @override
  State<BookEventDetails> createState() => _BookEventDetailsState();
}

class _BookEventDetailsState extends State<BookEventDetails> {
  Event_details() => Column(
        children: [
          Align(
            alignment: Alignment.center,
            child: Stack(
              children: [
                Container(
                  padding: const EdgeInsets.only(
                      left: 10.0, top: 30.0, bottom: 00.0, right: 5.0),
                  child: Image.network(
                    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSnngxCpo8jS7WE_uNWmlP4bME_IZkXWKYMzhM2Qi1JE_J-l_4SZQiGclMuNr4acfenazo&usqp=CAU',
                    width: 100,
                    height: 100,
                    fit: BoxFit.cover,
                  ),
                ),
              ],
            ),
          ),
          Text('Holiday Inn Express Albany',
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.w700)),
          Row(
            children: [
              Padding(
                  padding: EdgeInsets.only(
                      left: 90.0, top: 3.0, bottom: 00.0, right: 0.0),
                  child: Icon(Icons.location_on,
                      size: 20, color: Theme.of(context).colorScheme.primary)),
              Padding(
                padding: EdgeInsets.only(
                    left: 5.0, top: 3.0, bottom: 00.0, right: 40.0),
                child: Text(
                  '36, guild street, london, uk',
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
          Row(
            children: [
              Padding(
                  padding: EdgeInsets.only(
                      left: 75.0, top: 20.0, bottom: 00.0, right: 0.0),
                  child: Icon(Icons.check_circle,
                      size: 20, color: Theme.of(context).colorScheme.primary)),
              Padding(
                padding: EdgeInsets.only(
                    left: 5.0, top: 20.0, bottom: 00.0, right: 40.0),
                child: Text(
                  'Success! Your Stay is Confirmed',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ),
          Row(
            children: [
              Padding(
                padding: EdgeInsets.only(
                    left: 110.0, top: 7.0, bottom: 00.0, right: 40.0),
                child: Text(
                  'Booking Id: 345687773',
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
          Divider(
            color: Colors.black12,
            //color of divider
            height: 20,
            //height spacing of divider
            thickness: 1,
            //thickness of divier line
            indent: 40,
            //spacing at the start of divider
            endIndent: 40, //spacing at the end of divider
          ),
          Column(
            children: [
              Text('A Virtual Evening of Smooth Jazz',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.w700)),
              Padding(
                padding: EdgeInsets.only(right: 25, bottom: 10, top: 10),
                child: Text('13 January 2022 to 25 January 2022',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                        color: Colors.grey,
                        fontSize: 12,
                        fontWeight: FontWeight.w500)),
              ),
            ],
          ),
          Row(children: [
            Padding(
                padding: EdgeInsets.only(
                    left: 10.0, top: 20.0, bottom: 00.0, right: 0.0),
                child: Icon(Icons.meeting_room,
                    size: 20, color: Theme.of(context).colorScheme.primary)),
            Padding(
              padding: EdgeInsets.only(
                  left: 5.0, top: 20.0, bottom: 00.0, right: 10.0),
              child: Text(
                'Private Room',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            Padding(
                padding: EdgeInsets.only(
                    left: 00.0, top: 20.0, bottom: 00.0, right: 0.0),
                child: Icon(Icons.supervised_user_circle_rounded,
                    size: 20, color: Theme.of(context).colorScheme.primary)),
            Padding(
              padding: EdgeInsets.only(
                  left: 5.0, top: 20.0, bottom: 00.0, right: 40.0),
              child: Text(
                '+20 Attendees',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                  left: 5.0, top: 20.0, bottom: 00.0, right: 10.0),
              child: Text(
                'R15,625',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ),
          ],),
          Row(children: [
            Padding(
                padding: EdgeInsets.only(left: 10, top:20, right: 00, bottom: 20),
                child: Container(
                  height: 30,
                  width: 111,
                  child: ElevatedButton(
                    onPressed: () =>{  Routes.navigateToScreen(context, Routes.map)},
                    child:Row(children: [
                      Icon(Icons.directions),
                      Text(' Direction ', style: TextStyle(
                          color: Colors.white, fontSize: 12),),
                    ],
                    ),

                    style: ButtonStyle(
                        backgroundColor:
                        MaterialStateColor.resolveWith(
                                (states) =>
                            AppColors.primaryColor),
                        shape: MaterialStateProperty.all<
                            RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius:
                              BorderRadius.circular(90.0),
                            ))),
                  ),
                )),
            Padding(
                padding: EdgeInsets.only(left: 10, top:20, right: 00, bottom: 20),
                child: Container(
                  height: 30,
                  width: 115,
                  child: ElevatedButton(
                    onPressed: () {
                    },
                    child:Row(children: [
                      Icon(Icons.call),
                      Text(' Call Hotel ', style: TextStyle(
                          color: Colors.white, fontSize: 12),),
                    ],
                    ),

                    style: ButtonStyle(
                        backgroundColor:
                        MaterialStateColor.resolveWith(
                                (states) =>
                            AppColors.primaryColor),
                        shape: MaterialStateProperty.all<
                            RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius:
                              BorderRadius.circular(90.0),
                            ))),
                  ),
                )),
            Padding(
                padding: EdgeInsets.only(left: 10, top:20, right: 00, bottom: 20),
                child: Container(
                  height: 30,
                  width: 80,
                  child: ElevatedButton(
                    onPressed: () {
                    },

                      child: Text(' Cancel ', style: TextStyle(
                          color: Colors.white, fontSize: 12),),


                    style: ButtonStyle(
                        backgroundColor:
                        MaterialStateColor.resolveWith(
                                (states) =>
                            Colors.red),
                        shape: MaterialStateProperty.all<
                            RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius:
                              BorderRadius.circular(90.0),
                            ))),
                  ),
                )),
          ],)
        ],
      );

  @override
  Widget build(BuildContext context) {
    return ScaffoldWrapper(
      isMenu: false,
      appBar: AppBar(
        shadowColor: Colors.transparent,
        title: Row(
          children: [
            Text('Book Event Details'),
          ],
        ),
      ),

        child: Column(children: [
          Container(
            child: Event_details(),
          ),
        ]),

    );
  }
}
