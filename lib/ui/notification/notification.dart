import 'package:flutter/material.dart';
import 'package:guilt_app/data/repository.dart';
import 'package:guilt_app/di/components/service_locator.dart';
import 'package:guilt_app/models/Event/accept_reject_event.dart';
import 'package:guilt_app/models/PageModals/notification_list_model.dart';
import 'package:guilt_app/stores/user/user_store.dart';
import 'package:guilt_app/utils/Global_methods/global.dart';
import 'package:guilt_app/utils/device/device_utils.dart';
import 'package:guilt_app/utils/routes/routes.dart';
import 'package:intl/intl.dart';

class Notifications extends StatefulWidget {
  @override
  State<Notifications> createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {
  final UserStore _userStore = UserStore(getIt<Repository>());
  List<NotificationItem> contentData = [];

  @override
  void didChangeDependencies() {
    getNotificationList();
    super.didChangeDependencies();
  }

  @override
  initState() {
    getNotificationList();
    super.initState();
  }

  getNotificationList() {
    GlobalMethods.showLoader();
    _userStore.Notification_list((value) {
      print(value);
      setState(() {
        contentData = value.notification?.length > 0 ? value.notification : [];
        print('notification');
      });
      GlobalMethods.hideLoader();
    }, (error) {
      GlobalMethods.hideLoader();
      print(error.toString());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        shadowColor: Colors.transparent,
        title: Text('Notification'),
        centerTitle: true,
      ),
      backgroundColor: Colors.white,
      body: Column(
        children: [
          SingleChildScrollView(
            child: (contentData.length > 0)
                ? Container(
                    width: DeviceUtils.getScaledWidth(context, 1.10),
                    height: DeviceUtils.getScaledHeight(context, 0.85),
                    child: ListView.builder(
                        itemCount: contentData.length,
                        itemBuilder: (context, index) => NotificationListItem(
                              notificationData: contentData[index],
                              onAccept: () {
                                acceptRejectEvent(
                                    contentData[index].eventId, "accepted");
                                Routes.navigateToScreenWithArgs(context,
                                    Routes.pay_request_business_payment, {
                                  "type": 'Pay',
                                  "userData": contentData[index].user
                                });
                              },
                              onReject: () {
                                acceptRejectEvent(
                                    contentData[index].eventId, "rejected");
                              },
                            )),
                  )
                : Center(
                    heightFactor: 12.0,
                    child: Text(
                      'No Notification found',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    )),
          ),
        ],
      ),
    );
  }

  acceptRejectEvent(id, status) async {
    print('createEvent RequestData :');
    //print(eData);
    GlobalMethods.showLoader();
    _userStore.acceptRejectEvent(id, status, (AcceptRejectEvent val) {
      GlobalMethods.hideLoader();
      if (val.success == true) {
        GlobalMethods.showSuccessMessage(
            context, val.message ?? 'Success', 'Event');
      } else {
        GlobalMethods.showErrorMessage(
            context, val.message ?? 'Failed', 'Event');
      }
    }, (error) {
      GlobalMethods.hideLoader();
    });
  }
}

class NotificationListItem extends StatelessWidget {
  final NotificationItem notificationData;
  Function? onAccept;
  Function? onReject;

  NotificationListItem(
      {required this.notificationData, this.onAccept, this.onReject, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(width: 1.0, color: Colors.grey),
        ),
        color: Colors.white,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          SizedBox(width: 15),
          Container(
            child: Image.network(
              'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSnngxCpo8jS7WE_uNWmlP4bME_IZkXWKYMzhM2Qi1JE_J-l_4SZQiGclMuNr4acfenazo&usqp=CAU',
              width: 50,
              height: 50,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(
            width: 10,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 15,
                ),
                Text(
                  notificationData?.message ?? "",
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  notificationData?.username ?? "",
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                //'chat','event','business','payment','payRequest'
                notificationData!.type == 'event' ||
                        notificationData!.type == 'payRequest'
                    ? Row(
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              onAccept!();
                            },
                            child: Text(notificationData!.type == 'payRequest'
                                ? 'Pay'
                                : 'Accept'),
                            style: ButtonStyle(
                                shape: MaterialStateProperty.all<
                                        RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50.0),
                            ))),
                          ),
                          SizedBox(width: 15),
                          ElevatedButton(
                            onPressed: () {
                              onReject!();
                            },
                            child: Text(
                              notificationData!.type == 'payRequest'
                                  ? 'Cancel'
                                  : 'Reject',
                              style: TextStyle(color: Colors.black),
                            ),
                            style: ButtonStyle(
                                backgroundColor: MaterialStateColor.resolveWith(
                                    (states) => Colors.white),
                                shape: MaterialStateProperty.all<
                                        RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(50.0),
                                ))),
                          ),
                        ],
                      )
                    : Container(),
              ],
            ),
          ),
          SizedBox(
            width: DeviceUtils.getScaledWidth(context, 0.02),
          ),
          Padding(
            padding: EdgeInsets.only(bottom: 0),
            child: Text(
              DateFormat('dd MMMM yyyy')
                  .format(DateTime.parse(notificationData?.createdAt ?? "")),
              style: TextStyle(
                fontSize: 8,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
