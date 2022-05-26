import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:guilt_app/constants/colors.dart';
import 'package:guilt_app/models/Event/SearchEventResponseModel.dart';
import 'package:guilt_app/utils/Global_methods/GlobalStoreHandler.dart';
import 'package:guilt_app/utils/Global_methods/global.dart';
import 'package:guilt_app/utils/device/device_utils.dart';
import 'package:guilt_app/utils/routes/routes.dart';
import 'package:guilt_app/widgets/custom_scaffold.dart';
import 'package:guilt_app/widgets/rounded_button_widget.dart';
import 'package:intl/intl.dart';

class SearchEvent extends StatefulWidget {
  const SearchEvent({Key? key}) : super(key: key);

  @override
  State<SearchEvent> createState() => _SearchEventState();
}

class _SearchEventState extends State<SearchEvent> {
  List<EventItem> eventList = [];

  @override
  initState() {
    GlobalMethods.showLoader();
    searchEvent(' ');
    GlobalMethods.hideLoader();
    super.initState();
  }

  Widget eventItemContainer(EventItem eventItem) {
    print('eventItem');
    print(eventItem);
    if(eventItem != null) {

      var startDate =eventItem.startDate!= null ? DateFormat('dd MMMM yyyy  HH:mma')
          .format(DateTime.parse(eventItem.startDate!)) : 'Start Date Not found';
      var endDate = eventItem.endDate!= null ? DateFormat('dd MMMM yyyy  HH:mma')
          .format(DateTime.parse(eventItem.endDate!)) : 'End Date not found';
      return GestureDetector(
        child: Container(
          padding: EdgeInsets.only(left: 5, top: 10, right: 00, bottom: 0),
          child: Card(
            child: Container(
              margin: EdgeInsets.all(5),
              color: Colors.white,
              alignment: Alignment.center,
              child: Row(
                children: [
                  Column(
                    children: [
                      Image.network(
                        eventItem.eventImages!.length > 0
                            ? eventItem.eventImages![0].file ??
                            'https://i.pinimg.com/474x/e7/0b/30/e70b309ec42e68dbc70972ec96f53839.jpg'
                            : 'https://i.pinimg.com/474x/e7/0b/30/e70b309ec42e68dbc70972ec96f53839.jpg',
                        width: 80,
                        height: 80,
                      ),
                    ],
                  ),
                  SizedBox(width: 8,),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(eventItem.name ?? 'No Name',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 18,
                              fontWeight: FontWeight.w700)),

                      SizedBox(height: 5,),
                      Text(startDate + ' to ' + endDate,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.left,
                          style: TextStyle(
                              color: Colors.grey,
                              fontSize: 12,
                              fontWeight: FontWeight.w400)),
                      Row(
                        children: [
                          Padding(
                              padding: EdgeInsets.only(
                                  left: 00.0,
                                  top: 0.0,
                                  bottom: 00.0,
                                  right: 0.0),
                              child: Icon(
                                  Icons.supervised_user_circle_rounded,
                                  size: 20,
                                  color:
                                  Theme
                                      .of(context)
                                      .colorScheme
                                      .primary)),
                          Padding(
                            padding: EdgeInsets.only(
                                left: 0.0,
                                top: 0.0,
                                bottom: 00.0,
                                right: 00.0),
                            child: Text(
                              (eventItem.eventAttendees!.length < 20
                                  ? eventItem.eventAttendees!.length
                                  .toString()
                                  : '+20') +
                                  ' Attendee(s)',
                              style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          Padding(
                              padding: EdgeInsets.only(left: 56, right: 00),
                              child: Container(
                                padding: EdgeInsets.all(5.0),
                                decoration: BoxDecoration(
                                  borderRadius:
                                  BorderRadius.all(Radius.circular(50)),
                                  color: AppColors.primaryColor,
                                  shape: BoxShape.rectangle,
                                ),
                                child: Text(
                                  eventItem.status!,
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 12),
                                ),
                              )),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
        onTap: () {
          Routes.navigateToScreenWithArgs(
              context, Routes.event_details, eventItem.id);
          // Routes.navigateToScreenWithArgs(
          //     context, Routes.book_event_details, eventItem.id);
        },
      );
    }else{
      return Container();
    }
  }

  Widget _searchTextField() {
    //add
    return TextFormField(
      onChanged: (searchVal) {
        if (searchVal.trim().length > 0) {
          searchEvent(searchVal);
        }
      },
      cursorColor: Colors.white,
      style: TextStyle(color: Colors.white),
      decoration: InputDecoration(
        hintText: 'Search Event',
        hintStyle: TextStyle(color: Colors.grey),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.grey),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.grey),
        ),
      ),
    );
  }

  bool _isSearchBar = false;

  searchEvent(searchQuery) {
    GlobalStoreHandler.postStore
        .getSearchEvent(searchQuery)
        .then((searchEventList) {
      print('searchEvent Response :');
      print(searchEventList);
      var response = SearchEventResponseModal.fromJson(searchEventList);
      setState(() {
        eventList = (response?.eventsList?.listData?.length == 0
            ? []
            : response?.eventsList?.listData)!;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldWrapper(
      isMenu: false,
      appBar: AppBar(
        shadowColor: Colors.transparent,
        title: !_isSearchBar ? Text('Search Event') : _searchTextField(),
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
                      });
                    })
              ]
            : [
                IconButton(
                    icon: Icon(Icons.clear),
                    onPressed: () {
                      setState(() {
                        _isSearchBar = false;
                      });
                    })
              ],
      ),
      child: eventList.length > 0
          ? SingleChildScrollView(
              child: Column(
                children:
                    eventList.map((evt) => eventItemContainer(evt)).toList(),
              ),
            )
          : Center(
              heightFactor: 12.0,
              child: Text(
                'No Event found',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              )),
    );
  }
}
