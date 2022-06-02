import 'package:flutter/material.dart';
import 'package:guilt_app/constants/colors.dart';
import 'package:guilt_app/models/Auth/AllUserResponseModel.dart';
import 'package:guilt_app/utils/Global_methods/GlobalStoreHandler.dart';
import 'package:guilt_app/widgets/custom_body_wrapper.dart';
import '../../utils/device/device_utils.dart';
import '../../utils/routes/routes.dart';
import '../../widgets/custom_scaffold.dart';

class SearchUserForBusinessPayment extends StatefulWidget {
  const SearchUserForBusinessPayment({Key? key}) : super(key: key);

  @override
  State<SearchUserForBusinessPayment> createState() =>
      _SearchUserForBusinessPaymentState();
}

class _SearchUserForBusinessPaymentState
    extends State<SearchUserForBusinessPayment> {
  bool _isSearchBar = false;
  String searchQuery = '';
  List<SearchUserData> userList = [];

  Widget _searchTextField() {
    //add
    return TextFormField(
      onChanged: (searchVal) {
        if (searchVal.trim().length > 0) {
          setState(() {
            searchQuery = searchVal;
          });
          getUserList();
        }
      },
      cursorColor: Colors.white,
      style: TextStyle(color: Colors.white),
      decoration: InputDecoration(
        isDense: true,
        hintText: 'Search User',
        hintStyle: TextStyle(color: AppColors.cream_app),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: AppColors.cream_app),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
        ),
      ),
    );
  }

  Widget getUserTileContainer(index) {
    var user = userList[index];
    var uname = (user.firstname ?? 'No') + ' ' + (user.lastname ?? 'Name');
    return ListTile(
        title: Text(uname),
        subtitle: Text(user.phone ?? 'NA'),
        leading: CircleAvatar(
          backgroundImage: NetworkImage(
              'https://cdn-icons-png.flaticon.com/512/1077/1077012.png'),
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18), // <-- Radius
                ),
              ),
              child: Text(
                'PAY',
                style: TextStyle(
                  fontSize: 12,
                ),
              ),
              onPressed: () {
                Routes.navigateToScreenWithArgs(
                    context,
                    Routes.pay_request_business_payment,
                    {"type": 'Pay', "userData": user});
              },
            ),
            SizedBox(
              width: 10,
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18), // <-- Radius
                ),
              ),
              child: Text(
                'REQUEST',
                style: TextStyle(
                  fontSize: 12,
                ),
              ),
              onPressed: () {
                Routes.navigateToScreenWithArgs(
                    context,
                    Routes.pay_request_business_payment,
                    {"type": 'Request', "userData": user});
              },
            ),
          ],
        ));
  }

  getUserList() {
    GlobalStoreHandler.postStore.getAllUserList(searchQuery).then((value) {
      setState(() {
        AllUserResponseModel val = AllUserResponseModel.fromJson(value);
        userList = val.data ?? [];
      });
    }).catchError((err) {
      print(err);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        shadowColor: Colors.transparent,
        leading: GestureDetector(
          onTap: () {
            Routes.goBack(context);
          },
          child: Icon(
            Icons.arrow_back_ios_outlined,
            //color: Colors.black,
            size: 16,
          ),
        ),
        title: !_isSearchBar ? Text('Search User') : _searchTextField(),
        centerTitle: true,
        actions: !_isSearchBar
            ? [
                //add
                IconButton(
                    icon: Icon(Icons.search),
                    onPressed: () {
                      setState(() {
                        //add
                        _isSearchBar = true;
                        searchQuery = '';
                        userList = [];
                      });
                    })
              ]
            : [
                IconButton(
                    icon: Icon(Icons.clear),
                    onPressed: () {
                      setState(() {
                        _isSearchBar = false;
                        searchQuery = '';
                        userList = [];
                      });
                    })
              ],
      ),
      body: CustomBodyWrapper(
        child: userList.length > 0
            ? Column(
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  Expanded(
                      child: ListView.separated(
                    itemCount: userList.length,
                    separatorBuilder: (BuildContext context, int index) =>
                        const Divider(),
                    itemBuilder: (context, index) =>
                        getUserTileContainer(index),
                  )),
                ],
              )
            : Center(
                child: Text('Please search user to get results'),
              ),
      ),
    );
  }
}
