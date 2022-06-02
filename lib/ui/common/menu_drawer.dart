import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:guilt_app/constants/app_settings.dart';
import 'package:guilt_app/constants/colors.dart';
import 'package:guilt_app/data/repository.dart';
import 'package:guilt_app/data/sharedpref/constants/preferences.dart';
import 'package:guilt_app/di/components/service_locator.dart';
import 'package:guilt_app/models/Auth/profile_modal.dart';
import 'package:guilt_app/stores/user/user_store.dart';
import 'package:guilt_app/utils/Global_methods/global.dart';
import 'package:guilt_app/utils/device/device_utils.dart';
import 'package:guilt_app/utils/routes/routes.dart';
import 'package:mobx/mobx.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MenuDrawer extends StatefulWidget {
  @override
  State<MenuDrawer> createState() => _MenuDrawerState();
}

class _MenuDrawerState extends State<MenuDrawer> {
  // late Repository _repository;
  final UserStore _userStore = UserStore(getIt<Repository>());

  @observable
  var userRole = '1';

  @override
  void initState() {
    setUserRole();
    super.initState();
  }

  @override
  void didChangeDependencies() {
    setUserRole();
    super.didChangeDependencies();
  }

  getMenuTile(String title, Function() onTapEvent) {
    return ListTile(
      visualDensity: VisualDensity(horizontal: 0, vertical: -4),
      trailing: Icon(
        Icons.arrow_forward_ios,
        size: 12,
      ),
      title: Text(
        title,
        style: TextStyle(fontWeight: FontWeight.w700),
      ),
      onTap: () {
        Navigator.pop(context);
        onTapEvent();
      },
    );
  }

  getBottomMenuTile(IconData icon, String title, Function() onTapEvent) {
    return ListTile(
      horizontalTitleGap: -10,
      visualDensity: VisualDensity(horizontal: 0, vertical: -4),
      leading: Icon(
        icon,
        size: 20,
        color: AppColors.primaryColor,
      ),
      title: Text(
        title,
        style: TextStyle(fontWeight: FontWeight.w500),
      ),
      onTap: onTapEvent,
    );
  }

