import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:guilt_app/constants/colors.dart';
import 'package:guilt_app/data/repository.dart';
import 'package:guilt_app/di/components/service_locator.dart';
import 'package:guilt_app/models/Auth/profile_modal.dart';
import 'package:guilt_app/models/Event/upcoming_past_event_modal.dart';
import 'package:guilt_app/stores/user/user_store.dart';
import 'package:guilt_app/utils/Global_methods/GlobalSocket.dart';
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
  late UserStore _userStore = UserStore(getIt<Repository>());
  List<UpcomingAndPastEventListDetail> upcomingEventList = [];
  List<UpcomingAndPastEventListDetail> pastEventList = [];

  @observable
  GetProfileResponseModal? ProfileData = GetProfileResponseModal();

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    initSetup();
    super.didChangeDependencies();
  }

  void initSetup() async {
    await _userStore.getProfile();
    setState(() {
      ProfileData = _userStore.Profile_data;
    });
    getEventsList('upcoming');
    getEventsList('past');
    G.initSocket();
    G.socketUtils.initSocket();
  }

  getEventsList(type) {
    _userStore.getUpcomingPastEventList(type, 0, 5,
        (UpcomingPastEventModal eventListResponse) {
      if (eventListResponse.success == true) {
        if (type == 'upcoming') {
          setState(() {
            upcomingEventList = eventListResponse.events.listData;
          });
        } else {
          setState(() {
            pastEventList = eventListResponse.events.listData;
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

  Widget upcomingOrPastEventCard(
      UpcomingAndPastEventListDetail eventItem, type) {
    return Card(
      margin: EdgeInsets.only(right: 12, bottom: 5),
      child: Container(
        color: Colors.white,
        alignment: Alignment.center,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.network(
              // eventItem['imageURL'] ?? 'https://zillifurniture.com/images/product/1601279977-pro-placeholder.png',
              type == 'upcoming'
                  ? 'https://vanguardian.org/wp-content/uploads/2021/02/UpcomingEvents.jpg'
                  : 'https://sathyaeducare.com/assets/img/recent.jpg',
              width: DeviceUtils.getScaledWidth(context, 0.40),
              height: DeviceUtils.getScaledHeight(context, 0.10),
            ),
            getFixSizedBox(size: 5),
            Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(eventItem.name,
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
                        '20+ Attendees',
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
                        eventItem.location,
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
        title: Observer(
            builder: (_) => Text(
                (ProfileData?.user?.firstname.toString() ?? '') +
                    '  ' +
                    (ProfileData?.user?.lastname.toString() ??
                        ''))),
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
          child: Container(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(100.0),
                    child: Observer(
                        builder: (_) => Image.network(
                              ProfileData?.user?.profile
                                      ?.toString() ??
                                  'https://th.bing.com/th/id/R.fa0ca630a6a3de8e33e03a009e406acd?rik=UOMXfynJ2FEiVw&riu=http%3a%2f%2fwww.clker.com%2fcliparts%2ff%2fa%2f0%2fc%2f1434020125875430376profile.png&ehk=73x7A%2fh2HgYZLT1q7b6vWMXl86IjYeDhub59EZ8hF14%3d&risl=&pid=ImgRaw&r=0',
                              width: DeviceUtils.getScaledWidth(context, 0.30),
                              height: DeviceUtils.getScaledWidth(context, 0.30),
                              fit: BoxFit.cover,
                            )),
                  ),
                ),
                getFixSizedBox(),
                Observer(
                    builder: (_) => Text(
                          ProfileData?.user?.email.toString() ??
                              'User Email',
                          style: TextStyle(
                              color: AppColors.primaryColor,
                              fontSize: 18,
                              fontWeight: FontWeight.w600),
                        )),
                getFixSizedBox(size: 5),
                Text(
                  'Description Here',
                ),
                ElevatedButtonWidget(
                  buttonColor: AppColors.primaryColor,
                  onPressed: () {
                    Routes.navigateToScreen(context, Routes.add_business);
                  },
                  buttonText: ('Add Business'),
                ),
                getFixSizedBox(),
                Card(
                  color: Colors.white60,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Column(
                          children: <Widget>[
                            Text(
                              'Invite Your Friends',
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.w900),
                              textAlign: TextAlign.left,
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              'Get \$20 off on Your Ticket',
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w700),
                              textAlign: TextAlign.left,
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            ElevatedButton(
                              child: Text('Invite'),
                              onPressed: () {
                                GlobalMethods.askPermissions(
                                    context, Routes.add_contacts);
                              },
                            ),
                          ],
                        ),
                        Column(children: <Widget>[
                          Icon(
                            Icons.image,
                            color: Theme.of(context).primaryColor,
                            size: 60,
                          ),
                          Text(
                            'Insert \n Graphics',
                            style: TextStyle(
                                fontSize: 14, fontWeight: FontWeight.w700),
                            textAlign: TextAlign.center,
                          ),
                        ]),
                      ],
                    ),
                  ),
                ),
                getFixSizedBox(),
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
                                  DeviceUtils.getScaledHeight(context, 0.20),
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
                                  DeviceUtils.getScaledHeight(context, 0.20),
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
