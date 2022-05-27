import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:guilt_app/constants/colors.dart';
import 'package:guilt_app/constants/dimens.dart';
import 'package:guilt_app/models/Auth/profile_modal.dart';
import 'package:guilt_app/utils/Global_methods/GlobalStoreHandler.dart';
import 'package:guilt_app/utils/device/device_utils.dart';
import 'package:guilt_app/widgets/custom_scaffold.dart';

class OrganizerProfile extends StatefulWidget {
  final userId;

  const OrganizerProfile({Key? key, this.userId}) : super(key: key);

  @override
  State<OrganizerProfile> createState() => _OrganizerProfileState(userId);
}

class _OrganizerProfileState extends State<OrganizerProfile> {
  int segmentedControlValue = 0;
  final int uID;

  _OrganizerProfileState(this.uID);

  User? user;

  @override
  initState() {
    getUserDetails();
    super.initState();
  }

  getUserDetails() {
    if (uID != null) {
      GlobalStoreHandler.userStore.getUserProfile(uID).then((value) {
        setState(() {
          user = value.user;
        });
      });
    }
  }

  Widget segmentedControl() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 5.0),
      child: Container(
        child: CupertinoSlidingSegmentedControl(
            padding: EdgeInsets.all(5),
            thumbColor: AppColors.primaryColor,
            groupValue: segmentedControlValue,
            children: <int, Widget>{
              0: Padding(
                padding: EdgeInsets.all(8),
                child: Text(
                  'About',
                  style: TextStyle(
                      fontSize: 18,
                      color: this.segmentedControlValue == 0
                          ? Colors.white
                          : Colors.black),
                ),
              ),
              1: Padding(
                padding: EdgeInsets.all(8),
                child: Text(
                  'Event',
                  style: TextStyle(
                      fontSize: 18,
                      color: this.segmentedControlValue == 1
                          ? Colors.white
                          : Colors.black),
                ),
              ),
            },
            onValueChanged: (value) {
              setState(() {
                segmentedControlValue = value as int;
              });
            }),
      ),
    );
  }

  Widget box(String title, Color backgroundcolor, Image demo) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.all(5),
          child: Card(
            shadowColor: AppColors.grayTextColor,
            elevation: 2.5,
            child: Container(
              margin: EdgeInsets.all(5),
              width: DeviceUtils.getScaledWidth(context, 0.90),
              color: backgroundcolor,
              alignment: Alignment.center,
              child: Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child: Image.network(
                      'https://i.pinimg.com/474x/e7/0b/30/e70b309ec42e68dbc70972ec96f53839.jpg',
                      width: DeviceUtils.getScaledWidth(context, 0.20),
                      height: DeviceUtils.getScaledWidth(context, 0.20),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(
                          left: Dimens.horizontal_padding),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('13 JAN 2022, 2:00PM - Upcoming',
                              style: TextStyle(
                                  color: AppColors.primaryColor,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400)),
                          Text('A Virtual Evening of \nSmooth Jazz ',
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.w700)),
                          Row(
                            children: [
                              Icon(
                                Icons.location_on,
                                size: 12,
                                color: AppColors.grayTextColor,
                              ),
                              Text(
                                '36, guild street, london, uk',
                                style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                    color: AppColors.grayTextColor),
                              ),
                            ],
                          ),
                        ],
                      ),
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

  Widget about() => Column(
        children: [Text('No Description Available')],
      );

  List<String> item = [' b', 'c ', ' d', 'd'];

  @override
  Widget build(BuildContext context) {
    return ScaffoldWrapper(
      isMenu: false,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back_ios_rounded,
            size: 17,
          ),
        ),
        shadowColor: Colors.transparent,
        title: Text('Organizer Profile'),
        centerTitle: true,
      ),
      child: Column(children: [
        Column(
          children: [
            SizedBox(
              height: 30,
              width: 10,
            ),
            Align(
              alignment: Alignment.center,
              child: Stack(
                children: [
                  Container(
                    child: Image.network(
                      'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSnngxCpo8jS7WE_uNWmlP4bME_IZkXWKYMzhM2Qi1JE_J-l_4SZQiGclMuNr4acfenazo&usqp=CAU',
                      width: 80,
                      height: 80,
                      fit: BoxFit.cover,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 10,
              width: 10,
            ),
            Text(
              'David Silbia',
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w700,
              ),
            ),
            SizedBox(
              height: 5,
              width: 10,
            ),
            Text(
              'david.silbia@gmail.com',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(
              height: 5,
              width: 10,
            ),
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
          ],
        ),
        Column(children: [
          Container(
            padding: EdgeInsets.symmetric(
                horizontal: Dimens.horizontal_padding,
                vertical: Dimens.vertical_padding + 5),
            child: Column(
              children: [
                Center(
                  child: segmentedControl(),
                ),
                Container(
                  height: DeviceUtils.getScaledHeight(context, 0.45),
                  child: segmentedControlValue == 0
                      ? about()
                      : ListView(
                          scrollDirection: Axis.vertical,
                          children: item.map((item1) {
                            return box(
                              item1,
                              Colors.white,
                              Image.network(
                                  'https://th.bing.com/th/id/R.fa0ca630a6a3de8e33e03a009e406acd?rik=UOMXfynJ2FEiVw&riu=http%3a%2f%2fwww.clker.com%2fcliparts%2ff%2fa%2f0%2fc%2f1434020125875430376profile.png&ehk=73x7A%2fh2HgYZLT1q7b6vWMXl86IjYeDhub59EZ8hF14%3d&risl=&pid=ImgRaw&r=0'),
                            );
                          }).toList(),
                        ),
                ),
              ],
            ),
          ),
        ]),
      ]),
    );
  }
}