  setUserRole() async {
    var role = await _userStore.getUserRole();
    await _userStore.getProfile();
    setState(() {
      userRole = role;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      elevation: 20.0,
      child: Container(
        margin: EdgeInsets.only(bottom: 60),
        child: Column(
          children: <Widget>[
            Container(
              height: 180,
              child: DrawerHeader(
                decoration: BoxDecoration(
                  color: AppColors.primaryColor,
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Column(
                          children: [
                            Stack(
                              children: [
                                Container(
                                  padding: EdgeInsets.only(
                                      left: 2.0,
                                      top: 20.0,
                                      bottom: 00.0,
                                      right: 00.0),
                                  child: Observer(
                                      builder: (_) => _userStore.Profile_data
                                                  ?.user?.profile !=
                                              null
                                          ? Container(
                                              child: ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          100.0),
                                                  child: Image.network(
                                                    _userStore.Profile_data
                                                            ?.user?.profile
                                                            .toString() ??
                                                        'https://th.bing.com/th/id/R.fa0ca630a6a3de8e33e03a009e406acd?rik=UOMXfynJ2FEiVw&riu=http%3a%2f%2fwww.clker.com%2fcliparts%2ff%2fa%2f0%2fc%2f1434020125875430376profile.png&ehk=73x7A%2fh2HgYZLT1q7b6vWMXl86IjYeDhub59EZ8hF14%3d&risl=&pid=ImgRaw&r=0',
                                                    width: DeviceUtils
                                                        .getScaledWidth(
                                                            context, 0.15),
                                                    height: DeviceUtils
                                                        .getScaledWidth(
                                                            context, 0.15),
                                                    fit: BoxFit.cover,
                                                  )))
                                          : Icon(
                                              Icons.account_circle,
                                              size: 70,
                                              color: Colors.white,
                                            )),
                                ),
                              ],
                            ),
                          ],
                        ),
                        Container(
                          padding: EdgeInsets.only(
                              left: 15.0, top: 23.0, bottom: 00.0, right: 00.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Observer(
                                builder: (_) => Text(
                                  (_userStore.Profile_data?.user?.firstname
                                              .toString() ??
                                          '') +
                                      '  ' +
                                      (_userStore.Profile_data?.user?.lastname
                                              .toString() ??
                                          ''),
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Observer(
                                builder: (_) => Text(
                                  _userStore.Profile_data?.user?.email
                                          .toString() ??
                                      '',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 16),
                                ),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Observer(
                                builder: (_) => Text(
                                  _userStore.Profile_data?.user?.roleId
                                              .toString() ==
                                          AppSettings.businessUserRole
                                      ? 'Business Account'
                                      : 'Individual Account',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 14),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    userRole == AppSettings.businessUserRole
                        ? getMenuTile(
                            'ADD BUSINESS',
                            () => {
                                  Routes.navigateToScreen(
                                      context, Routes.add_business)
                                })
                        : Container(),
                    userRole == AppSettings.businessUserRole
                        ? getMenuTile(
                            'MY BUSINESS',
                            () => {
                                  Routes.navigateToScreen(
                                      context, Routes.my_business)
                                })
                        : Container(),
                    userRole == AppSettings.businessUserRole
                        ? getMenuTile(
                            'SEARCH ALL BUSINESS',
                            () => {
                                  Routes.navigateToScreen(
                                      context, Routes.search_all_business)
                                })
                        : Container(),
                    userRole == AppSettings.businessUserRole
                        ? getMenuTile(
                            'PAY/REQUEST BUSINESS',
                            () => {
                                  Routes.navigateToScreen(
                                      context, Routes.pay_request_business)
                                })
                        : Container(),
                    getMenuTile(
                      'INVITE FRIENDS',
                      () => {
                        GlobalMethods.askPermissions(
                            context, Routes.invite_contact)
                      },
                    ),
                    getMenuTile(
                      'EXPENSE HISTORY',
                      () => {
                        Routes.navigateToScreen(context, Routes.expensehistory)
                      },
                    ),
                    getMenuTile(
                      'MY EVENT',
                      () => {
                        Routes.navigateToScreen(context, Routes.my_book_event)
                      },
                    ),
                    getMenuTile(
                      'SEARCH EVENT',
                      () => {
                        Routes.navigateToScreen(context, Routes.search_event)
                      },
                    ),
                    userRole != AppSettings.businessUserRole
                        ? getMenuTile(
                            'BECOME A BUSINESS',
                            () => {
                                  Routes.navigateToScreen(
                                      context, Routes.add_business)
                                })
                        : Container(),
                    getMenuTile(
                      'ABOUT APP',
                      () => {
                        Routes.navigateToScreen(context, Routes.about_screen)
                      },
                    ),
                    // getMenuTile(
                    //   'PAYMENT METHOD',
                    //   () => {
                    //     Navigator.of(context).pop()
                    //     // Routes.navigateRootToScreen(context, Routes.bank_lists),
                    //     // GlobalMethods.showErrorMessage(context, error.message.toString(), 'Logout Error');
                    //   },
                    // ),
                    getMenuTile(
                      'PAYMENT HISTORY',
                      () => {
                        Routes.navigateToScreen(context, Routes.paymenthistory)
                      },
                    ),
                    getMenuTile(
                      'HELP & SUPPORT',
                      () => {
                        Routes.navigateToScreen(
                            context, Routes.help_and_support)
                      },
                    ),
                    getMenuTile(
                      'FAQS',
                      () => {Routes.navigateToScreen(context, Routes.faqs)},
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 70, bottom: 10),
                      child: Column(
                        children: [
                          getBottomMenuTile(
                            Icons.notifications,
                            'Notification',
                            () => {
                              Routes.navigateToScreen(context, Routes.notifi)
                            },
                          ),
                          getBottomMenuTile(
                            Icons.person,
                            'Change Password',
                            () => {
                              Routes.navigateToScreen(
                                  context, Routes.change_old_password)
                            },
                          ),
                          getBottomMenuTile(
                            Icons.settings,
                            'Settings',
                            () => {
                              Routes.navigateToScreen(context, Routes.setting)
                            },
                          ),
                          getBottomMenuTile(
                            Icons.rate_review,
                            'Rate The App',
                            () => {
                              Routes.navigateToScreen(
                                  context, Routes.add_feedback)
                            },
                          ),
                          getBottomMenuTile(
                            Icons.text_snippet,
                            'Terms and Conditions',
                            () => {
                              Routes.navigateToScreen(
                                  context, Routes.terms_conditions)
                            },
                          ),
                          getBottomMenuTile(
                            Icons.policy,
                            'Privacy Policy',
                            () => {
                              Routes.navigateToScreen(
                                  context, Routes.privacy_policy)
                            },
                          ),
                          getBottomMenuTile(
                            Icons.logout,
                            'Log Out',
                            () => {
                              _userStore.logout((response) {
                                print(response);
                                Routes.navigateRootToScreen(
                                    context, Routes.login);
                              }, (error) {
                                Routes.navigateRootToScreen(
                                    context, Routes.login);
                                // GlobalMethods.showErrorMessage(context, error.message.toString(), 'Logout Error');
                              })
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
