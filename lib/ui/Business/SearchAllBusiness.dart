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

class SearchAllBusiness extends StatefulWidget {
  const SearchAllBusiness({Key? key}) : super(key: key);

  @override
  State<SearchAllBusiness> createState() => _MyBusinessState();
}

class _MyBusinessState extends State<SearchAllBusiness> {
  List<MyBusinessListData> businessList = [];
  bool _isSearchBar = false;
  String searchQuery = '';

  @override
  void didChangeDependencies() {
    if (this.mounted) {
      getAllBusinessList();
      super.didChangeDependencies();
    }
  }

  getAllBusinessList() {
    GlobalStoreHandler.postStore.getAllBusinessList(searchQuery).then((value) {
      setState(() {
        MyBusinessResponseModel val = MyBusinessResponseModel.fromJson(value);
        businessList = val.data?.listData ?? [];
      });
    }).catchError((err) {
      print(err);
    });
  }

  allBusinessListContainer(index) {
    MyBusinessListData business = businessList[index];
    return GestureDetector(
      onTap: () {
        Routes.navigateToScreenWithArgs(
            context, Routes.business_details, business.id);
      },
      child: Card(
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
            ],
          ),
        ),
      ),
    );
  }

  Widget _searchTextField() {
    //add
    return TextFormField(
      onChanged: (searchVal) {
        if (searchVal.trim().length > 0) {
          setState(() {
            searchQuery = searchVal;
          });
          getAllBusinessList();
        }
      },
      cursorColor: Colors.white,
      style: TextStyle(color: Colors.white),
      decoration: InputDecoration(
        isDense: true,
        hintText: 'Search Business',
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
          title: !_isSearchBar ? Text('All Business') : _searchTextField(),
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
                          getAllBusinessList();
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
                          getAllBusinessList();
                        });
                      })
                ],
        ),
        body: CustomBodyWrapper(
          child: businessList.length > 0
              ? Container(
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: businessList.length,
                    itemBuilder: (context, index) =>
                        allBusinessListContainer(index),
                  ),
                )
              : Center(
                  child: Text('No Business Found.'),
                ),
        ));
  }
}
