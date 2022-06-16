import 'package:flutter/material.dart';
import 'package:guilt_app/constants/colors.dart';
import 'package:guilt_app/models/payment/payment_history_master.dart';
import 'package:guilt_app/utils/Global_methods/GlobalSocket.dart';
import 'package:guilt_app/utils/Global_methods/GlobalStoreHandler.dart';
import 'package:guilt_app/utils/device/device_utils.dart';
import 'package:guilt_app/widgets/custom_scaffold.dart';

class PaymentHistory extends StatefulWidget {
  const PaymentHistory({Key? key}) : super(key: key);

  @override
  State<PaymentHistory> createState() => _PaymentHistoryState();
}

class _PaymentHistoryState extends State<PaymentHistory> {
  List<HistoryItem> cardList = [];

  getPaymentHistory() async {
    GlobalStoreHandler.userStore.getPaymentHistory(0, 10,
        (PaymentHistoryResponseModel master) {
      if (master != null) {
        setState(() {
          cardList = master.history?.listData ?? [];
        });
      }
    }, (error) {
      print(error.toString());
    });
  }

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      getPaymentHistory();
    });
  }

  Payment_recived_list() => Column(
        children: [
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
        title: Text('Payment History'),
        centerTitle: true,
      ),
      child: Column(
        children: [
          SizedBox(
            height: 10,
            width: 10,
          ),
          Container(
            height: DeviceUtils.getScaledHeight(context, 0.85),
            child: ListView.builder(
                itemCount: cardList.length,
                scrollDirection: Axis.vertical,
                itemBuilder: (context, index) {
                  return PaymentHistoryItem(cardItem: cardList[index], );
                }),
          ),
        ],
      ),
    );
  }
}

class PaymentHistoryItem extends StatelessWidget {
  final  HistoryItem cardItem;
  const PaymentHistoryItem({Key? key, required this.cardItem, }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.only(top: 25, bottom: 5 ,left: 10,right: 10),
          child: Row(
            children: [
              SizedBox(
                height: 10,
                width: 10,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      cardItem?.message ?? 'No Message',
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
                     // DateTime.parse(cardItem!.updatedAt!).toLocal().toString(),
                     G.convertToAgo(DateTime.parse(cardItem!.updatedAt!)),
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 10,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
              Column(
                children: [
                  Text(
                    (cardItem!.type == 'debit' ? '- \$' : '+ \$') + cardItem!.amount!.toString(),
                    style: TextStyle(
                      color: (cardItem!.type == 'debit' ? Colors.red : Colors.green),
                      fontSize: 10,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    cardItem!.status!.toString(),
                    style: TextStyle(
                      color: (cardItem!.type == 'debit' ? Colors.red : Colors.green),
                      fontSize: 10,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
                width: 10,
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
  }
}
