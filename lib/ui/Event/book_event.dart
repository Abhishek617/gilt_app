import 'package:flutter/material.dart';
import 'package:guilt_app/constants/colors.dart';
import 'package:guilt_app/utils/routes/routes.dart';
import 'package:guilt_app/widgets/custom_scaffold.dart';

class BookEvent extends StatefulWidget {
  const BookEvent({Key? key}) : super(key: key);

  @override
  State<BookEvent> createState() => _BookEventState();
}

class _BookEventState extends State<BookEvent> {
  Event_list() => Container(
        padding: EdgeInsets.only(left: 5, top: 10, right: 00, bottom: 0),
        child: Padding(
          padding: EdgeInsets.only(left: 0, top: 0, right: 00, bottom: 00),
          child: Card(
            child: Container(
              margin: EdgeInsets.all(5),
              width: 370,
              color: Colors.white,
              alignment: Alignment.center,
              child: Row(
                children: [
                  Column(
                    children: [
                      Image.network(
                        'https://i.pinimg.com/474x/e7/0b/30/e70b309ec42e68dbc70972ec96f53839.jpg',
                        width: 80,
                        height: 80,
                      ),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 15),
                    child: Column(
                      children: [
                        Text('Holiday Inn Express Albany',
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 18,
                                fontWeight: FontWeight.w700)),
                        Padding(
                          padding:
                              EdgeInsets.only(right: 25, bottom: 10, top: 10),
                          child: Text('13 January 2022 to 25 January 2022',
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400)),
                        ),
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
                                        Theme.of(context).colorScheme.primary)),
                            Padding(
                              padding: EdgeInsets.only(
                                  left: 0.0,
                                  top: 0.0,
                                  bottom: 00.0,
                                  right: 00.0),
                              child: Text(
                                '+20 Attendees',
                                style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                            Padding(
                                padding: EdgeInsets.only(left: 56, right: 00),
                                child: Container(
                                  height: 20,
                                  child: ElevatedButton(
                                    onPressed: () {
                                      Routes.navigateToScreen(context, Routes.book_event_details);
                                      },
                                    child: Text(
                                      ' BOOKED',
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 8),
                                    ),
                                    style: ButtonStyle(
                                        backgroundColor:
                                            MaterialStateColor.resolveWith(
                                                (states) =>
                                                    AppColors.primaryColour),
                                        shape: MaterialStateProperty.all<
                                                RoundedRectangleBorder>(
                                            RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(90.0),
                                        ))),
                                  ),
                                )),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );

  @override
  Widget build(BuildContext context) {
    return ScaffoldWrapper(
      isMenu: false,
      appBar: AppBar(
        shadowColor: Colors.transparent,
        title: Row(
          children: [
            Text('Book Event'),
            Padding(
                padding: EdgeInsets.only(left: 120),
                child: IconButton(
                  icon: Icon(Icons.circle_notifications),
                  onPressed: () {
                    Routes.navigateToScreen(context, Routes.notifi);
                  },
                )),
          ],
        ),
      ),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              child: Event_list(),
            ),
            Container(
              child: Event_list(),
            ),
            Container(
              child: Event_list(),
            ),
            Container(
              child: Event_list(),
            ),
            Container(
              child: Event_list(),
            ),
            Container(
              child: Event_list(),
            ),
            Container(
              child: Event_list(),
            ),
          ],
        ),
      ),
    );
  }
}
