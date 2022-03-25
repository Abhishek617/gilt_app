import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:guilt_app/constants/colors.dart';

class Event extends StatefulWidget {
  const Event({Key? key}) : super(key: key);

  @override
  State<Event> createState() => _EventState();
}

class _EventState extends State<Event> {
  int segmentedControlValue = 0;
  Widget segmentedControl() {
    return Padding(padding: EdgeInsets.only(left: 40, top: 10, bottom: 5),
      child: Container(
        width: 250,
        child: CupertinoSlidingSegmentedControl(
            groupValue: segmentedControlValue,
            backgroundColor: AppColors.primaryColour,
            children: <int, Widget>{
              0: Text('Upcomming'),
              1: Text('Past Event')
            },
            onValueChanged: (value) {
              setState(() {
                segmentedControlValue = value as int;
              });
            }
        ),
      ),
    );
  }
  Widget box(String title, Color backgroundcolor, Image demo) {
    return  Column(children:[
      Padding(
        padding: EdgeInsets.only(left: 0, top: 0, right: 00, bottom: 10),
        child: Card(
          child: Container(
            margin: EdgeInsets.all(5),
            width: 370,
            color: backgroundcolor,
            alignment: Alignment.center,
            child: Row(
              children: [
                Column(children: [
                   Image.network(
                  'https://i.pinimg.com/474x/e7/0b/30/e70b309ec42e68dbc70972ec96f53839.jpg',
                  width: 80,
                  height: 80,
              ),
                ],
                ),
                Padding(padding: EdgeInsets.only(left: 15),
                  child: Column(
                    children: [

                      Padding(padding: EdgeInsets.only(right: 45, bottom: 3, top: 3),
                        child: Text('13 JAN 2022, 2:00PM', textAlign: TextAlign.left,
                          style: TextStyle(
                              color: Colors.blue,
                              fontSize: 12,
                              fontWeight: FontWeight.w400)
                        ),
                      ),


                         Text('A Virtual Evening of \nSmooth Jazz ',
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 18,
                                fontWeight: FontWeight.w700)),


                          Row(
                            children: [
                              Padding(
                                  padding: EdgeInsets.only(
                                      left: 00.0, top: 3.0, bottom: 00.0, right: 0.0),
                                  child: Icon(Icons.location_on,
                                      size: 20,
                                      color: Theme.of(context).colorScheme.primary)),
                              Padding(
                                padding: EdgeInsets.only(
                                    left: 0.0, top: 3.0, bottom: 00.0, right: 40.0),
                                child: Text(
                                  '36, guild street, london, uk',
                                  style: TextStyle(
                                    fontSize: 10,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ],
                          ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    ],
    );
  }
  Widget pastbox(String title, Color backgroundcolor, Image demo) {
    return  Column(children:[
      Padding(
        padding: EdgeInsets.only(left: 0, top: 0, right: 00, bottom: 10),
        child: Card(
          child: Container(
            margin: EdgeInsets.all(5),
            width: 370,
            color: backgroundcolor,
            alignment: Alignment.center,
            child: Row(
              children: [
                Column(children: [
                  Image.network(
                    'https://i.pinimg.com/474x/e7/0b/30/e70b309ec42e68dbc70972ec96f53839.jpg',
                    width: 80,
                    height: 80,
                  ),
                ],
                ),
                Padding(padding: EdgeInsets.only(left: 15),
                  child: Column(
                    children: [

                      Padding(padding: EdgeInsets.only(right: 45, bottom: 3, top: 3),
                        child: Text('13 JAN 2022, 2:00PM', textAlign: TextAlign.left,
                            style: TextStyle(
                                color: Colors.blue,
                                fontSize: 12,
                                fontWeight: FontWeight.w400)
                        ),
                      ),


                      Text('A Virtual Evening of \nSmooth Jazz ',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 18,
                              fontWeight: FontWeight.w700)),


                      Row(
                        children: [
                          Padding(
                              padding: EdgeInsets.only(
                                  left: 00.0, top: 3.0, bottom: 00.0, right: 0.0),
                              child: Icon(Icons.location_on,
                                  size: 20,
                                  color: Theme.of(context).colorScheme.primary)),
                          Padding(
                            padding: EdgeInsets.only(
                                left: 0.0, top: 3.0, bottom: 00.0, right: 40.0),
                            child: Text(
                              '36, guild street, london, uk',
                              style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    ],
    );
  }
  List<String> item = [' b', 'c ', ' d', ' d', 'd '];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
        shadowColor: Colors.transparent,
        title: Text('EVENT'),
        ),
      backgroundColor: Colors.white,
      body: Container(

        padding: EdgeInsets.only(
            left: 15.0, top: 5.0, bottom: 5.0, right: 15.0),

        child: Column(children: [
          Row(children: [
            segmentedControl(),
          ],
          ),

           Column(
            children: [
              Container(
                  height: 600,
                  child: ListView(
                    scrollDirection: Axis.vertical,
                    children: item.map((iteml) {

                      return segmentedControlValue==1 ?
                      box(
                         iteml,
                          Colors.white,
                          Image.network(
                              'https://th.bing.com/th/id/R.fa0ca630a6a3de8e33e03a009e406acd?rik=UOMXfynJ2FEiVw&riu=http%3a%2f%2fwww.clker.com%2fcliparts%2ff%2fa%2f0%2fc%2f1434020125875430376profile.png&ehk=73x7A%2fh2HgYZLT1q7b6vWMXl86IjYeDhub59EZ8hF14%3d&risl=&pid=ImgRaw&r=0'))
                          : pastbox(
                          iteml,
                          Colors.white,
                          Image.network(
                              'https://th.bing.com/th/id/R.fa0ca630a6a3de8e33e03a009e406acd?rik=UOMXfynJ2FEiVw&riu=http%3a%2f%2fwww.clker.com%2fcliparts%2ff%2fa%2f0%2fc%2f1434020125875430376profile.png&ehk=73x7A%2fh2HgYZLT1q7b6vWMXl86IjYeDhub59EZ8hF14%3d&risl=&pid=ImgRaw&r=0'));
                    }).toList(),
                  ),
              ),
            ],
          ),
      ],
        ),
      ),
    );
  }
}
