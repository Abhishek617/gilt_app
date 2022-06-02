import 'package:flutter/material.dart';
import 'package:guilt_app/constants/colors.dart';
import 'package:guilt_app/models/Auth/commonModal.dart';
import 'package:guilt_app/models/Business/MyBusinessResponseModel.dart';
import 'package:guilt_app/utils/Global_methods/GlobalStoreHandler.dart';
import 'package:guilt_app/utils/Global_methods/global.dart';
import 'package:guilt_app/utils/device/device_utils.dart';
import 'package:guilt_app/utils/routes/routes.dart';
import 'package:guilt_app/widgets/custom_body_wrapper.dart';
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

  editBusiness(businessData, businessIndex) {}

  deleteBusinessRequest(MyBusinessListData businessData, businessIndex) {
    GlobalStoreHandler.postStore.deleteBusiness(businessData.id).then((value) {
      CommonResponseModal res = CommonResponseModal.fromJson(value);
      if (res.success == true) {
        GlobalMethods.showSuccessMessage(
            context, res.message ?? 'Delete successfully.', 'Delete Business');

        getMyBusinessList();
      } else {
        GlobalMethods.showErrorMessage(
            context, res.message ?? 'Delete failed.', 'Delete Business');
      }
    }).catchError((err) {
      GlobalMethods.showErrorMessage(
          context, err.message ?? 'Delete failed.', 'Delete Business');
      print(err);
    });
  }

  deleteBusiness(context, businessData, businessIndex) {
    FocusScope.of(context).unfocus();

    // set up the buttons
    Widget cancelButton = TextButton(
      child: Text("Yes"),
      onPressed: () {
        deleteBusinessRequest(businessData, businessIndex);
        Navigator.of(context).pop();
      },
    );
    Widget continueButton = TextButton(
      child: Text("No"),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Delete Business"),
      content: Text("Are you sure?"),
      actions: [
        cancelButton,
        continueButton,
      ],
    );

    // show the dialog
    Future.delayed(Duration(milliseconds: 300)).then((value) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return alert;
        },
      );
    });
  }

  myBusinessListContainer(index) {
    MyBusinessListData business = businessList[index];
    return GestureDetector(
      onTap: (){
        Routes.navigateToScreenWithArgs(context, Routes.business_details, business.id);
      },
      child: Card(
        child: Container(
          margin: EdgeInsets.all(8.0),
          child: Flexible(
            child: Row(
              children: [
                Container(
                  child: ClipRRect(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(2),
                        bottomLeft: Radius.circular(2)),
                    child: Image.network(
                      business!.businessPhotos!.length > 0
                          ? business!.businessPhotos![0]!.name!
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
                  itemBuilder: (BuildContext context) => <PopupMenuEntry>[
                    PopupMenuItem(
                      onTap: () {
                        editBusiness(business, index);
                      },
                      height: 10,
                      padding: EdgeInsets.only(left: 30, top: 10),
                      child: Text(
                        'Edit',
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                    PopupMenuItem(
                      onTap: () {
                        deleteBusiness(context, business, index);
                      },
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
        ),
      ),
    );
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
          title: Text(
            'My Business',
          ),
          centerTitle: true,
        ),
        body: CustomBodyWrapper(
          child: businessList.length > 0
              ? Container(
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: businessList.length,
                  itemBuilder: (context, index) =>
                      myBusinessListContainer(index),
                ),
              )
              : Center(
                  child: Text('No Business Added.'),
                ),
        ));
  }
}
