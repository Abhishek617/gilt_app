import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:guilt_app/constants/colors.dart';
import 'package:guilt_app/models/Event/SearchEventResponseModel.dart';
import 'package:guilt_app/utils/Global_methods/GlobalStoreHandler.dart';
import 'package:guilt_app/utils/Global_methods/global.dart';
import 'package:guilt_app/utils/device/device_utils.dart';
import 'package:guilt_app/utils/routes/routes.dart';
import 'package:guilt_app/widgets/custom_scaffold.dart';
import 'package:guilt_app/widgets/rounded_button_widget.dart';
import 'package:intl/intl.dart';

import '../../data/repository.dart';
import '../../di/components/service_locator.dart';
import '../../models/Auth/commonModal.dart';
import '../../models/Event/accept_reject_event.dart';
import '../../stores/user/user_store.dart';

class MyEvent extends StatefulWidget {
  const MyEvent({Key? key}) : super(key: key);

  @override
  State<MyEvent> createState() => _MyEventState();
}

class _MyEventState extends State<MyEvent> {
  List<EventItem> eventList = [];
  final UserStore _userStore = UserStore(getIt<Repository>());
  var addData;
  var userId;
  @override
  initState() {
    GlobalMethods.showLoader();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await _userStore.getProfile();
      setState(() {
        addData = _userStore.Profile_data;
        userId =  addData?.user?.id == 0 ? "" : addData?.user?.id.toString();
        getMyEvents(int.parse(userId));
      });

      // setData(args);
    });

    GlobalMethods.hideLoader();
    super.initState();
  }
  deleteEvent(context, businessData, businessIndex) {
    FocusScope.of(context).unfocus();

    // set up the buttons
    Widget cancelButton = TextButton(
      child: Text("Yes"),
      onPressed: () {

        deleteBusinessRequest(businessData, businessIndex);
        Navigator.of(context).pop();
      },
    );
    Widget continueButton = TextButton(
      child: Text("No"),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Cancel Event"),
      content: Text("Are you sure?"),
      actions: [
        cancelButton,
        continueButton,
      ],
    );

    // show the dialog
    Future.delayed(Duration(milliseconds: 300)).then((value) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return alert;
        },
      );
    });
  }
  deleteBusinessRequest(EventItem businessData, businessIndex) {
    _userStore.cancelEvent(businessData.id!,
            (AcceptRejectEvent successMaster) {
          GlobalMethods.hideLoader();
          if (successMaster != null) {
            if(successMaster==true){
              getMyEvents(int.parse(userId));
            }else{
              getMyEvents(int.parse(userId));
              GlobalMethods.showSuccessMessage(
                        context, successMaster.message!, "Cancel Event" ?? "");
            }

            // if (successMaster.success != null && successMaster.success!) {
            //   getMyEvents(userId);
            //   GlobalMethods.showSuccessMessage(
            //       context, successMaster.message!, "Cancel Event" ?? "");
            // } else {
            //   getMyEvents(userId);
            //   GlobalMethods.showErrorMessage(
            //       context, successMaster.message!, "Cancel Event" ?? "");
            // }
          }
        }, (error) {
          GlobalMethods.hideLoader();
          print(error.toString());
        });
    // GlobalStoreHandler.postStore.deleteEvent(businessData.id).then((value) {
    //   CommonResponseModal res = CommonResponseModal.fromJson(value);
    //   if (res.success == true) {
    //     GlobalMethods.showSuccessMessage(
    //         context, res.message ?? 'Delete successfully.', 'Delete Event');
    //
    //     getMyEvents(userId);
    //   } else {
    //     GlobalMethods.showErrorMessage(
    //         context, res.message ?? 'Delete failed.', 'Delete Event');
    //   }
    // }).catchError((err) {
    //   GlobalMethods.showErrorMessage(
    //       context, err.message ?? 'Delete failed.', 'Delete Event');
    //   print(err);
    // });
  }

  Widget eventItemContainer(EventItem eventItem) {
    print('eventItem');
    print(eventItem);
    if (eventItem != null) {
      var startDate = eventItem.startDate != null
          ? DateFormat('dd MMMM yyyy  HH:mma')
          .format(DateTime.parse(eventItem.startDate!))
          : 'Start Date Not found';
      var endDate = eventItem.endDate != null
          ? DateFormat('dd MMMM yyyy  HH:mma')
          .format(DateTime.parse(eventItem.endDate!))
          : 'End Date not found';
      return GestureDetector(
        child: Container(
          width: DeviceUtils.getScaledWidth(context, 1.00),
          height: DeviceUtils.getScaledHeight(context, 0.139),
          padding: EdgeInsets.only(left: 10, top: 7, right: 10, bottom: 0),
          child: Card(
            child: Container(
              margin: EdgeInsets.all(5),
              color: Colors.white,
              alignment: Alignment.center,
              child: Row(
                children: [
                  Column(
                    children: [
                      Container(
                        width: 60,
                        height: 60,
                        child: Image.network(
                          eventItem.eventImages!.length > 0
                              ? eventItem.eventImages![0].file ??
                              'https://i.pinimg.com/474x/e7/0b/30/e70b309ec42e68dbc70972ec96f53839.jpg'
                              : 'https://i.pinimg.com/474x/e7/0b/30/e70b309ec42e68dbc70972ec96f53839.jpg',
                          fit: BoxFit.cover,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    width: 8,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(eventItem.name ?? 'No Name',
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 18,
                                fontWeight: FontWeight.w700)),
                        SizedBox(
                          height: 5,
                        ),
                        Text(startDate + ' to ' + endDate,
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.left,
                            style: TextStyle(
                                color: Colors.grey,
                                fontSize: 10,
                                fontWeight: FontWeight.w400)),
                        Expanded(
                          child: Row(
                            children: [
                              Padding(
                                  padding: EdgeInsets.only(
                                    top: 5.0,
                                  ),
                                  child: Icon(Icons.supervised_user_circle_rounded,
                                      size: 20,
                                      color:
                                      Theme.of(context).colorScheme.primary)),
                              Padding(
                                padding: EdgeInsets.only(
                                    left: 0.0, top: 5.0, bottom: 00.0, right: 00.0),
                                child: Text(
                                  (eventItem.eventAttendees!.length < 20
                                      ? eventItem.eventAttendees!.length
                                      .toString()
                                      : '+20') +
                                      ' Attendee(s)',
                                  style: TextStyle(
                                    fontSize: 10,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Padding(
                                  
                                    padding:
                                    EdgeInsets.only(top: 5, left: 90, right: 00),
                                    child: Container(
                                      padding: EdgeInsets.all(5.0),
                                      decoration: BoxDecoration(
                                        borderRadius:
                                        BorderRadius.all(Radius.circular(50)),
                                        color: AppColors.primaryColor,
                                        shape: BoxShape.rectangle,
                                      ),
                                      child: Text(
                                        eventItem.status!,
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 12),
                                      ),
                                    )),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  PopupMenuButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(15.0))),
                    offset: Offset(-22.0, 40.0),
                    icon: Icon(Icons.more_vert),
                    itemBuilder: (BuildContext context) => <PopupMenuEntry>[
                      PopupMenuItem(
                        onTap: () {
                          Future.delayed(
                              Duration.zero,
                                  () =>  Routes.navigateToScreenWithArgs(context, Routes.edit_event,eventItem.id)
                          );


                        },
                        height: 10,
                        padding: EdgeInsets.only(left: 30, top: 10),
                        child: Text(
                          'Edit',
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                      PopupMenuItem(
                        onTap: () {
                          deleteEvent(context, eventItem, eventItem.id);
                        },
                        height: 10,
                        padding: EdgeInsets.only(left: 30, top: 15, bottom: 10),
                        child: Text(
                          'Cancel',
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
        onTap: () {
          Routes.navigateToScreenWithArgs(
              context, Routes.event_details, eventItem.id);
          // Routes.navigateToScreenWithArgs(
          //     context, Routes.book_event_details, eventItem.id);
        },
      );
    } else {
      return Container();
    }
  }

  bool _isSearchBar = false;

  getMyEvents(int userId) {
    GlobalStoreHandler.postStore
        .getMyEvents(userId)
        .then((searchEventList) {
      print('searchEvent Response :');
      print(searchEventList);
      var response = SearchEventResponseModal.fromJson(searchEventList);
      setState(() {
        eventList = (response?.eventsList?.listData?.length == 0
            ? []
            : response?.eventsList?.listData)!;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldWrapper(
      isMenu: false,
      appBar: AppBar(
        shadowColor: Colors.transparent,
        //title: !_isSearchBar ? Text('Search Event') : _searchTextField(),
        title: Text('My Events'),
        centerTitle: true,

      ),
      child: eventList.length > 0
          ? SingleChildScrollView(
              child: Column(
                children:
                    eventList.map((evt) => eventItemContainer(evt)).toList(),
              ),
            )
          : Center(
              heightFactor: 12.0,
              child: Text(
                'No Event found',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              )),
    );
  }
}
