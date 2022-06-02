import 'package:flutter/material.dart';
import 'package:guilt_app/constants/colors.dart';
import 'package:guilt_app/models/Business/MyBusinessResponseModel.dart';
import 'package:guilt_app/utils/Global_methods/GlobalStoreHandler.dart';
import 'package:guilt_app/utils/device/device_utils.dart';
import 'package:guilt_app/utils/routes/routes.dart';
import 'package:guilt_app/widgets/custom_scaffold.dart';

class MyBusiness extends StatefulWidget {
  const MyBusiness({Key? key}) : super(key: key);

  @override
  State<MyBusiness> createState() => _MyBusinessState();
}

class _MyBusinessState extends State<MyBusiness> {
  List<MyBusinessListData> businessList = [];

  @override
  void didChangeDependencies() {
    if (this.mounted) {
      getMyBusinessList();
      super.didChangeDependencies();
    }
  }

  getMyBusinessList() {
    GlobalStoreHandler.postStore.getMyBusinessList('').then((value) {
      setState(() {
        MyBusinessResponseModel val = MyBusinessResponseModel.fromJson(value);
        businessList = val.data?.listData ?? [];
      });
    }).catchError((err) {
      print(err);
    });
  }

  myBusinessListContainer(index) {
    MyBusinessListData business = businessList[index];
    return Card(
      child: Container(
        margin: EdgeInsets.all(8.0),
        child: Row(
          children: [
            Container(
              child: ClipRRect(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(2),
                    bottomLeft: Radius.circular(2)),
                child: Image.network(
                  business!.businessPhotos!.length > 0
                      ? business!.businessPhotos![0].name ?? ''
                      : 'https://i.pinimg.com/474x/e7/0b/30/e70b309ec42e68dbc70972ec96f53839.jpg',
                  width: 70,
                  height: 70,
                  fit: BoxFit.contain,
                ),
              ),
            ),
            SizedBox(
              width: 10,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    business.name ?? 'No Name Added',
                    style: TextStyle(
                      color: AppColors.primaryColor,
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Text(
                    business.location ?? 'No Location Added',
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 10,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
            PopupMenuButton(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(15.0))),
              offset: Offset(-22.0, 40.0),
              icon: Icon(Icons.more_vert),
              itemBuilder: (BuildContext context) =>
              <PopupMenuEntry>[
                const PopupMenuItem(
                  height: 10,
                  padding: EdgeInsets.only(left: 30, top: 10),
                  child: Text(
                    'Edit',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
                const PopupMenuItem(
                  height: 10,
                  padding: EdgeInsets.only(left: 30, top: 15, bottom: 10),
                  child: Text(
                    'Delete',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

    @override
    Widget build(BuildContext context) {
      return ScaffoldWrapper(
        isMenu: false,
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
          title: Text(
            'My Business',
          ),
          centerTitle: true,
        ),
        child: businessList.length > 0
            ? Container(
          child: ListView.builder(
            itemCount: businessList.length,
            itemBuilder: (context, index) =>
                myBusinessListContainer(index),
          ),
        )
            : Center(
          child: Text('No Business Added.'),
        ),
      );
    }
  }