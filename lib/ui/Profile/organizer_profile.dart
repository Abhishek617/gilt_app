import 'package:flutter/material.dart';
import '../../widgets/custom_scaffold.dart';

class OrganizerProfile extends StatefulWidget {
  const OrganizerProfile({Key? key}) : super(key: key);

  @override
  State<OrganizerProfile> createState() => _OrganizerProfileState();
}

class _OrganizerProfileState extends State<OrganizerProfile> {
  @override
  Widget build(BuildContext context) {
    return ScaffoldWrapper(
        isMenu: false,
        appBar: AppBar(
        shadowColor: Colors.transparent,
        title: Text('Organizer Profile'),
    ),
    child: Column(
    children: [
      Column(children: [
        Align(
          alignment: Alignment.center,
          child: Stack(
            children: [
              Container(
                padding: const EdgeInsets.only(
                    left: 25.0, top: 30.0, bottom: 00.0, right: 00.0),
                child: Image.network(
                  'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSnngxCpo8jS7WE_uNWmlP4bME_IZkXWKYMzhM2Qi1JE_J-l_4SZQiGclMuNr4acfenazo&usqp=CAU',
                  width: 80,
                  height: 80,
                  fit: BoxFit.cover,
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.only(
              left: 25.0, top: 3.0, bottom: 00.0, right: 10.0),
          child: Text(
            'Michael Scott',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],)

    ]),
    );
  }
}
