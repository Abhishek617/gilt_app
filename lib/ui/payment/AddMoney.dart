import 'dart:async';

import 'package:flutter/material.dart';
import 'package:guilt_app/constants/colors.dart';
import 'package:guilt_app/models/payment/add_money_wallet_request.dart';
import 'package:guilt_app/models/payment/payment_card_master.dart';
import 'package:guilt_app/utils/routes/routes.dart';
import 'package:guilt_app/widgets/rounded_button_widget.dart';

import '../../data/repository.dart';
import '../../di/components/service_locator.dart';
import '../../models/Auth/profile_modal.dart';
import '../../models/success_master.dart';
import '../../stores/user/user_store.dart';
import '../../utils/Global_methods/global.dart';
import '../../utils/device/device_utils.dart';
import '../../widgets/custom_scaffold.dart';

class AddMoney extends StatefulWidget {
  const AddMoney({Key? key}) : super(key: key);

  @override
  State<AddMoney> createState() => _AddMoneyState();
}

class _AddMoneyState extends State<AddMoney> {
  final UserStore _userStore = UserStore(getIt<Repository>());

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
              height: 30,
            ),
            Text(
              'Add Amount',
              style: TextStyle(
                color: Colors.black,
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                    onPressed: () {
                      if (initValue > 0) _sink.add(--initValue);
                    },
                    child: Icon(Icons.remove)),
                Container(
                  width: 130,
                  height: 40,
                  child: Center(
                    child: TextField(
                      controller: _controller,
                      textAlign: TextAlign.center,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                          contentPadding: EdgeInsets.only(bottom: 3)),
                      onChanged: (value) {
                        initValue = int.parse(value);
                      },
                    ),
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
              child: ElevatedButtonWidget(
                onPressed: () {
                  choosePaymentMethod();
                },
                buttonColor: AppColors.primaryColor,
                buttonText: 'Add Money',
              ),
            ),
          ],
        ),
      ),
    );
  }

  void choosePaymentMethod() {
    Routes.navigateToScreenWithCB(context, Routes.select_card,
        (PaymentCardDetails data) {
      addMontyToWallet(data);
    });
  }

  addMontyToWallet(PaymentCardDetails data) async {
    GlobalMethods.showLoader();
    GetProfileResponseModal? profileData = await _userStore.getProfileData();
    int currentUserId = int.parse(profileData?.user?.customerProfileId ?? "0");

    AddMoneyToWalletRequest payModel = AddMoneyToWalletRequest(
      customerProfileId: currentUserId,
      paymentProfile: int.parse(data.customerPaymentProfileId!),
      amount: int.parse(_controller.text),
      paymentMethod: data.type,
    );

    _userStore.addMoneyToWallet(payModel, (SuccessMaster successMaster) {
      GlobalMethods.hideLoader();
      if (successMaster.success != null && successMaster.success!) {
        GlobalMethods.showSuccessMessage(
            context, successMaster.message!, "Add Money");
        Routes.goBack(context);
      } else {
        GlobalMethods.showErrorMessage(
            context, successMaster.message!, "Add Money");
      }
    }, (error) {
      GlobalMethods.hideLoader();
      print(error.toString());
    });
  }

  @override
  void dispose() {
    _streamController.close();
    _controller.dispose();
    super.dispose();
  }
}
