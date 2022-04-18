import 'dart:convert';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:guilt_app/data/repository.dart';
import 'package:guilt_app/di/components/service_locator.dart';
import 'package:guilt_app/models/Auth/Update_Profile_Modal.dart';
import 'package:guilt_app/models/Auth/profile_modal.dart';
import 'package:guilt_app/models/PageModals/success_error_args.dart';
import 'package:guilt_app/stores/user/user_store.dart';
import 'package:guilt_app/utils/Global_methods/global.dart';
import 'package:guilt_app/utils/device/device_utils.dart';
import 'package:guilt_app/utils/routes/routes.dart';
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
  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  bool isEdit = false;
  bool isAboutEdit = false;
  bool isContactEdit = false;
  late UserStore _profileStore;
  TextEditingController _userEmailController = TextEditingController();
  TextEditingController _userFirstNameController = TextEditingController();
  TextEditingController _userLastNameController = TextEditingController();
  TextEditingController _userAboutmeController = TextEditingController();
  TextEditingController _userContactController = TextEditingController();
  TextEditingController _userAddressController = TextEditingController();
  TextEditingController _userCityController = TextEditingController();
  TextEditingController _userStateController = TextEditingController();
  TextEditingController _userCountryController = TextEditingController();
  TextEditingController _userZipController = TextEditingController();
  final UserStore _userStore = UserStore(getIt<Repository>());

  @override
  void didChangeDependencies() async{
    super.didChangeDependencies();

    // initializing stores
    _profileStore = Provider.of<UserStore>(context);

    // check to see if already called api

   await  _profileStore.getProfile();
    setState(() {
      _userEmailController.text =
          _profileStore.Profile_data!.user!.email.toString();
      _userFirstNameController.text =
          _profileStore.Profile_data!.user!.firstname.toString();
      _userLastNameController.text =
          _profileStore.Profile_data!.user!.lastname.toString();
      _userAboutmeController.text =
          _profileStore.Profile_data!.user!.aboutme.toString();
      _userContactController.text =
          _profileStore.Profile_data!.user!.phone.toString();
      _userAddressController.text =
          _profileStore.Profile_data!.user!.address.toString();
      _userCityController.text =
          _profileStore.Profile_data!.user!.city.toString();
      _userStateController.text =
          _profileStore.Profile_data!.user!.state.toString();
      _userCountryController.text =
          _profileStore.Profile_data!.user!.country.toString();
      _userZipController.text =
          _profileStore.Profile_data!.user!.zip.toString();
    });

    isEdit = false;
  }

  updatedata() {
      final UpdateProfileData = UpdateProfileRequestModal.fromJson({
        "firstname": _userFirstNameController.value.text,
        "lastname": _userLastNameController.value.text,
        "email": _userEmailController.value.text,
        "phone": _userContactController.value.text,
        "aboutme": _userAboutmeController.value.text,
        "address": _userAddressController.value.text,
        "city": _userCityController.value.text,
        "state": _userStateController.value.text,
        "country": _userCountryController.value.text,
        "zip": int.parse(_userZipController.value.text),
      });
      _userStore.updateprofile(UpdateProfileData, (val) {
        print(val);
        (val.success == true)
            ? (val.user != null)
                ? Routes.navigateToScreenWithArgs(
                    context,
                    Routes.success_error_validate,
                    SuccessErrorValidationPageArgs(
                        isSuccess: true,
                        description: 'SignUp Success',
                        title: 'Success',
                        isPreviousLogin: true))
                : Routes.navigateRootToScreen(context, Routes.otpvalidate)
            : GlobalMethods.showErrorMessage(
                context, val.message, 'Update Profile');
      }, (error) {
        print(error.data.toString());
        final data =
            json.decode(json.encode(error.data)) as Map<String, dynamic>;
        print(data['error']);
        // Map<String, dynamic> map = json.decode(error.data);
        List<dynamic> dataList = data["error"];
        print(dataList[0]["message"]);
        GlobalMethods.showErrorMessage(
            context,
            dataList[0]["field"] + ' : ' + dataList[0]["message"],
            'Sign Up Exception');
      });
      // Routes.navigateToScreen(context, Routes.before_login);

  }

  get_profile_input() {
    return Container(
      margin: EdgeInsets.all(8),
      child: Column(
        children: <Widget>[
          Container(
            child: Row(
              children: <Widget>[
                Expanded(
                  child: TextField(
                    controller: _userEmailController,
                    decoration: InputDecoration(
                      labelText: 'Email',
                      prefixIcon: Icon(Icons.location_city,
                          size: 20, color: AppColors.primaryColor),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 10, bottom: 10),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: TextFormField(
                    controller: _userFirstNameController,
                    decoration: InputDecoration(
                      labelText: 'Firstname',
                      prefixIcon: Icon(Icons.person_rounded,
                          size: 20, color: AppColors.primaryColor),
                    ),
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: TextField(
                    controller: _userLastNameController,
                    decoration: InputDecoration(
                      labelText: 'Lastname',
                      prefixIcon: Icon(Icons.person_rounded,
                          size: 20, color: AppColors.primaryColor),
                    ),
                  ),
                ),
              ],
            ),
          ),
          ElevatedButton.icon(
            onPressed: () {
              setState(() {
                updatedata();
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
            buttonColor: AppColors.primaryColor,
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: <Widget>[
            Expanded(
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'About Me',
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w900),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            Align(
              alignment: Alignment.centerRight,
              child: ElevatedButton.icon(
                onPressed: () {
                  setState(() {
                    isAboutEdit = true;
                  });
                },
                icon: Icon(
                  Icons.edit,
                  size: 12,
                  color: Colors.white,
                ),
                label: Text(
                  'Change',
                  style: TextStyle(fontSize: 12, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
        Text(
          _profileStore.Profile_data!.user!.aboutme.toString(),
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w400,
          ),
        ),
      ],
    );
  }

  edit_about() {
    return Column(
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            'About Me',
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.w900),
            textAlign: TextAlign.center,
          ),
        ),
        SizedBox(
          height: 10,
        ),
        TextField(
          controller: _userAboutmeController,
          decoration: InputDecoration(),
        ),
        SizedBox(
          height: 10,
        ),
        SizedBox(
          child: ElevatedButton.icon(
            onPressed: () {
              setState(() {
                updatedata();
                isAboutEdit = false ;
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
      ],
    );
  }

  contact() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: <Widget>[
            Expanded(
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Contact Details',
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w900),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            Align(
              alignment: Alignment.centerRight,
              child: ElevatedButton.icon(
                onPressed: () {
                  setState(() {
                    isContactEdit = true;
                  });
                },
                icon: Icon(
                  Icons.edit,
                  size: 12,
                  color: Colors.white,
                ),
                label: Text(
                  'Change',
                  style: TextStyle(fontSize: 12, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
        Text(
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
            fontSize: 15,
            fontWeight: FontWeight.w400,
          ),
        ),
      ],
    );
  }

  edit_contact() {
    return Column(
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            'Contact Details',
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.w900),
            textAlign: TextAlign.center,
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Container(
          margin: EdgeInsets.all(5),
          child: Column(
            children: [
              TextField(
                controller: _userContactController,
                decoration: InputDecoration(
                  labelText: 'Contact Number',
                  prefixIcon:
                      Icon(Icons.call, size: 30, color: AppColors.primaryColor),
                ),
              ),
            ],
          ),
        ),
        Container(
          margin: EdgeInsets.all(5),
          child: Column(
            children: [
              TextField(
                controller: _userAddressController,
                decoration: InputDecoration(
                  labelText: 'Address',
                  prefixIcon: Icon(Icons.house,
                      size: 30, color: AppColors.primaryColor),
                ),
              ),
            ],
          ),
        ),
        Container(
          margin: EdgeInsets.all(5),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _userCityController,
                  decoration: InputDecoration(
                    labelText: 'City',
                    prefixIcon: Icon(Icons.apartment,
                        size: 30, color: AppColors.primaryColor),
                  ),
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Expanded(
                child: TextField(
                  controller: _userStateController,
                  decoration: InputDecoration(
                    labelText: 'State',
                    prefixIcon: Icon(Icons.location_city,
                        size: 30, color: AppColors.primaryColor),
                  ),
                ),
              ),
            ],
          ),
        ),
        Container(
          margin: EdgeInsets.all(5),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _userCountryController,
                  decoration: InputDecoration(
                    labelText: 'Country',
                    prefixIcon: Icon(Icons.public,
                        size: 30, color: AppColors.primaryColor),
                  ),
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Expanded(
                child: TextField(
                  controller: _userZipController,
                  decoration: InputDecoration(
                    labelText: 'Zip Code',
                    prefixIcon: Icon(Icons.local_post_office,
                        size: 30, color: AppColors.primaryColor),
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 10,
        ),
        ElevatedButton.icon(
          onPressed: () {
            setState(() {
              updatedata();
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
      isTab: true,
      isMenu: true,
      appBar: AppBar(
        shadowColor: Colors.transparent,
        centerTitle: true,
        title: const Text('Profile'),
      ),
      child: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(16.0),
          height: DeviceUtils.getScaledHeight(context, 1.20),
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
