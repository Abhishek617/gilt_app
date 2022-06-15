import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:guilt_app/constants/colors.dart';
import 'package:guilt_app/constants/dimens.dart';
import 'package:guilt_app/models/Auth/OrganizerProfileResponseModel.dart';
import 'package:guilt_app/models/Auth/profile_modal.dart';
import 'package:guilt_app/models/Event/MyBookedEventModel.dart';
import 'package:guilt_app/models/Event/SearchEventResponseModel.dart';
import 'package:guilt_app/utils/Global_methods/GlobalStoreHandler.dart';
import 'package:guilt_app/utils/Global_methods/global.dart';
import 'package:guilt_app/utils/device/device_utils.dart';
import 'package:guilt_app/utils/routes/routes.dart';
import 'package:guilt_app/widgets/custom_body_wrapper.dart';
import 'package:guilt_app/widgets/custom_scaffold.dart';

class OrganizerProfile extends StatefulWidget {

  const OrganizerProfile({Key? key}) : super(key: key);

  @override
  State<OrganizerProfile> createState() => _OrganizerProfileState();
}

class _OrganizerProfileState extends State<OrganizerProfile> {
  int segmentedControlValue = 0;
  List<EventItem> eventList = [];

  OrganizerUser? user;
  int? uID;

  @override
  initState() {
    getUserDetails();
    super.initState();
    Future.delayed(Duration.zero,(){
      var args = ModalRoute.of(context)!.settings.arguments as int;
      setState(() {
        uID = args;
        getUserDetails();
      });
    });
  }

  getUserDetails() {
    if (uID != null) {
      GlobalStoreHandler.userStore.getUserProfile(uID).then((value) {
        setState(() {
          value = OrganizerProfileResponseModel.fromJson(value);
          user = value.user;
          getUserEventList();
        });
      });
    }
  }

  getUserEventList() {
    GlobalStoreHandler.postStore.getUserEvent(user?.id).then((value) {
      if (value['success'] == true) {
        setState(() {
          MyBookedEventModel res =
             MyBookedEventModel.fromJson(value);
          eventList = (res.events!.listData!.length! > 0
              ? res.events!.listData!
              : []);
        });
      }
    }).catchError((err) {});
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

  Widget eventContainer(EventItem event) {
    return GestureDetector(
      onTap: (){
        if (event.id != null)
          Routes.navigateToScreenWithArgs(
              context, Routes.event_details, event.id);
      },
      child: Card(
        shadowColor: AppColors.grayTextColor,
        elevation: 2.5,
        child: Container(
          margin: EdgeInsets.all(5),
          width: DeviceUtils.getScaledWidth(context, 0.90),
          color: Colors.white,
          alignment: Alignment.center,
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: Image.network(
                  event!.eventImages!.length! > 0 ? event!.eventImages![0].file ?? '' :
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
                      Text(event?.startDate ?? 'Upcoming Event',
                          style: TextStyle(
                              color: AppColors.primaryColor,
                              fontSize: 12,
                              fontWeight: FontWeight.w400)),
                      Text(event?.name ?? 'No name',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w700)),
                      SizedBox(
                        height: 5,
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.location_on,
                            size: 12,
                            color: AppColors.grayTextColor,
                          ),

                          Flexible(
                            child: Text(
                              event?.location ?? 'No Address',
                              style: TextStyle(
                                overflow: TextOverflow.ellipsis,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                  color: AppColors.grayTextColor),
                            ),
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
    );
  }

  Widget about() => Column(
        children: [Text(user?.aboutme ?? 'No Description Available')],
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
      body: CustomBodyWrapper(
        child: SingleChildScrollView(
          child: Column(children: [
            Column(
              children: [
                SizedBox(
                  height: 30,
                ),
                Align(
                  alignment: Alignment.center,
                  child: Stack(
                    children: [
                      Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                                color: AppColors.primaryColor, width: 2),
                            borderRadius: const BorderRadius.all(
                              Radius.circular(100),
                            ),
                          ),
                          child: ClipRRect(
                              borderRadius: BorderRadius.circular(100.0),
                              child: Image.network(
                                user?.profile ??
                                    'https://th.bing.com/th/id/R.fa0ca630a6a3de8e33e03a009e406acd?rik=UOMXfynJ2FEiVw&riu=http%3a%2f%2fwww.clker.com%2fcliparts%2ff%2fa%2f0%2fc%2f1434020125875430376profile.png&ehk=73x7A%2fh2HgYZLT1q7b6vWMXl86IjYeDhub59EZ8hF14%3d&risl=&pid=ImgRaw&r=0',
                                width:
                                    DeviceUtils.getScaledWidth(context, 0.30),
                                height:
                                    DeviceUtils.getScaledWidth(context, 0.30),
                                fit: BoxFit.contain,
                              )))
                    ],
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  ((user?.firstname ?? 'No') +
                      ' ' +
                      (user?.lastname ?? 'Name')),
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  (user?.email ?? 'No Email'),
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(
                  height: 5,
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
            Container(
              padding: EdgeInsets.symmetric(
                  horizontal: Dimens.horizontal_padding,
                  vertical: Dimens.vertical_padding),
              child: Column(
                children: [
                  Center(
                    child: segmentedControl(),
                  ),
                  Container(
                    child: segmentedControlValue == 0
                        ? about()
                        : Container(
                            height: DeviceUtils.getScaledHeight(context, 0.35),
                            child: eventList.length > 0 ? ListView(
                              scrollDirection: Axis.vertical,
                              children: eventList
                                  .map((item) => eventContainer(item))
                                  .toList(),
                            ) : Center(child: Text('No Events Added'),),
                          ),
                  ),
                ],
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
