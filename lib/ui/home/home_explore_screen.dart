import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:guilt_app/constants/app_settings.dart';
import 'package:guilt_app/constants/colors.dart';
import 'package:guilt_app/data/repository.dart';
import 'package:guilt_app/di/components/service_locator.dart';
import 'package:guilt_app/models/Auth/profile_modal.dart';
import 'package:guilt_app/models/Event/upcoming_past_event_modal.dart';
import 'package:guilt_app/stores/user/user_store.dart';
import 'package:guilt_app/utils/Global_methods/GlobalSocket.dart';
import 'package:guilt_app/utils/Global_methods/GlobalStoreHandler.dart';
import 'package:guilt_app/utils/Global_methods/SocketService.dart';
import 'package:guilt_app/utils/Global_methods/global.dart';
import 'package:guilt_app/utils/device/device_utils.dart';
import 'package:guilt_app/widgets/custom_body_wrapper.dart';
import 'package:guilt_app/widgets/custom_scaffold.dart';
import 'package:guilt_app/widgets/rounded_button_widget.dart';
import 'package:mobx/mobx.dart';
import 'package:provider/provider.dart';
import '../common/menu_drawer.dart';
import 'package:guilt_app/utils/routes/routes.dart';

class HomeExploreScreen extends StatefulWidget {
  const HomeExploreScreen({Key? key}) : super(key: key);

  @override
  State<HomeExploreScreen> createState() => _HomeExploreScreenState();
}

class _HomeExploreScreenState extends State<HomeExploreScreen> {
  late SocketUtils socketUtils;
  List<UpcomingAndPastEventListDetail> upcomingEventList = [];
  List<UpcomingAndPastEventListDetail> pastEventList = [];

  @observable
  GetProfileResponseModal? ProfileData = GetProfileResponseModal();

  @override
  void initState() {
    initSetup();
    GlobalStoreHandler.initStores();
    super.initState();
  }

  @override
  void didChangeDependencies() {
    if (this.mounted) {
      initSetup();
      G.initSocket();
      G.socketUtils.initSocket();
      super.didChangeDependencies();
    }
  }

  void initSetup() async {
    await GlobalStoreHandler.userStore.getProfile();
    setState(() {
      ProfileData = GlobalStoreHandler.userStore.Profile_data;
    });
    getEventsList('upcoming');
    getEventsList('past');
    G.initSocket();
    G.socketUtils.initSocket();
  }

  getEventsList(type) {
    GlobalStoreHandler.userStore.getUpcomingPastEventList(type, 0, 5,
        (UpcomingPastEventModal eventListResponse) {
      if (eventListResponse.success == true) {
        if (type == 'upcoming') {
          setState(() {
            upcomingEventList = eventListResponse?.events?.listData ?? [];
          });
        } else {
          setState(() {
            pastEventList = eventListResponse.events?.listData ?? [];
          });
        }
      }
    }, (error) {
      print(error);
    });
  }

  Widget getFixSizedBox({double size = 12}) {
    return SizedBox(height: size);
  }

  Widget getNoEventsWidget() {
    return Image.network(
      'https://sathyaeducare.com/assets/img/recent.jpg',
      width: DeviceUtils.getScaledWidth(context, 0.60),
    );
  }

  getEventDetails(context, eventItem) {
    if (eventItem.id != null)
      Routes.navigateToScreenWithArgs(
          context, Routes.event_details, eventItem.id);
  }

