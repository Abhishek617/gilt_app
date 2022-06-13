import 'package:flutter/material.dart';
import 'package:guilt_app/constants/colors.dart';
import 'package:guilt_app/models/payment/payment_history_master.dart';
import 'package:guilt_app/models/payment/wallet_balance_master.dart';
import 'package:guilt_app/ui/common/menu_drawer.dart';
import 'package:guilt_app/ui/payment/Payment_history.dart';
import 'package:guilt_app/utils/Global_methods/GlobalStoreHandler.dart';
import 'package:guilt_app/utils/device/device_utils.dart';
import 'package:guilt_app/utils/routes/routes.dart';
import 'package:guilt_app/widgets/custom_body_wrapper.dart';
import 'package:guilt_app/widgets/rounded_button_widget.dart';

class Wallet extends StatefulWidget {
  const Wallet({Key? key}) : super(key: key);

  @override
  State<Wallet> createState() => _WalletState();
}

class _WalletState extends State<Wallet> {
  int mWalletBalance = 0;
  List<HistoryItem> cardList = [];
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      getMyWalletBalance();
      getPaymentHistory();
    });
  }


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

  Widget paymentPaidList() => Column(
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
            //thickness of divider line
            indent: 20,
            //spacing at the start of divider
            endIndent: 20, //spacing at the end of divider
          ),
        ],
      );

  paymentReceivedList() => Column(
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
                      'Money Received to Jo Malone',
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
            //thickness of divider line
            indent: 20,
            //spacing at the start of divider
            endIndent: 20, //spacing at the end of divider
          ),
        ],
      );
  List<String> item = [
    ' b',
    'c ',
    ' d',
    ' r',
    'n ',
    'y',
    'f',
    'm' ' b',
    'c ',
    ' d',
    ' r'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MenuDrawer(),
      appBar: AppBar(
        shadowColor: Colors.transparent,
        title: Text('Wallet'),
        centerTitle: true,
        actions: [
          IconButton(
            padding: EdgeInsets.only(
                left: 00.0, top: 10.0, bottom: 5.0, right: 00.0),
            icon: Icon(Icons.circle_notifications),
            onPressed: () {
              Routes.navigateToScreen(context, Routes.notifi);
            },
          ),
        ],
      ),
      body: CustomBodyWrapper(
        child: SingleChildScrollView(
          padding: EdgeInsets.only(bottom: 80),
          child: Column(
            children: [
              Row(
                children: [
                  SizedBox(
                    height: 20,
                    width: 20,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 30,
                        width: 50,
                      ),
                      Text(
                        'Last Updated Balance',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      SizedBox(
                        height: 5,
                        width: 70,
                      ),
                      Text(
                        '\$$mWalletBalance',
                        style: TextStyle(
                          color: AppColors.primaryColor,
                          fontSize: 24,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                      SizedBox(
                        height: 5,
                        width: 70,
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.check_box,
                            color: AppColors.primaryColor,
                            size: 17,
                          ),
                          Text(
                            'Primary',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(
                    width: 70,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      SizedBox(
                        height: 40,
                        width: 90,
                      ),
                      Icon(
                        Icons.refresh,
                        color: AppColors.primaryColor,
                        size: 30,
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(
                height: 20,
                width: 90,
              ),
              ElevatedButtonWidget(
                buttonColor: AppColors.primaryColor,
                onPressed: () => {
                  Routes.navigateToScreenWithCB(context, Routes.addmoney,
                      (value) {
                    getMyWalletBalance();
                  })
                },
                buttonText: ('Add Money'),
              ),
              Divider(
                color: Colors.black12,
                //color of divider
                height: 20,
                //height spacing of divider
                thickness: 1,
                //thickness of divider line
                indent: 20,
                //spacing at the start of divider
                endIndent: 20, //spacing at the end of divider
              ),
              Row(
                children: [
                  SizedBox(
                    height: 20,
                    width: 20,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Use Your Wallet to',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                        width: 20,
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.settings,
                            color: AppColors.primaryColor,
                            size: 17,
                          ),
                          Text(
                            '  Make a Payment',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          SizedBox(
                            width: 170,
                          ),
                          Icon(
                            Icons.arrow_forward_ios,
                            color: AppColors.primaryColor,
                            size: 14,
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                        width: 20,
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.settings,
                            color: AppColors.primaryColor,
                            size: 17,
                          ),
                          Text(
                            '  Send Money to Bank',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          SizedBox(
                            width: 147,
                          ),
                          Icon(
                            Icons.arrow_forward_ios,
                            color: AppColors.primaryColor,
                            size: 14,
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
              Divider(
                color: Colors.black12,
                //color of divider
                height: 20,
                //height spacing of divider
                thickness: 1,
                //thickness of divider line
                indent: 20,
                //spacing at the start of divider
                endIndent: 20, //spacing at the end of divider
              ),

              Row(
                children: [
                  SizedBox(
                    height: 20,
                    width: 20,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Resent Transaction',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                  ),
                  TextButton(onPressed: (){
                    Routes.navigateToScreen(context, Routes.paymenthistory);
                  }, child: Text('See More'))
                ],
              ),
              cardList.length > 0 ?
              Container(
                height: DeviceUtils.getScaledHeight(context, 0.30),
                child: ListView.builder(
                    itemCount: cardList.length,
                    scrollDirection: Axis.vertical,
                    itemBuilder: (context, index) {
                      return PaymentHistoryItem(cardItem: cardList[index], );
                    }),
              ) : Center(child: Text('No Transactions found'),),
            ],
          ),
        ),
      ),
    );
  }

  getMyWalletBalance() {
    GlobalStoreHandler.userStore.myWalletBalance((WalletBalanceMaster master) {
      if (master.data != null) {
        setState(() {
          mWalletBalance = master.data?.walletBalance ?? 0;
        });
      }
      if (master.success != null && master.success!) {
      } else {}
    }, (error) {
      print(error.toString());
    });
  }
}
