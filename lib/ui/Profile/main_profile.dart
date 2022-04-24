import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:guilt_app/constants/colors.dart';
import 'package:guilt_app/data/repository.dart';
import 'package:guilt_app/di/components/service_locator.dart';
import 'package:guilt_app/models/Auth/profile_modal.dart';
import 'package:guilt_app/stores/user/user_store.dart';
import 'package:guilt_app/utils/device/device_utils.dart';
import 'package:guilt_app/widgets/custom_body_wrapper.dart';
import 'package:guilt_app/widgets/custom_scaffold.dart';
import 'package:guilt_app/widgets/rounded_button_widget.dart';
import 'package:mobx/mobx.dart';
import 'package:provider/provider.dart';
import '../common/menu_drawer.dart';
import 'package:guilt_app/utils/routes/routes.dart';

class MainProfile extends StatefulWidget {
  const MainProfile({Key? key}) : super(key: key);

  @override
  State<MainProfile> createState() => _MainProfileState();
}

class _MainProfileState extends State<MainProfile> {
  late UserStore _profileStore = UserStore(getIt<Repository>());

  // @override
  // void initState() {
  //   super.initState();
  //   initSetup();
  // }

  @override
  void initState() {
    // TODO: implement initState

    super.initState();
    initSetup();
  }

  @override
  void didChangeDependencies() {
    initSetup();
    super.didChangeDependencies();
  }

  void initSetup() async {
    // initializing stores
    // _profileStore = Provider.of<UserStore>(context);

    // check to see if already called api

    await _profileStore.getProfile();

    // check to see if already called api
  }

