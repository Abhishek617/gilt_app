import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:guilt_app/constants/colors.dart';
import 'package:guilt_app/data/repository.dart';
import 'package:guilt_app/di/components/service_locator.dart';
import 'package:guilt_app/stores/user/user_store.dart';
import 'package:guilt_app/utils/Global_methods/global.dart';
import 'package:guilt_app/utils/routes/routes.dart';

class MenuDrawer extends StatelessWidget {
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
                color: AppColors.primaryColour,
              ),
              child: Column(
                children: [
                  // Row(children: [
                  //  Padding(padding:EdgeInsets.only(left: 220.0, top: 0.0, bottom: 00.0, right: 00.0),
                  //    child: IconButton(icon: Icon(Icons.close, size: 20,),
                  //        onPressed: (){
                  //          Navigator.of(context).pop();
                  //       },
                  //      color: Colors.white,

                  // ),
                  //),
                  //]),
                  Row(children: [
                    Column(
                      children: [
                         Stack(
                            children: [
                              Container(
                                padding:EdgeInsets.only(
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

                      padding:  EdgeInsets.only(
                          left: 15.0, top: 23.0, bottom: 00.0, right: 00.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(padding: EdgeInsets.only(bottom: 4),
                            child: Text(
                                'Michael Scott',
                                style: TextStyle(color: Colors.white, fontSize: 18),
                                ),
                          ),
                          Text(
                            'Michael.scott@gmail.com',
                            style: TextStyle(color: Colors.white, fontSize: 14),
                          ),
                        ],
                      ),
                    ),
                  ]),
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
                  onTap: () => {Navigator.of(context).pop()},
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
                  onTap: () => {Navigator.of(context).pop()},
                ),
                ListTile(
                  visualDensity: VisualDensity(horizontal: 0, vertical: -4),
                  trailing: Icon(
                    Icons.arrow_forward_ios,
                    size: 20,
                  ),
                  title: Text(
                    'PAYMENT HISTORY',
                    style: TextStyle(fontWeight: FontWeight.w700),
                  ),
                  onTap: () => {Navigator.of(context).pop()},
                ),
                ListTile(
                  visualDensity: VisualDensity(horizontal: 0, vertical: -4),
                  trailing: Icon(Icons.arrow_forward_ios, size: 20),
                  title: Text(
                    'BOOK EVENT',
                    style: TextStyle(fontWeight: FontWeight.w700),
                  ),
                  onTap: () => {Navigator.of(context).pop()},
                ),
                ListTile(
                  visualDensity: VisualDensity(horizontal: 0, vertical: -4),
                  trailing: Icon(Icons.arrow_forward_ios, size: 20),
                  title: Text(
                    'BECOME A BUSINESS',
                    style: TextStyle(fontWeight: FontWeight.w700),
                  ),
                  onTap: () => {Navigator.of(context).pop()},
                ),
                ListTile(
                  visualDensity: VisualDensity(horizontal: 0, vertical: -4),
                  trailing: Icon(Icons.arrow_forward_ios, size: 20),
                  title: Text(
                    'MESSAGE',
                    style: TextStyle(fontWeight: FontWeight.w700),
                  ),
                  onTap: () => {Navigator.of(context).pop()},
                ),
                ListTile(
                  visualDensity: VisualDensity(horizontal: 0, vertical: -4),
                  trailing: Icon(Icons.arrow_forward_ios, size: 20),
                  title: Text(
                    'ABOUT APP',
                    style: TextStyle(fontWeight: FontWeight.w700),
                  ),
                  onTap: () => {Navigator.of(context).pop()},
                ),
                ListTile(
                  visualDensity: VisualDensity(horizontal: 0, vertical: -4),
                  trailing: Icon(Icons.arrow_forward_ios, size: 20),
                  title: Text(
                    'PAYMENT METHOD',
                    style: TextStyle(fontWeight: FontWeight.w700),
                  ),
                  onTap: () => {Navigator.of(context).pop()},
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
                  onTap: () => {Navigator.of(context).pop()},
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
                          color: AppColors.primaryColour,
                        ),
                        title: Text(
                          'Notification',
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
                          color: AppColors.primaryColour,
                        ),
                        title: Text(
                          'Change Password',
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
                          color: AppColors.primaryColour,
                        ),
                        title: Text(
                          'Settings',
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
                          color: AppColors.primaryColour,
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
                          color: AppColors.primaryColour,
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
                          color: AppColors.primaryColour,
                        ),
                        title: Text(
                          'Terms and Conditions',
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
                          color: AppColors.primaryColour,
                        ),
                        title: Text(
                          'Privacy Policy',
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
                          color: AppColors.primaryColour,
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
