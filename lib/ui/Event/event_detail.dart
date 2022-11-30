import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// import 'package:full_screen_image/full_screen_image.dart';
import 'package:guilt_app/constants/colors.dart';
import 'package:guilt_app/data/repository.dart';
import 'package:guilt_app/di/components/service_locator.dart';
import 'package:guilt_app/models/Event/EventDetailResponseModel.dart';
import 'package:guilt_app/models/PageModals/notification_list_model.dart';
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

    _userStore.Event_Detail(args, (value) {
      print(value);
      setState(() {
        contentData = EventDetailsResponseModel.fromJson(value);
        print('eventview');
      });
    }, (error) {
      print(error.toString());
    });
    super.didChangeDependencies();
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
                        padding: EdgeInsets.only(top: 16.0),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(contentData?.event?.name ?? '',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w700)),
                              IconButton(
                                onPressed: () {
                                  // TODO: Init Group Chat
                                },
                                icon: Icon(Icons.message_rounded,
                                    size: 20,
                                    color:
                                        Theme.of(context).colorScheme.primary),
                              ),
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
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                ( DateFormat.yMMMd().format(DateTime.parse(contentData?.event?.startDate.toString() ?? ''))) + ' - ' + (contentData?.event?.endDate ?? ''),
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
                        Column(
                          children: [
                            Text(
                              'Gala Convention Center',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Text(
                              '36, Guild Street London, UK',
                              style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ]),
                      Row(children: [
                        Icon(Icons.person_rounded,
                            size: 40,
                            color: Theme.of(context).colorScheme.primary),
                        Column(
                          children: [
                            Text(
                              (contentData?.event?.organizer?.firstname ?? '') +
                                  ' ' +
                                  (contentData?.event?.organizer?.lastname ??
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
                      ]),
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
                    children: [
                      Padding(
                        padding: EdgeInsets.only(
                            left: 20.0, top: 5.0, bottom: 5.0, right: 215.0),
                        child: Text(
                          'About Event',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w900),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            left: 20.0, top: 5.0, bottom: 5.0, right: 20.0),
                        child: Text(
                          'age elle-même. Lavantage du Lorem Ipsum sur un texte générique comme Du texte.'
                          ' Du texte.est quil possède une distribution de lettres plus ou '
                          'moins normale, et en tout cas comparable avec celle du français standard',
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
                            left: 20.0, top: 20.0, bottom: 5.0, right: 255.0),
                        child: Text(
                          'Photos',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w900),
                        ),
                      ),
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

  @override
  Widget build(BuildContext context) {
    args = ModalRoute.of(context)!.settings.arguments as int;
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Routes.navigateToScreen(context, Routes.atendees);
        },
        icon: Icon(
          Icons.supervised_user_circle_rounded,
          color: Colors.grey,
        ),
        label: Text(
          '+20 Attendees',
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
