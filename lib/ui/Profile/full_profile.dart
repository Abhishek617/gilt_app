import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:guilt_app/models/Auth/profile_modal.dart';
import 'package:guilt_app/stores/user/user_store.dart';
import 'package:guilt_app/utils/device/device_utils.dart';
import 'package:guilt_app/widgets/custom_scaffold.dart';
import 'package:provider/provider.dart';

import '../../constants/colors.dart';
import '../../widgets/rounded_button_with_icon.dart';

class FullProfile extends StatefulWidget {
  const FullProfile({Key? key}) : super(key: key);

  @override
  State<FullProfile> createState() => _FullProfileState();
}

class _FullProfileState extends State<FullProfile> {
  bool isEdit = false;
  bool isAboutEdit = false;
  bool isContactEdit = false;
  late UserStore _profileStore;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    // initializing stores
    _profileStore = Provider.of<UserStore>(context);

    // check to see if already called api
    if (!_profileStore.loading) {
      _profileStore.getProfile();
      isEdit = false;
    }
  }

  get_profile_input() {
    return Container(
      margin: EdgeInsets.all(8),
      child: Column(
        children: <Widget>[
          Card(
            child: Row(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(
                      left: 10.0, top: 10.0, bottom: 10.0, right: 10.0),
                  child: Icon(
                    Icons.email,
                    color: AppColors.primaryColour,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      left: 00.0, top: 10.0, bottom: 10.0, right: 10.0),
                  child: Text(
                    'Email',
                    style: TextStyle(
                      fontSize: 12,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Row(
            children: <Widget>[
              Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 00.0, top: 7.0, bottom: 00.0, right: 00.0),
                    child: Card(
                      child: Row(
                        children: <Widget>[
                          Padding(
                              padding: const EdgeInsets.only(
                                  left: 10.0,
                                  top: 10.0,
                                  bottom: 10.0,
                                  right: 10.0),
                              child: Icon(Icons.person_rounded,
                                  color: AppColors.primaryColour)),
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 00.0,
                                top: 10.0,
                                bottom: 10.0,
                                right: 84.0),
                            child: Text(
                              'Name',
                              style: TextStyle(
                                fontSize: 12,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 5.0, top: 7.0, bottom: 00.0, right: 00.0),
                    child: Card(
                      child: Row(
                        children: <Widget>[
                          Padding(
                              padding: const EdgeInsets.only(
                                  left: 10.0,
                                  top: 10.0,
                                  bottom: 10.0,
                                  right: 10.0),
                              child: Icon(Icons.person_rounded,
                                  color: AppColors.primaryColour)),
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 00.0,
                                top: 10.0,
                                bottom: 10.0,
                                right: 60.0),
                            child: Text(
                              'Last Name',
                              style: TextStyle(
                                fontSize: 12,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(
                left: 120.0, top: 20.0, bottom: 10.0, right: 120.0),
            child: SizedBox(
              width: 100.0,
              height: 30.0,
              child: ElevatedButton.icon(
                onPressed: () {
                  setState(() {
                    isEdit = false;
                  });
                },
                icon: Icon(
                  Icons.save,
                  color: Colors.white,
                ),
                label: Text(
                  'Save',
                  style: TextStyle(fontSize: 12, color: Colors.white),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  get_edit_profile_button() {
    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(
              left: 00.0, top: 20.0, bottom: 00.0, right: 00.0),
          child: Text(
            _profileStore.Profile_data!.user!.firstname.toString() +
                '  ' +
                _profileStore.Profile_data!.user!.lastname.toString(),
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.w900),
            textAlign: TextAlign.center,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(
              left: 00.0, top: 5.0, bottom: 00.0, right: 00.0),
          child: Text(
            _profileStore.Profile_data!.user!.email.toString(),
            style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
            textAlign: TextAlign.center,
          ),
        ),
        Padding(
          padding:
              EdgeInsets.only(left: 80.0, top: 20.0, bottom: 20.0, right: 80.0),
          child: ElevatedButtonWidgetWithIcon(
            buttonColor: AppColors.primaryColour,
            onPressed: () {
              setState(() {
                isEdit = true;
              });
            },
            icon: Icon(Icons.edit),
            buttonText: ('Edit Profile'),
          ),
        ),
      ],
    );
  }

  about() {
    return Row(
      children: <Widget>[
        Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(
                  left: 20.0, top: 10.0, bottom: 00.0, right: 80.0),
              child: Text(
                'About Me',
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w900),
                textAlign: TextAlign.center,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                  left: 00.0, top: 2.0, bottom: 2.0, right: 90.0),
              child: Text(
                _profileStore.Profile_data!.user!.aboutme.toString(),
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ],
        ),
        Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(
                  left: 70.0, top: 0.0, bottom: 00.0, right: 00.0),
              child: SizedBox(
                width: 110.0,
                height: 25.0,
                child: ElevatedButton.icon(
                    onPressed: () {
                      setState(() {
                        isAboutEdit = true;
                      });
                    },
                    icon: Icon(
                      Icons.edit,
                      color: Colors.white,
                    ),
                    label: Text(
                      'Change',
                      style: TextStyle(fontSize: 12, color: Colors.white),
                    )),
              ),
            ),
          ],
        ),
      ],
    );
  }

  edit_about() {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.only(left: 20, right: 280, bottom: 20),
          child: Text(
            'About Me',
            style: TextStyle(fontSize: 12),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(left: 20, right: 20),
          child: TextField(
            decoration: InputDecoration(),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(
              left: 120.0, top: 20.0, bottom: 10.0, right: 120.0),
          child: SizedBox(
            width: 100.0,
            height: 30.0,
            child: ElevatedButton.icon(
              onPressed: () {
                setState(() {
                  isAboutEdit = false;
                });
              },
              icon: Icon(
                Icons.save,
                color: Colors.white,
              ),
              label: Text(
                'Save',
                style: TextStyle(fontSize: 12, color: Colors.white),
              ),
            ),
          ),
        ),
      ],
    );
  }

  contact() {
    return Row(
      children: <Widget>[
        Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(
                  left: 20.0, top: 10.0, bottom: 00.0, right: 40.0),
              child: Text(
                'Contact Details',
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w900),
                textAlign: TextAlign.center,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                  left: 00.0, top: 10.0, bottom: 20.0, right: 48.0),
              child: Text(
                _profileStore.Profile_data!.user!.phone.toString() +
                    '\n' +
                    _profileStore.Profile_data!.user!.address.toString() +
                    '\n' +
                    _profileStore.Profile_data!.user!.city.toString() +
                    '\n' +
                    _profileStore.Profile_data!.user!.state.toString() +
                    '\n' +
                    _profileStore.Profile_data!.user!.country.toString() +
                    '\n' +
                    _profileStore.Profile_data!.user!.zip.toString(),
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(
              left: 75.0, top: 10.0, bottom: 100.0, right: 00.0),
          child: SizedBox(
            width: 110.0,
            height: 25.0,
            child: ElevatedButton.icon(
                onPressed: () {
                  setState(() {
                    isContactEdit = true;
                  });
                },
                icon: Icon(
                  Icons.edit,
                  color: Colors.white,
                ),
                label: Text(
                  'Change',
                  style: TextStyle(fontSize: 12, color: Colors.white),
                )),
          ),
        ),
      ],
    );
  }

  edit_contact() {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.only(left: 20, right: 20, top: 10),
          child: Container(
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 5, right:5),
                  child: TextField(
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.call,
                          size: 30, color: AppColors.primaryColour),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(left: 20, right: 20, top: 10),
          child: Container(
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 5, right:5),
                  child: TextField(
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.house,
                          size: 30, color: AppColors.primaryColour),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        Row(
          children: [
            Padding(
              padding: EdgeInsets.only(left: 20, right: 10, top: 20),
              child: Container(
                padding: const EdgeInsets.all(10.0),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                ),
                child: Row(
                  children: [Text('               City                ')],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 10, right: 20, top: 20),
              child: Container(
                padding: const EdgeInsets.all(10.0),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                ),
                child: Row(
                  children: [Text('             State             ')],
                ),
              ),
            ),
          ],
        ),
        Row(
          children: [
            Padding(
              padding: EdgeInsets.only(left: 20, right: 10, top: 20),
              child: Container(
                padding: const EdgeInsets.all(10.0),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                ),
                child: Row(
                  children: [Text('             Country           ')],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 10, right: 20, top: 20),
              child: Container(
                padding: const EdgeInsets.all(10.0),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                ),
                child: Row(
                  children: [Text('           ZipCode         ')],
                ),
              ),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(
              left: 120.0, top: 20.0, bottom: 10.0, right: 120.0),
          child: SizedBox(
            width: 100.0,
            height: 30.0,
            child: ElevatedButton.icon(
              onPressed: () {
                setState(() {
                  isContactEdit = false;
                });
              },
              icon: Icon(
                Icons.save,
                color: Colors.white,
              ),
              label: Text(
                'Save',
                style: TextStyle(fontSize: 12, color: Colors.white),
              ),
            ),
          ),
        ),
      ],
    );
  }

  checkProfile() {
    return isEdit ? get_profile_input() : get_edit_profile_button();
  }

  checkAbout() {
    return isAboutEdit ? edit_about() : about();
  }

  checkContact() {
    return isContactEdit ? edit_contact() : contact();
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldWrapper(
      appBar: AppBar(
        shadowColor: Colors.transparent,
        centerTitle: true,
        title: const Text('Profile'),
      ),
      child: SingleChildScrollView(
        child: Container(
          height: DeviceUtils.getScaledHeight(context, 1.10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Align(
                alignment: Alignment.center,
                child: Stack(
                  children: [
                    Container(
                      padding: const EdgeInsets.only(
                          left: 00.0, top: 30.0, bottom: 00.0, right: 00.0),
                      child: Image.network(
                        'https://th.bing.com/th/id/R.fa0ca630a6a3de8e33e03a009e406acd?rik=UOMXfynJ2FEiVw&riu=http%3a%2f%2fwww.clker.com%2fcliparts%2ff%2fa%2f0%2fc%2f1434020125875430376profile.png&ehk=73x7A%2fh2HgYZLT1q7b6vWMXl86IjYeDhub59EZ8hF14%3d&risl=&pid=ImgRaw&r=0',
                        width: 100,
                        height: 100,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ],
                ),
              ),
              checkProfile(),
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
              checkAbout(),
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
              checkContact(),
            ],
          ),
        ),
      ),
    );
  }
}
