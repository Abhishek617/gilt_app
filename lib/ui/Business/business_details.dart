import 'package:flutter/material.dart';
import 'package:guilt_app/constants/colors.dart';
import 'package:guilt_app/models/Business/BusinessDetailResponseModel.dart';
import 'package:guilt_app/utils/Global_methods/GlobalSocket.dart';
import 'package:guilt_app/utils/Global_methods/GlobalStoreHandler.dart';
import 'package:guilt_app/utils/Global_methods/global.dart';
import 'package:guilt_app/utils/routes/routes.dart';
import 'package:guilt_app/widgets/custom_scaffold.dart';

class BusinessDetail extends StatefulWidget {
  const BusinessDetail({Key? key}) : super(key: key);

  @override
  State<BusinessDetail> createState() => _BusinessDetailState();
}

class _BusinessDetailState extends State<BusinessDetail> {
  BusinessDetailResponseModel? contentData;
  var args;

  @override
  void didChangeDependencies() {
    args = ModalRoute
        .of(context)!
        .settings
        .arguments;
    getDetails(args);
    super.didChangeDependencies();
  }

  Widget getImageContainer(BusinessPhotos photo) {
    return Container(
        height: 100,
        margin: EdgeInsets.only(right: 10, left: 10, top: 10),
        child: Image.network(photo.name.toString()));
  }

  getDetails(args) {
    GlobalMethods.showLoader();
    GlobalStoreHandler.postStore.getBusinessDetail(args).then((value) {
      print(value);
      setState(() {
        contentData = BusinessDetailResponseModel.fromJson(value);
        print('business view');
      });
      GlobalMethods.hideLoader();
    }, onError: (error) {
      GlobalMethods.hideLoader();
      print(error.toString());
    }).catchError((error) {
      GlobalMethods.hideLoader();
      print(error.toString());
    });
  }

