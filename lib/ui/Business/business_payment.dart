import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:guilt_app/constants/colors.dart';
import 'package:guilt_app/models/Auth/AllUserResponseModel.dart';
import 'package:guilt_app/models/Auth/profile_modal.dart';
import 'package:guilt_app/models/Business/BusinessDetailResponseModel.dart';
import 'package:guilt_app/models/Business/search_business_master.dart';
import 'package:guilt_app/models/payment/pay_to_user_request.dart';
import 'package:guilt_app/models/payment/payment_card_master.dart';
import 'package:guilt_app/utils/Global_methods/GlobalStoreHandler.dart';
import 'package:guilt_app/utils/card_utils/card_utils.dart';
import 'package:guilt_app/utils/device/device_utils.dart';
import 'package:guilt_app/utils/routes/routes.dart';
import 'package:guilt_app/widgets/custom_scaffold.dart';
import 'package:guilt_app/widgets/rounded_button_widget.dart';

import '../../data/repository.dart';
import '../../di/components/service_locator.dart';
import '../../models/payment/payment_request.dart';
import '../../models/success_master.dart';
import '../../stores/user/user_store.dart';
import '../../utils/Global_methods/global.dart';
import '../../widgets/textfield_widget.dart';

class BusinessPayment extends StatefulWidget {
  const BusinessPayment({Key? key}) : super(key: key);

  @override
  State<BusinessPayment> createState() => _BusinessPaymentState();
}

// List of items in our dropdown menu

class _BusinessPaymentState extends State<BusinessPayment> {
  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  final FocusNode _amountFocusNode = FocusNode();
  final amountController = TextEditingController();
  var businessNameController = TextEditingController();
  final descriptionController = TextEditingController();
  final locationController = TextEditingController();
  String? type;
  dynamic? userData;
  String? fromScreen;
  Business? selectedBusiness;
  final UserStore _userStore = UserStore(getIt<Repository>());

  Future<List<Business>> searchBusinessByName(String searchQuery) async {
    dynamic master =
        await GlobalStoreHandler.postStore.getBusinessByNameList(searchQuery);
    debugPrint("$master");
    if (master != null) {
      SearchBusinessModel val = SearchBusinessModel.fromJson(master);
      debugPrint("Search business results returning${val.data!.length}");
      return val.data ?? [];
    }
    return [];
  }

  Future<List<Business>> searchOwnBusiness(String searchQuery) async {
    dynamic master =
    await GlobalStoreHandler.postStore.getOwnBusinessList(searchQuery);
    debugPrint("$master");
    if (master != null) {
      SearchBusinessModel val = SearchBusinessModel.fromJson(master);
      debugPrint("Search business results returning${val.data!.length}");
      return val.data ?? [];
    }
    return [];
  }

