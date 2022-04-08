import 'dart:async';

import 'package:flutter/material.dart';
import 'package:guilt_app/constants/colors.dart';

import '../../utils/device/device_utils.dart';
import '../../widgets/custom_scaffold.dart';

class AddMoney extends StatefulWidget {
  const AddMoney({Key? key}) : super(key: key);

  @override
  State<AddMoney> createState() => _AddMoneyState();
}

class _AddMoneyState extends State<AddMoney> {
  moneylist() => Row(
        children: [
          SizedBox(
            width: 15,
          ),
          Column(
            children: [
              Align(
                alignment: Alignment.center,
                child: Stack(
                  children: [
                    Container(
                      child: Image.network(
                        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSnngxCpo8jS7WE_uNWmlP4bME_IZkXWKYMzhM2Qi1JE_J-l_4SZQiGclMuNr4acfenazo&usqp=CAU',
                        width: 55,
                        height: 55,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Text(
                'Pamela',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ],
      );

  List<String> item = [
    ' b',
    'c ',
    ' d',
    ' b',
    'c ',
    ' d',
    ' r',
    'n ',
  ];
  final _controller = TextEditingController();
  final _streamController = StreamController<int>();

  Stream<int> get _stream => _streamController.stream;

  Sink<int> get _sink => _streamController.sink;
  int initValue = 1;

  @override
  void initState() {
    _sink.add(initValue);
    _stream.listen((event) => _controller.text = event.toString());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldWrapper(
      isMenu: false,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back_ios_rounded,
            size: 17,
          ),
        ),
        shadowColor: Colors.transparent,
        title: Text('Add Money'),
        centerTitle: true,
      ),
      child: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 20,
            ),
            Row(
              children: [
                SizedBox(
                  width: 20,
                ),
                Text(
                  'Add Money To Wallet',
                  style: TextStyle(
                    color: AppColors.primaryColor,
                    fontSize: 20,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: 20,
                ),
                Column(
                  children: [
                    FloatingActionButton(
                      onPressed: null,
                      disabledElevation: 0,
                      backgroundColor: Colors.green,
                      child: Icon(Icons.add),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      'New',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  width: 10,
                ),
                Row(
                  children: [
                    Container(
                      width: DeviceUtils.getScaledWidth(context, 0.761),
                      height: DeviceUtils.getScaledHeight(context, 0.12),
                      child: ListView.builder(
                        itemCount: item.length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) => moneylist(),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(
              height: 70,
            ),
            Align(
              alignment: Alignment.center,
              child: Stack(
                children: [
                  Container(
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
            SizedBox(
              height: 5,
            ),
            Text(
              'Paying Michael Scott',
              style: TextStyle(
                color: Colors.black,
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                    onPressed: () {
                      _sink.add(--initValue);
                    },
                    child: Icon(Icons.remove)),
                Container(
                  width: 130,
                  height: 40,
                  child: TextField(
                    controller: _controller,
                  ),
                ),
                TextButton(
                    onPressed: () {
                      _sink.add(++initValue);
                    },
                    child: Icon(Icons.add)),
              ],
            ),
            SizedBox(
              height: DeviceUtils.getScaledHeight(context, 0.20),
            ),
            SizedBox(
              width: DeviceUtils.getScaledWidth(context, 0.80),
              height: DeviceUtils.getScaledHeight(context, 0.070),
              child: RaisedButton(
                onPressed: () {},
                padding: const EdgeInsets.only(left: 20, right: 20),
                color: AppColors.primaryColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Row(
                  children: <Widget>[
                    Text("                     Add Money",
                        style: TextStyle(color: Colors.white)),
                    SizedBox(
                      width: DeviceUtils.getScaledWidth(context, 0.2),
                    ),
                    SizedBox(
                      width: DeviceUtils.getScaledWidth(context, 0.08),
                      height: DeviceUtils.getScaledHeight(context, 0.07),
                      child: CircleAvatar(
                        backgroundColor: Colors.white38,
                        child: Icon(Icons.arrow_forward, color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _streamController.close();
    _controller.dispose();
    super.dispose();
  }
}
