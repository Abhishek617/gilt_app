import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:guilt_app/constants/colors.dart';
import 'package:guilt_app/data/repository.dart';
import 'package:guilt_app/data/sharedpref/constants/preferences.dart';
import 'package:guilt_app/di/components/service_locator.dart';
import 'package:guilt_app/models/Auth/profile_modal.dart';
import 'package:guilt_app/stores/user/user_store.dart';
import 'package:guilt_app/utils/Global_methods/global.dart';
import 'package:guilt_app/utils/routes/routes.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MenuDrawer extends StatelessWidget {
  // late Repository _repository;
  // late GetProfileResponseModal profileData = _repository.profileData.then((value) => value) as GetProfileResponseModal;
  final UserStore _userStore = UserStore(getIt<Repository>());

  @override
  Widget build(BuildContext context) {
    return Drawer(
      elevation: 20.0,
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
                                child: Icon(
                                  Icons.account_circle,
                                  size: 70,
                                  color: Colors.white,
                                ),
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
                            Padding(
                              padding: EdgeInsets.only(bottom: 4),
                              child: Text(
                                _userStore.Profile_data!.user!.firstname
                                        .toString() +
                                    '  ' +
                                    _userStore.Profile_data!.user!.lastname
                                        .toString(),
                                style: TextStyle(
                                    color: Colors.white, fontSize: 18),
                              ),
                            ),
                            Text(
                              _userStore.Profile_data!.user!.email.toString(),
                              style:
                                  TextStyle(color: Colors.white, fontSize: 14),
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
            child:Column(
              children: [
                ListTile(
                  visualDensity: VisualDensity(horizontal: 0, vertical: -4),
                  trailing: Icon(
                    Icons.arrow_forward_ios,
                    size: 20,
                  ),
                  title: Text(
                    'ADD EVENT',
                    style: TextStyle(fontWeight: FontWeight.w700),
                  ),
                  onTap: () => {Routes.navigateToScreen(
                      context, Routes.create_event)},
                ),
                ListTile(
                  visualDensity: VisualDensity(horizontal: 0, vertical: -4),
                  trailing: Icon(
                    Icons.arrow_forward_ios,
                    size: 20,
                  ),
                  title: Text(
                    'INVITE FRIENDS',
                    style: TextStyle(fontWeight: FontWeight.w700),
                  ),
                  onTap: () => {  Routes.navigateToScreen(context, Routes.map)},
                ),
                ListTile(
                  visualDensity: VisualDensity(horizontal: 0, vertical: -4),
                  trailing: Icon(
                    Icons.arrow_forward_ios,
                    size: 20,
                  ),
                  title: Text(
                    'EXPENSE HISTORY',
                    style: TextStyle(fontWeight: FontWeight.w700),
                  ),
                  onTap: () => {Routes.navigateToScreen(context, Routes.expensehistory)},
                ),
                ListTile(
                  visualDensity: VisualDensity(horizontal: 0, vertical: -4),
                  trailing: Icon(Icons.arrow_forward_ios, size: 20),
                  title: Text(
                    'BOOK EVENT',
                    style: TextStyle(fontWeight: FontWeight.w700),
                  ),
                  onTap: () => {Routes.navigateToScreen(context, Routes.book_event)},
                ),
                ListTile(
                  visualDensity: VisualDensity(horizontal: 0, vertical: -4),
                  trailing: Icon(Icons.arrow_forward_ios, size: 20),
                  title: Text(
                    'BECOME A BUSINESS',
                    style: TextStyle(fontWeight: FontWeight.w700),
                  ),
                  onTap: () => {  Routes.navigateToScreen(
                  context, Routes.add_business)},
                ),
                ListTile(
                  visualDensity: VisualDensity(horizontal: 0, vertical: -4),
                  trailing: Icon(Icons.arrow_forward_ios, size: 20),
                  title: Text(
                    'MESSAGE',
                    style: TextStyle(fontWeight: FontWeight.w700),
                  ),
                  onTap: () => {Routes.navigateToScreen(
                      context, Routes.success_message)},
                ),
                ListTile(
                  visualDensity: VisualDensity(horizontal: 0, vertical: -4),
                  trailing: Icon(Icons.arrow_forward_ios, size: 20),
                  title: Text(
                    'ABOUT APP',
                    style: TextStyle(fontWeight: FontWeight.w700),
                  ),
                  onTap: () => {Routes.navigateToScreen(
                      context, Routes.about_screen)},
                ),
                ListTile(
                  visualDensity: VisualDensity(horizontal: 0, vertical: -4),
                  trailing: Icon(Icons.arrow_forward_ios, size: 20),
                  title: Text(
                    'PAYMENT METHOD',
                    style: TextStyle(fontWeight: FontWeight.w700),
                  ),
                  onTap: () => {
                  Routes.navigateRootToScreen(context, Routes.bank_lists),
                  // GlobalMethods.showErrorMessage(context, error.message.toString(), 'Logout Error');
                },
                ),
                ListTile(
                  visualDensity: VisualDensity(horizontal: 0, vertical: -4),
                  trailing: Icon(Icons.arrow_forward_ios, size: 20),
                  title: Text(
                    'PAYMENT HISTORY',
                    style: TextStyle(fontWeight: FontWeight.w700),
                  ),
                  onTap: () => {Routes.navigateToScreen(
                      context, Routes.paymenthistory)},
                ),
                ListTile(
                  visualDensity: VisualDensity(horizontal: 0, vertical: -4),
                  trailing: Icon(Icons.arrow_forward_ios, size: 20),
                  title: Text(
                    'Wallet',
                    style: TextStyle(fontWeight: FontWeight.w700),
                  ),
                  onTap: () => {Routes.navigateToScreen(
                      context, Routes.wallet)},
                ),
                ListTile(
                  visualDensity: VisualDensity(horizontal: 0, vertical: -4),
                  trailing: Icon(Icons.arrow_forward_ios, size: 20),
                  title: Text(
                    'HELP & SUPPORT',
                    style: TextStyle(fontWeight: FontWeight.w700),
                  ),
                  onTap: () => {Navigator.of(context).pop()},
                ),
                ListTile(
                  visualDensity: VisualDensity(horizontal: 0, vertical: -4),
                  trailing: Icon(Icons.arrow_forward_ios, size: 20),
                  title: Text(
                    'FAQS',
                    style: TextStyle(fontWeight: FontWeight.w700),
                  ),
                  onTap: () => {Routes.navigateToScreen(context, Routes.faqs)},
                ),
                Padding(
                  padding: EdgeInsets.only(top: 70, bottom: 10),
                  child: Column(
                    children: [
                      ListTile(
                        horizontalTitleGap: -10,
                        visualDensity: VisualDensity(horizontal: 0, vertical: -4),
                        leading: Icon(
                          Icons.settings,
                          size: 20,
                          color: AppColors.primaryColor,
                        ),
                        title: Text(
                          'Notification',
                          style: TextStyle(fontWeight: FontWeight.w500),
                        ),
                        onTap: () => {  Routes.navigateToScreen(context, Routes.notifi)},
                      ),
                      ListTile(
                        horizontalTitleGap: -10,
                        visualDensity: VisualDensity(horizontal: 0, vertical: -4),
                        leading: Icon(
                          Icons.settings,
                          size: 20,
                          color: AppColors.primaryColor,
                        ),
                        title: Text(
                          'Change Password',
                          style: TextStyle(fontWeight: FontWeight.w500),
                        ),
                        onTap: () => {
                          Routes.navigateToScreen(context, Routes.reset_password)
                        },
                      ),
                      ListTile(
                        horizontalTitleGap: -10,
                        visualDensity: VisualDensity(horizontal: 0, vertical: -4),
                        leading: Icon(
                          Icons.settings,
                          size: 20,
                          color: AppColors.primaryColor,
                        ),
                        title: Text(
                          'Settings',
                          style: TextStyle(fontWeight: FontWeight.w500),
                        ),
                        onTap: () => { Routes.navigateToScreen(context, Routes.setting)},
                      ),
                      ListTile(
                        horizontalTitleGap: -10,
                        visualDensity: VisualDensity(horizontal: 0, vertical: -4),
                        leading: Icon(
                          Icons.settings,
                          size: 20,
                          color: AppColors.primaryColor,
                        ),
                        title: Text(
                          'Profile',
                          style: TextStyle(fontWeight: FontWeight.w500),
                        ),
                        onTap: () => {Routes.navigateToScreen(context, Routes.view_profile)},
                      ),
                      ListTile(
                        horizontalTitleGap: -10,
                        visualDensity: VisualDensity(horizontal: 0, vertical: -4),
                        leading: Icon(
                          Icons.settings,
                          size: 20,
                          color: AppColors.primaryColor,
                        ),
                        title: Text(
                          'Rate The App',
                          style: TextStyle(fontWeight: FontWeight.w500),
                        ),
                        onTap: () => {Navigator.of(context).pop()},
                      ),
                      ListTile(
                        horizontalTitleGap: -10,
                        visualDensity: VisualDensity(horizontal: 0, vertical: -4),
                        leading: Icon(
                          Icons.settings,
                          size: 20,
                          color: AppColors.primaryColor,
                        ),
                        title: Text(
                          'Terms and Conditions',
                          style: TextStyle(fontWeight: FontWeight.w500),
                        ),
                        onTap: () => {
                          Routes.navigateToScreen(context, Routes.terms_conditions)
                        },
                      ),
                      ListTile(
                        horizontalTitleGap: -10,
                        visualDensity: VisualDensity(horizontal: 0, vertical: -4),
                        leading: Icon(
                          Icons.settings,
                          size: 20,
                          color: AppColors.primaryColor,
                        ),
                        title: Text(
                          'Privacy Policy',
                          style: TextStyle(fontWeight: FontWeight.w500),
                        ),
                        onTap: () => {
                          Routes.navigateToScreen(context, Routes.privacy_policy)
                        },
                      ),
                      ListTile(
                        horizontalTitleGap: -10,
                        visualDensity: VisualDensity(horizontal: 0, vertical: -4),
                        leading: Icon(
                          Icons.settings,
                          size: 20,
                          color: AppColors.primaryColor,
                        ),
                        title: Text(
                          'Log Out',
                          style: TextStyle(fontWeight: FontWeight.w500),
                        ),
                        onTap: () => {
                          _userStore.logout((response){
                            print(response);
                            Routes.navigateRootToScreen(context, Routes.login);
                          }, (error){
                            Routes.navigateRootToScreen(context, Routes.login);
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
    );
  }
}