  @override
  void didChangeDependencies() {
    var args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    setState(() {
      type = args['type'];
      userData = args['userData'];
      fromScreen = args['fromScreen'] ?? "";
    });

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
        leading: GestureDetector(
          onTap: () {
            Routes.goBack(context);
          },
          child: Icon(
            Icons.close, color: Colors.black,
            //color: Colors.black,
            size: 30,
          ),
        ),
      ),
      body: SingleChildScrollView(
        physics: ScrollPhysics(),
        child: Form(
          key: formkey,
          child: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
            SizedBox(
              height: DeviceUtils.getScaledWidth(context, 0.20),
            ),
            Align(
                alignment: Alignment.center,
                child: Stack(children: [
                  Container(
                    child: Image.network(
                      'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSnngxCpo8jS7WE_uNWmlP4bME_IZkXWKYMzhM2Qi1JE_J-l_4SZQiGclMuNr4acfenazo&usqp=CAU',
                      width: DeviceUtils.getScaledWidth(context, 0.15),
                      height: DeviceUtils.getScaledWidth(context, 0.15),
                      fit: BoxFit.cover,
                    ),
                  ),
                ])),
            SizedBox(
              height: 15,
            ),
            Text(
              "${userData?.firstname ?? ""}",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
            ),
            SizedBox(
              height: 15,
            ),
            Text(
              '${userData?.phone ?? ""}',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              width: DeviceUtils.getScaledWidth(context, 0.65),
              child: Center(
                child: TextFormField(
                  textAlign: TextAlign.start,
                  keyboardType: TextInputType.number,
                  controller: amountController,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.allow(
                        RegExp(r'^\d+\.?\d{0,0}')),
                  ],
                  decoration: new InputDecoration(
                      prefixIconConstraints: BoxConstraints(minWidth: 24),
                      prefixIcon: Padding(
                        padding: const EdgeInsets.only(left: 30, bottom: 2),
                        child: Text(
                          "\$",
                          style: TextStyle(fontSize: 17),
                        ),
                      ),
                      border: new OutlineInputBorder(
                        borderRadius: const BorderRadius.all(
                          const Radius.circular(30.0),
                        ),
                        borderSide: BorderSide(
                          width: 0,
                          style: BorderStyle.none,
                        ),
                      ),
                      errorBorder: new OutlineInputBorder(
                        borderRadius: const BorderRadius.all(
                          const Radius.circular(30.0),
                        ),
                        borderSide: BorderSide(width: 1, color: Colors.red),
                      ),
                      filled: true,
                      hintStyle: new TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w400,
                        color: Colors.grey[800],
                      ),
                      hintText: "0",
                      fillColor: Colors.black12),
                  validator: (val) {
                    if (val!.isEmpty) {
                      return "Enter Amount";
                    } else {
                      return null;
                    }
                  },
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Enter Your Business",
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  ),
                  Autocomplete<Business>(
                    optionsBuilder: (TextEditingValue value) {
                      return type=="Pay"?
                      searchBusinessByName(value.text): searchOwnBusiness(value.text);
                    },
                    displayStringForOption: (Business option) => option.name!,
                    fieldViewBuilder: (BuildContext context,
                        TextEditingController fieldTextEditingController,
                        FocusNode fieldFocusNode,
                        VoidCallback onFieldSubmitted) {
                      businessNameController = fieldTextEditingController;
                      return TextFieldSearch(
                        controller: businessNameController,
                        hintText: "Select Your Business",
                        textInputType: TextInputType.text,
                        focusNode: fieldFocusNode,
                        validator: (val) {
                          if (val!.isEmpty || selectedBusiness == null) {
                            return "Select Your Business";
                          } else {
                            return null;
                          }
                        },
                      );
                    },
                    onSelected: (Business business) {
                      setState(() {
                        selectedBusiness = business;
                        locationController.text = business.location ?? '';
                      });
                    },
                    optionsViewBuilder: (BuildContext context,
                        AutocompleteOnSelected<Business> onSelected,
                        Iterable<Business> businessList) {
                      return Container(
                        margin: EdgeInsets.only(top: 8, right: 30),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.all(Radius.circular(8)),
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.grey.withOpacity(0.2),
                                  blurRadius: 6,
                                  spreadRadius: 6)
                            ]),
                        padding: EdgeInsets.only(bottom: 12),
                        child: ListView.builder(
                          padding: EdgeInsets.all(0),
                          itemCount: businessList.length,
                          shrinkWrap: true,
                          physics: ClampingScrollPhysics(),
                          itemBuilder: (context, index) {
                            Business business = businessList.elementAt(index);
                            return InkWell(
                                onTap: () {
                                  onSelected(business);
                                },
                                child: Container(
                                  margin: EdgeInsets.only(top: 6),
                                  child: Container(
                                    padding: EdgeInsets.only(
                                      left: 12,
                                      right: 12,
                                      top: 8,
                                    ),
                                    child: Text(
                                      business.name ?? "",
                                    ),
                                  ),
                                ));
                          },
                        ),
                      );
                    },
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Location",
                        textAlign: TextAlign.start,
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                      ),
                      Row(
                        children: [
                          Container(
                              width: DeviceUtils.getScaledWidth(context, 0.90),
                              child: TextFormField(
                                enabled: false,
                                keyboardType: TextInputType.multiline,
                                maxLines: null,
                                controller: locationController,
                                cursorColor: Colors.black,
                                decoration: new InputDecoration(
                                    enabledBorder: UnderlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.grey),
                                    ),
                                    focusedBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                          color: AppColors.primaryColor),
                                    ),
                                    border: UnderlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.grey),
                                    ),
                                    hintText: 'Enter Location'),
                              )),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    minLines: 4,
                    maxLines: 10,
                    keyboardType: TextInputType.text,
                    controller: descriptionController,
                    decoration: InputDecoration(
                      hintText: 'Enter your description',
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: AppColors.primaryColor),
                      ),
                      border: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey),
                      ),
                      errorBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.red, width: 1.0),
                      ),
                      hintStyle: TextStyle(color: Colors.grey),
                    ),
                    validator: (val) {
                      if (val!.isEmpty) {
                        return "Enter Description";
                      } else {
                        return null;
                      }
                    },
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      Container(
                        width: DeviceUtils.getScaledWidth(context, 0.44),
                        child: ElevatedButtonWithBorderWidget(
                          buttonColor: Colors.white,
                          textColor: AppColors.primaryColor,
                          onPressed: () {},
                          buttonText: ('Cancel'),
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Container(
                        width: DeviceUtils.getScaledWidth(context, 0.44),
                        child: ElevatedButtonWidget(
                          buttonColor: AppColors.primaryColor,
                          onPressed: () {
                            if (type == "Pay") {
                              if (formkey.currentState!.validate()) {
                                choosePaymentMethod();
                              }
                            } else if (type == "Request") {
                              if (formkey.currentState!.validate()) {
                                requestUserForPayment(
                                    toUserId: userData?.id,
                                    businessId: selectedBusiness?.id,
                                    amount: int.parse(amountController.text),
                                    remarks: descriptionController.text);
                              } else {
                                print('Eroor');
                              }
                            }
                          },
                          buttonText: (type ?? ""),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ]),
        ),
      ),
    );
  }

  void choosePaymentMethod() {
    var args = {
      "amount": double.parse(amountController.text),
      "fromScreen": Routes.pay_request_business_payment
    };
    Routes.navigateToScreenWithArgsAndCB(context, Routes.select_card, args,
        (PaymentCardDetails data) {
      if (data != null) {
        payTouser(data);
      }
    });
  }

  payTouser(PaymentCardDetails data) async {
    GlobalMethods.showLoader();
    GetProfileResponseModal? profileData = await _userStore.getProfileData();
    int currentUserId = int.parse(profileData?.user?.customerProfileId ?? "0");
    // int currentUserId = int.parse(
    //     GlobalStoreHandler.userStore.Profile_data?.user?.customerProfileId ??
    //         "0");

    PayToUserRequest payModel = PayToUserRequest(
      customerProfileId: currentUserId,
      paymentProfile: data.customerPaymentProfileId != null
          ? int.parse(data.customerPaymentProfileId!)
          : null,
      amount: data.bankDeduction,
      walletAmount: data.walletDeduction,
      toUserId: userData?.id,
      paymentMethod: data.type,
      paymentReqId: data.id,
    );
    if (fromScreen == "notification") {
      payModel.businessId = selectedBusiness?.id ?? 0;
    }

    _userStore.payToUser(payModel, (SuccessMaster successMaster) {
      GlobalMethods.hideLoader();
      if (successMaster != null) {
        if (successMaster.success != null && successMaster.success!) {
          GlobalMethods.showSuccessMessage(
              context, successMaster.message!, type ?? "");
          Routes.goBack(context);
        } else {
          GlobalMethods.showErrorMessage(
              context, successMaster.message!, type ?? "");
        }
      }
    }, (error) {
      GlobalMethods.hideLoader();
      print(error.toString());
    });
  }

  requestUserForPayment({toUserId, businessId, amount, remarks}) async {
    GlobalMethods.showLoader();
    _userStore.requestUserForPayment(toUserId, businessId, amount, remarks,
        (PaymentMaster paymentMaster) {
      GlobalMethods.hideLoader();
      if (paymentMaster != null) {
        if (paymentMaster.success != null && paymentMaster.success!) {
          GlobalMethods.showSuccessMessage(
              context, paymentMaster.message!, type ?? "");
        } else {
          GlobalMethods.showErrorMessage(
              context, paymentMaster.message!, type ?? "");
        }
      }
    }, (error) {
      GlobalMethods.hideLoader();
      print(error.toString());
    });
  }
}
