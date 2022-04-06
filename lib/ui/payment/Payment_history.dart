import 'package:flutter/material.dart';
import '../../constants/colors.dart';
import '../../utils/device/device_utils.dart';
import '../../widgets/custom_scaffold.dart';

class PaymentHistory extends StatefulWidget {
  const PaymentHistory({Key? key}) : super(key: key);

  @override
  State<PaymentHistory> createState() => _PaymentHistoryState();
}

class _PaymentHistoryState extends State<PaymentHistory> {
  Widget Payment_paid_list() => Column(children: [
    Container(
      padding: EdgeInsets.only(top: 5, bottom: 5),
      child: Row(
        children: [
          Align(
            alignment: Alignment.center,
            child: Stack(
              children: [
                Container(
                  padding: const EdgeInsets.only(
                      left: 25.0, top: 00.0, bottom: 00.0, right: 0.0),
                  child: Image.network(
                    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSnngxCpo8jS7WE_uNWmlP4bME_IZkXWKYMzhM2Qi1JE_J-l_4SZQiGclMuNr4acfenazo&usqp=CAU',
                    width: 50,
                    height: 50,
                    fit: BoxFit.cover,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 10,
            width: 10,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Paid to Jo Malone',
                style: TextStyle(
                  color: AppColors.primaryColor,
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(
                height: 5,
                width: 10,
              ),
              Text(
                'Today, 03:40 PM',
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 10,
                  fontWeight: FontWeight.w500,
                ),
              ),

            ],
          ),

          Padding(
            padding:
            EdgeInsets.only(top: 00, left: 98, right: 25, bottom: 15),
            child: Column(
              children: [
                Text(
                  '- \$170.0',
                  style: TextStyle(
                    color: Colors.red,
                    fontSize: 10,
                    fontWeight: FontWeight.w600,
                  ),
                ),

              ],
            ),
          ),
        ],
      ),
    ),
    Divider(
      color: Colors.black12,
      //color of divider
      height: 20,
      //height spacing of divider
      thickness: 1,
      //thickness of divier line
      indent: 20,
      //spacing at the start of divider
      endIndent: 20, //spacing at the end of divider
    ),
  ],
  );
  Payment_recived_list() => Column(children: [
     Container(
          padding: EdgeInsets.only(top: 5, bottom: 5),
          child: Row(
            children: [
              Align(
                alignment: Alignment.center,
                child: Stack(
                  children: [
                    Container(
                      padding: const EdgeInsets.only(
                          left: 25.0, top: 00.0, bottom: 00.0, right: 0.0),
                      child: Image.network(
                        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSnngxCpo8jS7WE_uNWmlP4bME_IZkXWKYMzhM2Qi1JE_J-l_4SZQiGclMuNr4acfenazo&usqp=CAU',
                        width: 50,
                        height: 50,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ],
                ),
              ),
SizedBox(
    height: 10,
    width: 10,
),
                 Column(
                   crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Money Recived to Jo Malone',
                      style: TextStyle(
                        color: AppColors.primaryColor,
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(
                      height: 5,
                      width: 10,
                    ),
                      Text(
                        'Today, 03:40 PM',
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 10,
                          fontWeight: FontWeight.w500,
                        ),
                      ),

                  ],
                ),

              Padding(
                padding:
                    EdgeInsets.only(top: 00, left: 28, right: 25, bottom: 15),
                child: Column(
                  children: [
                    Text(
                      '+ \$170.0',
                      style: TextStyle(
                        color: Colors.green,
                        fontSize: 10,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
    Divider(
      color: Colors.black12,
      //color of divider
      height: 20,
      //height spacing of divider
      thickness: 1,
      //thickness of divier line
      indent: 20,
      //spacing at the start of divider
      endIndent: 20, //spacing at the end of divider
    ),
  ],
  );
  List<String> item = [' b', 'c ', ' d', ' r', 'n ', 'y', 'f', 'm'' b', 'c ', ' d', ' r'];

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
        title: Text('       Payment History'),
      ),

      child:Column(children: [
        SizedBox(
          height: 10,
          width: 10,
        ),
         Container(
          height: DeviceUtils.getScaledHeight(context, 0.85),
         child:ListView.builder(
           itemCount: item.length,
            scrollDirection: Axis.vertical,
    itemBuilder: (context, index) =>
       index.isOdd ? Payment_paid_list() : Payment_recived_list(),
            ),
          ),
  ],
      ),
    );
  }
}
