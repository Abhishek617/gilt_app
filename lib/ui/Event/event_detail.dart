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
import 'package:guilt_app/models/Event/create_event_modal.dart';
import 'package:guilt_app/models/PageModals/notification_list_model.dart';
import 'package:guilt_app/utils/Global_methods/GlobalSocket.dart';
import 'package:guilt_app/utils/device/device_utils.dart';
import 'package:guilt_app/widgets/rounded_button_with_icon.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../models/Auth/profile_modal.dart';
import '../../models/Event/accept_reject_event.dart';
import '../../models/payment/pay_to_user_request.dart';
import '../../models/payment/payment_card_master.dart';
import '../../models/success_master.dart';
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
  bool isPayButton = false;
  GetProfileResponseModal? profileData;
  EventAttendees1? payableAttendee;
  bool isPastEvent = false;

  @override
  void initState() {
    super.initState();
  }

  getProfileData() async {
    profileData = await _userStore.getProfileData();
    setState(() {});
  }

  @override
  void didChangeDependencies() {
    args = ModalRoute.of(context)!.settings.arguments;
    getDetails(args);
    getProfileData();
    super.didChangeDependencies();
  }

  Widget getImageContainer(EventImages photo) {
    return Container(
        height: 100,
        margin: EdgeInsets.only(right: 10, left: 10, top: 10),
        child: Image.network(photo.file.toString()));
  }

  getDetails(args) {
    isPayButton = false;
    GlobalMethods.showLoader();
    _userStore.Event_Detail(args, (value) {
      print(value);
      setState(() {
        contentData = EventDetailsResponseModel.fromJson(value);
      });
      getPayableAttendee();
      validatePayButton();
      validatePastEvent();
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
                              contentData?.event?.isUserAtendee == true &&
                                      !isCreator() &&
                                      payableAttendee != null &&
                                      payableAttendee!.paymentStatus == "paid"
                                  ? IconButton(
                                      onPressed: () {
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
                      GestureDetector(
                        onTap: () {
                          if (contentData?.event?.location != null) {
                            GlobalMethods.askLocationPermissionsOnly(context,
                                () async {
                              Map<String, dynamic> result =
                                  await Navigator.of(context)
                                      .pushNamed(Routes.map, arguments: {
                                'address': contentData?.event?.location
                              }) as Map<String, dynamic>;
                            });
                          } else {
                            GlobalMethods.showErrorMessage(context,
                                'Please Enter Address', 'Address Required');
                          }
                        },
                        child: Row(children: [
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
                      ),
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
                          : SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                            child: Row(
                                children: contentData!.event!.eventImages!
                                    .map((e) => getImageContainer(e))
                                    .toList()),
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
                  // Organizer can see the feedback list
                  isPastEvent && isCreator()
                      ? Container(
                          padding: EdgeInsets.only(left: 12, right: 12),
                          child: InkWell(
                            onTap: () {
                              Routes.navigateToScreenWithArgs(
                                  context, Routes.feedback_list, eID);
                            },
                            child: Column(
                              children: [
                                Divider(
                                  color: Colors.black12,
                                  height: 20,
                                  thickness: 1,
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.only(top: 5, bottom: 5),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "Feedback list",
                                        style: TextStyle(
                                            fontWeight: FontWeight.w600),
                                      ),
                                      Icon(
                                        Icons.arrow_forward_ios_rounded,
                                        color: Colors.black87,
                                        size: 15,
                                      )
                                    ],
                                  ),
                                ),
                                Divider(
                                  color: Colors.black12,
                                  height: 20,
                                  thickness: 1,
                                ),
                              ],
                            ),
                          ),
                        )
                      : Container(),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      isCreator() && contentData!.event!.status != 'cancelled'
                          ? Container(
                              margin: EdgeInsets.only(right: 15),
                              child: ElevatedButton(
                                onPressed: () {
                                  //Cancel an event
                                  cancelEvent();
                                },
                                child: Text('Cancel'),
                                style: ButtonStyle(
                                    shape: MaterialStateProperty.all<
                                            RoundedRectangleBorder>(
                                        RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(50.0),
                                ))),
                              ),
                            )
                          : Container(),
                      isPayButton &&
                              !isPastEvent &&
                              payableAttendee != null &&
                              payableAttendee!.paymentStatus == "pending"
                          ? Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  margin: EdgeInsets.only(right: 15),
                                  child: ElevatedButton(
                                    onPressed: () {
                                      //Pay
                                      choosePaymentMethod();
                                    },
                                    child: Text('Pay'),
                                    style: ButtonStyle(
                                        shape: MaterialStateProperty.all<
                                                RoundedRectangleBorder>(
                                            RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(50.0),
                                    ))),
                                  ),
                                ),
                                ElevatedButton(
                                  onPressed: () {
                                    //Reject event
                                    acceptRejectEvent(
                                        contentData?.event?.id ?? 0,
                                        "rejected");
                                  },
                                  child: Text(
                                    'Reject',
                                    style: TextStyle(color: Colors.black),
                                  ),
                                  style: ButtonStyle(
                                      backgroundColor:
                                          MaterialStateColor.resolveWith(
                                              (states) => Colors.white),
                                      shape: MaterialStateProperty.all<
                                              RoundedRectangleBorder>(
                                          RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(50.0),
                                      ))),
                                ),
                              ],
                            )
                          : Container(),
                    ],
                  ),
                  !isCreator() &&
                          payableAttendee != null &&
                          payableAttendee!.paymentStatus != "pending"
                      ? Container(
                          child: Text(
                              "You have ${payableAttendee?.paymentStatus ?? ""} for this event"),
                        )
                      : Container(),
                  isCreator() && contentData!.event!.status == 'cancelled'
                      ? Container(child: Text('You have cancelled the event'))
                      : Container(),
                  SizedBox(
                    height: 16,
                  ),
                  isPastEvent
                      ? ElevatedButton(
                          onPressed: () {
                            // Add feedback
                            Routes.navigateToScreenWithArgs(
                                context, Routes.add_feedback, eID);
                          },
                          child: Text('Add Feedback'),
                          style: ButtonStyle(
                              shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50.0),
                          ))),
                        )
                      : Container()
                ],
              ),
            ),
          )
        : Center(child: Text('No Details found.'));
  }

  // Returns true if logged in user is Organizer of an event
  bool isCreator() {
    // GetProfileResponseModal? profileData = await _userStore.getProfileData();
    if (profileData != null) {
      int userId = profileData?.user?.id ?? 0;
      if (contentData!.event!.createdBy! == userId) {
        return true;
      }
    }
    return false;
  }

  // set if user is payable for payment
  validatePayButton() async {
    GetProfileResponseModal? profileData = await _userStore.getProfileData();
    int userId = profileData?.user?.id ?? 0;
    if (contentData!.event!.isUserAtendee! &&
        contentData!.event!.createdBy! != userId &&
        contentData!.event!.status == 'pending') {
      setState(() {
        isPayButton = true;
      });
    }
  }

  // it stores attendees who can pay
  Future<void> getPayableAttendee() async {
    GetProfileResponseModal? profileData = await _userStore.getProfileData();
    int userId = profileData?.user?.id ?? 0;
    List<EventAttendees1> attendees = contentData?.event?.eventAttendees ?? [];
    if (attendees.isNotEmpty) {
      List<EventAttendees1> payableAttendees =
          attendees.where((element) => element.userId == userId).toList();
      if (payableAttendees.isNotEmpty) {
        payableAttendee = payableAttendees![0];
      }
    }
  }

  // validates if event has passed or not
  void validatePastEvent() {
    final currentDate = DateTime.now();
    try {
      if (contentData != null &&
          contentData!.event != null &&
          contentData!.event!.endDate != null) {
        DateTime endDate =
            DateTime.parse(contentData!.event!.endDate!).toLocal();
        if (endDate.isBefore(currentDate)) {
          setState(() {
            isPastEvent = true;
          });
        }
      }
    } catch (e) {
      print("Validate past event error: ${e.toString()}");
    }
  }

  void choosePaymentMethod() async {
    if (profileData != null) {
      var args = {
        "amount": payableAttendee?.expense ?? 0,
        "fromScreen": Routes.event_details
      };
      Routes.navigateToScreenWithArgsAndCB(context, Routes.select_card, args,
          (PaymentCardDetails data) {
        if (data != null) {
          payToEvent(data);
        }
      });
    } else {}
  }

  cancelEvent() {
    GlobalMethods.showLoader();
    _userStore.cancelEvent(contentData!.event!.id!,
        (AcceptRejectEvent successMaster) {
      GlobalMethods.hideLoader();
      if (successMaster != null) {
        if (successMaster.success != null && successMaster.success!) {
          GlobalMethods.showSuccessMessage(
              context, successMaster.message!, "Cancel Event" ?? "");
        } else {
          GlobalMethods.showErrorMessage(
              context, successMaster.message!, "Cancel Event" ?? "");
        }
      }
    }, (error) {
      GlobalMethods.hideLoader();
      print(error.toString());
    });
  }

  payToEvent(PaymentCardDetails data) async {
    GlobalMethods.showLoader();
    GetProfileResponseModal? profileData = await _userStore.getProfileData();
    int currentUserId = int.parse(profileData?.user?.customerProfileId ?? "0");

    PayToUserRequest payModel = PayToUserRequest(
        customerProfileId: currentUserId,
        paymentProfile: data.customerPaymentProfileId != null
            ? int.parse(data.customerPaymentProfileId!)
            : null,
        amount: data.bankDeduction,
        walletAmount: data.walletDeduction,
        toUserId: contentData?.event?.organizer?.id,
        paymentMethod: data.type,
        paymentReqId: data.id,
        eventId: contentData?.event?.id);

    _userStore.payToEvent(payModel, (SuccessMaster successMaster) {
      GlobalMethods.hideLoader();
      if (successMaster != null) {
        if (successMaster.success != null && successMaster.success!) {
          GlobalMethods.showSuccessMessage(
              context, successMaster.message!, "Pay" ?? "");
        } else {
          GlobalMethods.showErrorMessage(
              context, successMaster.message!, "Pay" ?? "");
        }
      }
    }, (error) {
      GlobalMethods.hideLoader();
      print(error.toString());
    });
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

  Widget setupAlertDialogContainer() {
    print(contentData);
    return Container(
      height: 300.0, // Change as per your requirement
      width: 300.0, // Change as per your requirement
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: contentData?.event?.eventAttendees?.length,
        itemBuilder: (BuildContext context, int index) {
          return getContactTile(contentData!.event!.eventAttendees![index]);
        },
      ),
    );
  }

  getContactTile(EventAttendees1 user) {
    print('user');
    print(user);
    return Container(
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                height: 45,
                width: 45,
                child: CircleAvatar(
                  backgroundColor: AppColors.primaryColor,
                  child: Icon(
                    Icons.person,
                    color: Colors.white,
                    size: 30,
                  ),
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${user?.admin?.firstname ?? ""} ${user?.admin?.lastname ?? ""} ${(contentData?.event?.organizer?.id == user?.userId ? ' (Host)' : '')} \n${user?.admin?.phone ?? ""}",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    user.paymentStatus == "paid"
                        ? Text(
                            "Paid amount: \$${user.expense}",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          )
                        : Container(),
                  ],
                ),
              ),
            ],
          ),
          Container(
            margin: EdgeInsets.symmetric(vertical: 10),
            height: 1,
            width: double.infinity,
            color: Colors.black26,
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
          if (contentData != null &&
              contentData!.event != null &&
              contentData!.event!.eventAttendees != null &&
              contentData!.event!.eventAttendees!.isNotEmpty) {
            showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text('Attendees'),
                    content: setupAlertDialogContainer(),
                  );
                });
          }
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