  Widget box(String title, Color backgroundcolor, Image demo) {
    return Padding(
      padding: EdgeInsets.only(left: 0, top: 0, right: 10, bottom: 0),
      child: Card(
        child: Container(
          margin: EdgeInsets.all(5),
          width: 170,
          color: backgroundcolor,
          alignment: Alignment.center,
          child: Column(
            children: [
              Image.network(
                'https://zillifurniture.com/images/product/1601279977-pro-placeholder.png',
                width: 170,
                height: 80,
              ),
              Text('International Band Mu..',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.w700)),
              Row(
                children: [
                  Padding(
                      padding: EdgeInsets.only(
                          left: 0.0, top: 5.0, bottom: 00.0, right: 0.0),
                      child: Icon(
                        Icons.supervised_user_circle,
                        size: 20,
                        color: Theme.of(context).colorScheme.primary,
                      )),
                  Padding(
                    padding: EdgeInsets.only(
                        left: 10.0, top: 5.0, bottom: 00.0, right: 0.0),
                    child: Text(
                      '20+ Attendoes',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                        decoration: TextDecoration.underline,
                        color: Colors.blueAccent,
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Padding(
                      padding: EdgeInsets.only(
                          left: 00.0, top: 5.0, bottom: 00.0, right: 0.0),
                      child: Icon(Icons.location_on,
                          size: 20,
                          color: Theme.of(context).colorScheme.primary)),
                  Padding(
                    padding: EdgeInsets.only(
                        left: 10.0, top: 5.0, bottom: 00.0, right: 0.0),
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
      ),
    );
  }

  List<String> item = [' b', 'c ', ' d', ' d', 'd ', 'd '];

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
                _profileStore.Profile_data!.user!.firstname.toString() +
                    '  ' +
                    _profileStore.Profile_data!.user!.lastname.toString())),
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Align(
                alignment: Alignment.center,
                child: Stack(
                  children: [
                    Container(
                      padding: const EdgeInsets.only(
                          left: 00.0, top: 30.0, bottom: 00.0, right: 00.0),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(50.0),
                        child: Image.network(
                          _profileStore.Profile_data!.user!.profile == null
                              ? 'https://th.bing.com/th/id/R.fa0ca630a6a3de8e33e03a009e406acd?rik=UOMXfynJ2FEiVw&riu=http%3a%2f%2fwww.clker.com%2fcliparts%2ff%2fa%2f0%2fc%2f1434020125875430376profile.png&ehk=73x7A%2fh2HgYZLT1q7b6vWMXl86IjYeDhub59EZ8hF14%3d&risl=&pid=ImgRaw&r=0'
                              : _profileStore.Profile_data!.user!.profile
                                  .toString(),
                          width: DeviceUtils.getScaledWidth(context, 0.30),
                          height: DeviceUtils.getScaledWidth(context, 0.30),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 12,
              ),
              Center(
                child: Text(
                  _profileStore.Profile_data!.user!.email.toString(),
                  style: TextStyle(
                      color: AppColors.primaryColor,
                      fontSize: 18,
                      fontWeight: FontWeight.w600),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                    left: 40.0, top: 10.0, bottom: 5.0, right: 40.0),
                child: SizedBox(
                  height: 15,
                  child: Center(
                    child: Text(
                      'Description Here',
                    ),
                  ),
                ),
              ),
              Center(
                child: ElevatedButtonWidget(
                  buttonColor: AppColors.primaryColor,
                  onPressed: () {
                    Routes.navigateToScreen(context, Routes.add_business);
                  },
                  buttonText: ('Add Business'),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                    left: 20.0, top: 5.0, bottom: 20.0, right: 20.0),
                child: Card(
                  color: Colors.white60,
                  child: Row(
                    children: <Widget>[
                      Column(
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.only(
                                left: 20.0,
                                top: 20.0,
                                bottom: 00.0,
                                right: 00.0),
                            child: Text(
                              'Invite Your Friends',
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.w900),
                              textAlign: TextAlign.left,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                                left: 00.0,
                                top: 10.0,
                                bottom: 10.0,
                                right: 00.0),
                            child: Text(
                              'Get 20r Your Tickets',
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w700),
                              textAlign: TextAlign.left,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                                left: 00.0,
                                top: 10.0,
                                bottom: 20.0,
                                right: 60.0),
                            child: SizedBox(
                              height: 30,
                              width: 90,
                              child: ElevatedButton(
                                child: Text('Invite'),
                                onPressed: () {},
                              ),
                            ),
                          ),
                        ],
                      ),
                      Column(children: <Widget>[
                        Padding(
                          padding: EdgeInsets.only(
                              left: 30.0, top: 10.0, bottom: 0.0, right: 0.0),
                          child: Icon(
                            Icons.image,
                            color: Theme.of(context).primaryColor,
                            size: 40,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              left: 30.0, top: 0.0, bottom: 10.0, right: 0.0),
                          child: Text(
                            'Insert \n Graphics',
                            style: TextStyle(
                                fontSize: 14, fontWeight: FontWeight.w700),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ]),
                    ],
                  ),
                ),
              ),
              Row(
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                        left: 22.0, top: 5.0, bottom: 5.0, right: 0.0),
                    child: Text(
                      'Upcoming Events',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w900),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        left: 140.0, top: 5.0, bottom: 10.0, right: 5.0),
                    child: GestureDetector(
                        child: Text(
                          'See all',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w700,
                            decoration: TextDecoration.underline,
                            color: Colors.blueAccent,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        onTap: () {
                          Routes.navigateToScreen(context, Routes.event);
                        }),
                  ),
                ],
              ),
              Container(
                padding: EdgeInsets.only(
                    left: 15.0, top: 5.0, bottom: 5.0, right: 15.0),
                child: Column(
                  children: [
                    Container(
                        height: 170,
                        child: ListView(
                          scrollDirection: Axis.horizontal,
                          children: item.map((country) {
                            return box(
                                country,
                                Colors.white,
                                Image.network(
                                    'https://th.bing.com/th/id/R.fa0ca630a6a3de8e33e03a009e406acd?rik=UOMXfynJ2FEiVw&riu=http%3a%2f%2fwww.clker.com%2fcliparts%2ff%2fa%2f0%2fc%2f1434020125875430376profile.png&ehk=73x7A%2fh2HgYZLT1q7b6vWMXl86IjYeDhub59EZ8hF14%3d&risl=&pid=ImgRaw&r=0'));
                          }).toList(),
                        )),
                  ],
                ),
              ),
              Row(
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                        left: 22.0, top: 15.0, bottom: 10.0, right: 0.0),
                    child: Text(
                      'Past Events',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w900),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        left: 182.0, top: 10.0, bottom: 10.0, right: 0.0),
                    child: GestureDetector(
                      child: Text(
                        'See all',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w700,
                          decoration: TextDecoration.underline,
                          color: Colors.blueAccent,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      onTap: () {
                        Routes.navigateToScreen(context, Routes.event);
                      },
                    ),
                  ),
                ],
              ),
              Container(
                padding: EdgeInsets.only(
                    left: 15.0, top: 5.0, bottom: 5.0, right: 15.0),
                child: Column(
                  children: [
                    Container(
                        height: 170,
                        child: ListView(
                          scrollDirection: Axis.horizontal,
                          children: item.map((list_item) {
                            return box(
                                list_item,
                                Colors.white,
                                Image.network(
                                    'https://th.bing.com/th/id/R.fa0ca630a6a3de8e33e03a009e406acd?rik=UOMXfynJ2FEiVw&riu=http%3a%2f%2fwww.clker.com%2fcliparts%2ff%2fa%2f0%2fc%2f1434020125875430376profile.png&ehk=73x7A%2fh2HgYZLT1q7b6vWMXl86IjYeDhub59EZ8hF14%3d&risl=&pid=ImgRaw&r=0'));
                          }).toList(),
                        )),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