  Widget upcomingOrPastEventCard(
      UpcomingAndPastEventListDetail eventItem, type) {
    return GestureDetector(
      onTap: () {
        getEventDetails(context, eventItem);
      },
      child: Card(
        margin: EdgeInsets.only(right: 12, bottom: 5),
        child: Container(
          padding: EdgeInsets.only(left: 1),
          color: Colors.white,
          alignment: Alignment.center,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.network(
                // eventItem['imageURL'] ?? 'https://zillifurniture.com/images/product/1601279977-pro-placeholder.png',
                type == 'upcoming'
                    ? eventItem!.eventImages!.length > 0 ? eventItem!.eventImages![0].file ?? 'https://vanguardian.org/wp-content/uploads/2021/02/UpcomingEvents.jpg' : 'https://vanguardian.org/wp-content/uploads/2021/02/UpcomingEvents.jpg'
                    :  eventItem!.eventImages!.length > 0 ? eventItem!.eventImages![0]?.file ?? 'https://sathyaeducare.com/assets/img/recent.jpg':'https://vanguardian.org/wp-content/uploads/2021/02/UpcomingEvents.jpg',
                width: DeviceUtils.getScaledWidth(context, 0.40),
                height: DeviceUtils.getScaledHeight(context, 0.10),
              ),
              getFixSizedBox(size: 5),
              Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(eventItem.name ?? 'Name',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.w700)),
                    getFixSizedBox(size: 3),
                    Row(
                      children: [
                        Icon(
                          Icons.supervised_user_circle,
                          size: 20,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                        Text(
                          (eventItem.attendeeCount.toString() ?? '1') + ' Attendees',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w700,
                            decoration: TextDecoration.underline,
                            color: Colors.blueAccent,
                          ),
                        ),
                      ],
                    ),
                    getFixSizedBox(size: 3),
                    Row(
                      children: [
                        Icon(Icons.location_on,
                            size: 20,
                            color: Theme.of(context).colorScheme.primary),
                        Text(
                          eventItem.location ?? 'No Location',
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w500,
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
    );
  }

  Widget getSearchBar() {
    return Container(
      width: double.infinity,
      height: 40,
      decoration: BoxDecoration(
          color: Colors.transparent, borderRadius: BorderRadius.circular(5)),
      child: Center(
        child: TextField(
          decoration: InputDecoration(
              prefixIcon: Icon(
                Icons.search,
                color: Colors.white,
              ),
              suffixIcon: IconButton(
                icon: Icon(
                  Icons.clear,
                  color: Colors.white,
                ),
                onPressed: () {
                  /* Clear the search field */
                },
              ),
              hintText: 'Search...',
              hintStyle: TextStyle(color: Colors.white),
              suffixIconColor: Colors.white,
              border: InputBorder.none),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MenuDrawer(),
      appBar: AppBar(
        shadowColor: Colors.transparent,
        centerTitle: true,
        title: Text('Explore Events'),
        actions: [
          IconButton(
            padding: EdgeInsets.only(
                left: 00.0, top: 10.0, bottom: 5.0, right: 00.0),
            icon: Icon(Icons.circle_notifications),
            onPressed: () {
              Routes.navigateToScreen(context, Routes.notifi);
            },
          ),
        ],
      ),
      body: CustomBodyWrapper(
        child: SingleChildScrollView(
          padding: EdgeInsets.only(bottom: 80),
          child: Container(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Observer(
                  builder: (_) => Text(
                    'Welcome, ' +
                        (ProfileData?.user?.firstname.toString() ?? '') +
                        '  ' +
                        (ProfileData?.user?.lastname.toString() ?? ''),
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                  ),
                ),
                // Container(
                //   child: ClipRRect(
                //     borderRadius: BorderRadius.circular(100.0),
                //     child: Observer(
                //         builder: (_) => Image.network(
                //               ProfileData?.user?.profile?.toString() ??
                //                   'https://th.bing.com/th/id/R.fa0ca630a6a3de8e33e03a009e406acd?rik=UOMXfynJ2FEiVw&riu=http%3a%2f%2fwww.clker.com%2fcliparts%2ff%2fa%2f0%2fc%2f1434020125875430376profile.png&ehk=73x7A%2fh2HgYZLT1q7b6vWMXl86IjYeDhub59EZ8hF14%3d&risl=&pid=ImgRaw&r=0',
                //               width: DeviceUtils.getScaledWidth(context, 0.30),
                //               height: DeviceUtils.getScaledWidth(context, 0.30),
                //               fit: BoxFit.cover,
                //             )),
                //   ),
                // ),
                // getFixSizedBox(),
                // Observer(
                //     builder: (_) => Text(
                //           ProfileData?.user?.email.toString() ?? 'User Email',
                //           style: TextStyle(
                //               color: AppColors.primaryColor,
                //               fontSize: 18,
                //               fontWeight: FontWeight.w600),
                //         )),
                // getFixSizedBox(size: 5),
                // Text(
                //   ProfileData?.user?.roleId.toString() ==
                //           AppSettings.businessUserRole
                //       ? 'Business Account'
                //       : 'Individual Account',
                // ),
                // ProfileData?.user?.roleId.toString() !=
                //         AppSettings.businessUserRole
                //     ? ElevatedButtonWidget(
                //         buttonColor: AppColors.primaryColor,
                //         onPressed: () {
                //           Routes.navigateToScreen(context, Routes.create_event);
                //         },
                //         buttonText: ('Create Event'),
                //       )
                //     : ElevatedButtonWidget(
                //         buttonColor: AppColors.primaryColor,
                //         onPressed: () {
                //           Routes.navigateToScreen(context, Routes.add_business);
                //         },
                //         buttonText: ('Add Business'),
                //       ),
                // getFixSizedBox(),

                (upcomingEventList.length > 0)
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Upcoming Events',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w900),
                            textAlign: TextAlign.center,
                          ),
                          TextButton(
                              child: Text(
                                'See all',
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w700,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              onPressed: () {
                                Routes.navigateToScreen(context, Routes.event);
                              }),
                        ],
                      )
                    : getNoEventsWidget(),
                (upcomingEventList.length > 0)
                    ? Column(
                        children: [
                          Container(
                              height:
                                  DeviceUtils.getScaledHeight(context, 0.22),
                              child: ListView.builder(
                                itemCount: upcomingEventList.length,
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (context, index) {
                                  return upcomingOrPastEventCard(
                                      upcomingEventList[index], 'upcoming');
                                },
                              )),
                        ],
                      )
                    : Container(),
                (pastEventList.length > 0)
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Past Events',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w900),
                            textAlign: TextAlign.center,
                          ),
                          TextButton(
                              child: Text(
                                'See all',
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w700,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              onPressed: () {
                                Routes.navigateToScreen(context, Routes.event);
                              }),
                        ],
                      )
                    : getNoEventsWidget(),
                (pastEventList.length > 0)
                    ? Column(
                        children: [
                          Container(
                              height:
                                  DeviceUtils.getScaledHeight(context, 0.22),
                              child: ListView.builder(
                                itemCount: pastEventList.length,
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (context, index) {
                                  return upcomingOrPastEventCard(
                                      pastEventList[index], 'past');
                                },
                              )),
                        ],
                      )
                    : Container(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