  getBusinessDetailContainer() {
    Business b = contentData?.business ?? new Business();
    return contentData != null
        ? Container(
      padding: EdgeInsets.only(left: 16, right: 16, top: 50, bottom: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Align(
            alignment: Alignment.center,
            child: Text(
              b.name ?? 'No Name Added',
              style: TextStyle(
                color: Colors.black,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            'About Business',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w900),
          ),
          Container(
            child: Text(
              b.description ?? 'No Description Added',
              style: TextStyle(
                color: Colors.grey,
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            children: [
              Icon(Icons.location_on,
                  size: 20, color: Theme
                      .of(context)
                      .colorScheme
                      .primary),
              SizedBox(
                width: 10,
              ),
              Flexible(
                child: Text(
                  b.location ?? 'No Address Added',
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
          Row(
            children: [
              Icon(Icons.email,
                  size: 20, color: Theme
                      .of(context)
                      .colorScheme
                      .primary),
              SizedBox(
                width: 10,
              ),
              Text(
                b.email ?? 'No Email Added',
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          Row(
            children: [
              Icon(Icons.phone,
                  size: 20, color: Theme
                      .of(context)
                      .colorScheme
                      .primary),
              SizedBox(
                width: 10,
              ),
              Text(
                b.contact ?? 'No Contact Added',
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          SizedBox(
            height: 20,
          ),
          Text(
            'Business Owner',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w900),
          ),
          GestureDetector(
            onTap: () {
              Routes.navigateToScreenWithArgs(
                  context, Routes.organizerprof, b.createdBy);
            },
            child: Row(children: [
              Icon(Icons.person_rounded,
                  size: 40, color: Theme
                      .of(context)
                      .colorScheme
                      .primary),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      (b.admin?.firstname ?? '') +
                          ' ' +
                          (b.admin?.lastname ?? ''),
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ]),
          ),
          SizedBox(
            height: 20,
          ),
          Divider(
            color: Colors.black12,
            //color of divider
            height: 20,
            //height spacing of divider
            thickness: 1,
            //spacing at the end of divider
          ),
          Text(
            'Business Photos',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w900),
          ),
          SizedBox(
            height: 20,
          ),
          b.businessPhotos?.length == 0
              ? Padding(
            padding: EdgeInsets.only(
                left: 0.0, top: 5.0, bottom: 5.0, right: 20.0),
            child: Text(
              'No any photos added',
              style: TextStyle(
                  fontSize: 14, fontWeight: FontWeight.w500),
            ),
          )
             //   ListView(
             //      scrollDirection: Axis.horizontal,
             //      children: b.businessPhotos!
             //             .map((e) => getImageContainer(e))
             //             .toList(),
             //
             // ),
          //
              :
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
                    child: Row(
            children: b.businessPhotos!
                      .map((e) => getImageContainer(e))
                      .toList(),
          ),
                  ),
          SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: () {
                  if (contentData!.business!.latLong!.coordinates!.isNotEmpty) {
                    double latitude = contentData!.business!.latLong!
                        .coordinates![0];
                    double longitude = contentData!.business!.latLong!
                        .coordinates![1];
                    GlobalMethods.openMap(latitude, longitude);
                  }
                },
                child: Row(
                  children: [
                    Icon(Icons.directions),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      ' Direction ',
                      style: TextStyle(color: Colors.white, fontSize: 12),
                    ),
                  ],
                ),
                style: ButtonStyle(
                    backgroundColor: MaterialStateColor.resolveWith(
                            (states) => AppColors.primaryColor),
                    shape:
                    MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(90.0),
                        ))),
              ),
              ElevatedButton(
                onPressed: () {
                  if (contentData!.business!.contact!.isNotEmpty) {
                    GlobalMethods.launchCaller(contentData!.business!.contact!);
                  }
                },
                child: Row(
                  children: [
                    Icon(Icons.call),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      'Call',
                      style: TextStyle(color: Colors.white, fontSize: 12),
                    ),
                  ],
                ),
                style: ButtonStyle(
                    backgroundColor: MaterialStateColor.resolveWith(
                            (states) => AppColors.primaryColor),
                    shape:
                    MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(90.0),
                        ))),
              ),
              b.createdBy !=
                  GlobalStoreHandler.userStore.Profile_data?.user?.id
                  ? ElevatedButton(
                onPressed: () {
                  GlobalMethods.showLoader();
                  G.socketUtils.emitJoinBusinessChat(b);
                  GlobalMethods.hideLoader();
                  Routes.navigateToScreen(
                      context, Routes.business_chat);
                },
                child: Row(
                  children: [
                    Icon(Icons.chat),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      'Chat',
                      style: TextStyle(
                          color: Colors.white, fontSize: 12),
                    ),
                  ],
                ),
                style: ButtonStyle(
                    backgroundColor: MaterialStateColor.resolveWith(
                            (states) => AppColors.primaryColor),
                    shape: MaterialStateProperty.all<
                        RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(90.0),
                        ))),
              )
                  : Container(),
              // Padding(
              //     padding: EdgeInsets.only(left: 10, top:20, right: 00, bottom: 20),
              //     child: Container(
              //       height: 30,
              //       width: 80,
              //       child: ElevatedButton(
              //         onPressed: () {
              //         },
              //
              //           child: Text(' Cancel ', style: TextStyle(
              //               color: Colors.white, fontSize: 12),),
              //
              //
              //         style: ButtonStyle(
              //             backgroundColor:
              //             MaterialStateColor.resolveWith(
              //                     (states) =>
              //                 Colors.red),
              //             shape: MaterialStateProperty.all<
              //                 RoundedRectangleBorder>(
              //                 RoundedRectangleBorder(
              //                   borderRadius:
              //                   BorderRadius.circular(90.0),
              //                 ))),
              //       ),
              //     )),
            ],
          )
        ],
      ),
    )
        : Center(
      child: Text('No details found'),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldWrapper(
      isMenu: false,
      appBar: AppBar(
        shadowColor: Colors.transparent,
        title: Text('Business Details'),
        centerTitle: true,
      ),
      child: Column(children: [
        Container(
          child: getBusinessDetailContainer(),
        ),
      ]),
    );
  }
}
