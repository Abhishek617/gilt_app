import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

// import 'package:full_screen_image/full_screen_image.dart';
import 'package:guilt_app/constants/colors.dart';
import 'package:guilt_app/data/repository.dart';
import 'package:guilt_app/di/components/service_locator.dart';
import 'package:guilt_app/models/Event/EventDetailResponseModel.dart';
import 'package:guilt_app/models/PageModals/notification_list_model.dart';
import 'package:guilt_app/utils/Global_methods/GlobalSocket.dart';
import 'package:guilt_app/utils/device/device_utils.dart';
import 'package:guilt_app/widgets/rounded_button_with_icon.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../stores/user/user_store.dart';
import '../../utils/Global_methods/global.dart';
import '../../utils/routes/routes.dart';

class EventDetails extends StatefulWidget {
  const EventDetails({Key? key}) : super(key: key);

  @override
  State<EventDetails> createState() => _EventDetailsState();
}

class _EventDetailsState extends State<EventDetails> {
  final UserStore _userStore = UserStore(getIt<Repository>());
  EventDetailsResponseModel? contentData;
  var args;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    args = ModalRoute.of(context)!.settings.arguments;
    getDetails(args);
    super.didChangeDependencies();
  }

  Widget getImageContainer(EventImages photo) {
    return Container(
        height: 100,
        margin: EdgeInsets.only(right: 10, left: 10, top: 10),
        child: Image.network(photo.file.toString()));
  }

  getDetails(args) {
    GlobalMethods.showLoader();
    _userStore.Event_Detail(args, (value) {
      print(value);
      setState(() {
        contentData = EventDetailsResponseModel.fromJson(value);
        print('eventview');
      });
      GlobalMethods.hideLoader();
    }, (error) {
      GlobalMethods.hideLoader();
      print(error.toString());
    });
  }

  Widget getEventData(eID) {
    return contentData != null
        ? SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Column(
                    children: [
                      Container(
                        padding: EdgeInsets.only(top: 25.0),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(contentData?.event?.name ?? '',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w700)),
                              contentData?.event?.isUserAtendee == true
                                  ? IconButton(
                                      onPressed: () {
                                        // TODO: Init Group Chat
                                        GlobalMethods.showLoader();
                                        G.socketUtils
                                            .emitJoinEventChat(contentData!);
                                        GlobalMethods.hideLoader();
                                        Routes.navigateToScreen(
                                            context, Routes.event_chat);
                                      },
                                      icon: Icon(Icons.message_rounded,
                                          size: 20,
                                          color: Theme.of(context)
                                              .colorScheme
                                              .primary),
                                    )
                                  : Container(),
                            ]),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(children: [
                        Icon(Icons.date_range_rounded,
                            size: 40,
                            color: Theme.of(context).colorScheme.primary),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                (DateFormat.yMMMd().format(DateTime.parse(
                                        contentData?.event?.startDate
                                                .toString() ??
                                            ''))) +
                                    (contentData!.event!.endDate != null
                                        ? ' - ' +
                                            (DateFormat.yMMMd().format(
                                              DateTime.parse(contentData!
                                                  .event!.endDate
                                                  .toString()),
                                            ))
                                        : ''),
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              Text(
                                'Thursday, 2:00PM - 6:00PM',
                                style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ]),
                      Row(children: [
                        Icon(Icons.location_on,
                            size: 40,
                            color: Theme.of(context).colorScheme.primary),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                contentData?.event?.category ??
                                    'No Category added',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              Text(
                                contentData?.event?.location ??
                                    'No Address added',
                                style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ]),
                      GestureDetector(
                        onTap: () {
                          Routes.navigateToScreenWithArgs(
                              context,
                              Routes.organizerprof,
                              contentData?.event?.organizer?.id);
                        },
                        child: Row(children: [
                          Icon(Icons.person_rounded,
                              size: 40,
                              color: Theme.of(context).colorScheme.primary),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  (contentData?.event?.organizer?.firstname ??
                                          '') +
                                      ' ' +
                                      (contentData
                                              ?.event?.organizer?.lastname ??
                                          ''),
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                Text(
                                  '(Organizer)',
                                  style: TextStyle(
                                    fontSize: 10,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ]),
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
                    indent: 20,
                    //spacing at the start of divider
                    endIndent: 20, //spacing at the end of divider
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(
                            left: 0.0, top: 5.0, bottom: 5.0, right: 215.0),
                        child: Text(
                          'About Event',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w900),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            left: 0.0, top: 5.0, bottom: 5.0, right: 20.0),
                        child: Text(
                          (contentData?.event?.description ??
                              'No description added'),
                          style: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.w500),
                        ),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(
                            left: 0.0, top: 20.0, bottom: 5.0, right: 255.0),
                        child: Text(
                          'Photos',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w900),
                        ),
                      ),
                      contentData?.event?.eventImages?.length == 0
                          ? Padding(
                              padding: EdgeInsets.only(
                                  left: 0.0,
                                  top: 5.0,
                                  bottom: 5.0,
                                  right: 20.0),
                              child: Text(
                                'No any photos added',
                                style: TextStyle(
                                    fontSize: 14, fontWeight: FontWeight.w500),
                              ),
                            )
                          : Row(
                              children: contentData!.event!.eventImages!
                                  .map((e) => getImageContainer(e))
                                  .toList()),
                      // Row(
                      //   children: [
                      //     FullScreenWidget(
                      //       child:Container(
                      //        child: Padding(
                      //           padding: EdgeInsets.only(
                      //               left: 20.0, top: 00.0, bottom: 10.0, right: 10.0),
                      //           child: Image.network(
                      //             'https://i.pinimg.com/474x/e7/0b/30/e70b309ec42e68dbc70972ec96f53839.jpg',
                      //             width: 210,
                      //             height: 200,
                      //           ),
                      //         ),
                      //         ),
                      //         ),
                      //         Column(
                      //           children: [
                      //             FullScreenWidget(child:
                      //             Container(
                      //               child: Padding(
                      //                 padding: EdgeInsets.only(
                      //                     left: 0.0, top: 10.0, bottom: 10.0, right: 10.0),
                      //                 child: Image.network(
                      //                   'https://i.pinimg.com/474x/e7/0b/30/e70b309ec42e68dbc70972ec96f53839.jpg',
                      //                   width: 100,
                      //                   height: 90,
                      //                 ),
                      //               ),
                      //             ),
                      //             ),
                      //           FullScreenWidget(child:
                      //             Container(
                      //               child: Padding(
                      //                 padding: EdgeInsets.only(
                      //                     left: 0.0, top: 10.0, bottom: 18.0, right: 10.0),
                      //                 child: Image.network(
                      //                   'https://i.pinimg.com/474x/e7/0b/30/e70b309ec42e68dbc70972ec96f53839.jpg',
                      //                   width: 100,
                      //                   height: 90,
                      //                 ),
                      //               ),
                      //             ),
                      //           ),
                      //           ],
                      //     ),
                      //   ],
                      // ),
                    ],
                  ),
                ],
              ),
            ),
          )
        : Center(child: Text('No Details found.'));
  }

  Widget setupAlertDialoadContainer() {
    print(contentData);
    return Container(
      height: 300.0, // Change as per your requirement
      width: 300.0, // Change as per your requirement
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: contentData?.event?.eventAttendees?.length,
        itemBuilder: (BuildContext context, int index) {
          return getContactTile(contentData?.event?.eventAttendees?[index]);
        },
      ),
    );
  }

  getContactTile(user) {
    print('user');
    print(user);
    return Container(
      margin: EdgeInsets.only(bottom: 10),
      child: Row(
        children: [
          Container(
            child: CircleAvatar(
              backgroundColor: AppColors.primaryColor,
              child: Icon(
                Icons.person,
                color: Colors.white,
              ),
            ),
          ),
          SizedBox(
            width: 10,
          ),
          Text(
            user?.admin?.firstname! +
                ' ' +
                user?.admin?.lastname! +
                '\n' +
                user?.admin?.phone!,
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: Text('Attendees'),
                  content: setupAlertDialoadContainer(),
                );
              });

          // Routes.navigateToScreenWithArgs(
          //     context, Routes.atendees, jsonEncode(contentData));
        },
        icon: Icon(
          Icons.supervised_user_circle_rounded,
          color: Colors.grey,
        ),
        label: Text(
          ((contentData?.event?.eventAttendees?.length != 0)
                  ? contentData?.event?.eventAttendees?.length.toString() ?? '1'
                  : contentData?.event?.eventAttendees?.length.toString() ??
                      '1') +
              ' Attendees',
          style: TextStyle(color: AppColors.primaryColor, fontSize: 12),
        ),
        backgroundColor: Colors.white,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerTop,
      appBar: PreferredSize(
        preferredSize:
            Size.fromHeight(DeviceUtils.getScaledHeight(context, 0.18)),
        child: AppBar(
          title: Text('Event Details'),
          centerTitle: true,
          shadowColor: Colors.transparent,
          flexibleSpace: Column(
            children: [
              Padding(
                  padding: EdgeInsets.only(
                      left: 25.0, top: 90.0, bottom: 5.0, right: 25.0),
                  child: Icon(Icons.image, size: 40, color: Colors.white)),
            ],
          ),
        ),
      ),
      backgroundColor: Colors.white,
      body: getEventData(args),
    );
  }
}
