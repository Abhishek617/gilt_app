import 'package:get/get.dart';

class PaymentHistoryResponseModel {
  bool? success;
  String? message;
  History? history;

  PaymentHistoryResponseModel({this.success, this.message, this.history});

  PaymentHistoryResponseModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    history =
        json['history'] != null ? new History.fromJson(json['history']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['message'] = this.message;
    if (this.history != null) {
      data['history'] = this.history!.toJson();
    }
    return data;
  }
}

class History {
  int? totalItems;
  List<HistoryItem>? listData;
  int? totalPages;
  int? currentPage;

  History({this.totalItems, this.listData, this.totalPages, this.currentPage});

  History.fromJson(Map<String, dynamic> json) {
    totalItems = json['totalItems'];
    if (json['listData'] != null) {
      listData = <HistoryItem>[];
      json['listData'].forEach((v) {
        listData!.add(new HistoryItem.fromJson(v));
      });
    }
    totalPages = json['totalPages'];
    currentPage = json['currentPage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['totalItems'] = this.totalItems;
    if (this.listData != null) {
      data['listData'] = this.listData!.map((v) => v.toJson()).toList();
    }
    data['totalPages'] = this.totalPages;
    data['currentPage'] = this.currentPage;
    return data;
  }
}

class HistoryItem {
  int? id;
  int? fromUserId;
  int? toUserId;
  int? eventId;
  int? businessId;
  double? amount;
  double? balanceAfterCurrentTransaction;
  String? paymentMethod;
  String? status;
  String? transactionId;
  PaymentGatewayResponse? paymentGatewayResponse;
  bool? isRefundEntry;
  String? transactionType;
  double? paidWalletAmount;
  double? paidCardAmount;
  double? paidBankAmount;
  String? createdAt;
  String? updatedAt;
  FromUserInfo? fromUserInfo;
  FromUserInfo? toUserInfo;
  Event? event;
  String? type;
  String? message;

  HistoryItem(
      {this.id,
      this.fromUserId,
      this.toUserId,
      this.eventId,
      this.businessId,
      this.amount,
      this.balanceAfterCurrentTransaction,
      this.paymentMethod,
      this.status,
      this.transactionId,
      this.paymentGatewayResponse,
      this.isRefundEntry,
      this.transactionType,
      this.paidWalletAmount,
      this.paidCardAmount,
      this.paidBankAmount,
      this.createdAt,
      this.updatedAt,
      this.fromUserInfo,
      this.toUserInfo,
      this.event,
      this.type,
      this.message});

  HistoryItem.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    fromUserId = json['fromUserId'];
    toUserId = json['toUserId'];
    eventId = json['eventId'];
    businessId = json['businessId'];
    amount = json['amount'].toDouble();
    balanceAfterCurrentTransaction =
        json['balanceAfterCurrentTransaction'].toDouble();
    paymentMethod = json['paymentMethod'];
    status = json['status'];
    transactionId = json['transactionId'];
    paymentGatewayResponse = json['paymentGatewayResponse'] != null &&
            json['paymentGatewayResponse'].isNotEmpty
        ? new PaymentGatewayResponse.fromJson(json['paymentGatewayResponse'])
        : null;
    isRefundEntry = json['isRefundEntry'];
    transactionType = json['transactionType'];
    paidWalletAmount = json['paidWalletAmount'].toDouble();
    paidCardAmount = json['paidCardAmount'].toDouble();
    paidBankAmount = json['paidBankAmount'].toDouble();
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    fromUserInfo = json['fromUserInfo'] != null
        ? new FromUserInfo.fromJson(json['fromUserInfo'])
        : null;
    toUserInfo = json['toUserInfo'] != null
        ? new FromUserInfo.fromJson(json['toUserInfo'])
        : null;
    event = json['event'] != null ? new Event.fromJson(json['event']) : null;
    type = json['type'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['fromUserId'] = this.fromUserId;
    data['toUserId'] = this.toUserId;
    data['eventId'] = this.eventId;
    data['businessId'] = this.businessId;
    data['amount'] = this.amount;
    data['balanceAfterCurrentTransaction'] =
        this.balanceAfterCurrentTransaction;
    data['paymentMethod'] = this.paymentMethod;
    data['status'] = this.status;
    data['transactionId'] = this.transactionId;
    if (this.paymentGatewayResponse != null) {
      data['paymentGatewayResponse'] = this.paymentGatewayResponse!.toJson();
    }
    data['isRefundEntry'] = this.isRefundEntry;
    data['transactionType'] = this.transactionType;
    data['paidWalletAmount'] = this.paidWalletAmount;
    data['paidCardAmount'] = this.paidCardAmount;
    data['paidBankAmount'] = this.paidBankAmount;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    if (this.fromUserInfo != null) {
      data['fromUserInfo'] = this.fromUserInfo!.toJson();
    }
    if (this.toUserInfo != null) {
      data['toUserInfo'] = this.toUserInfo!.toJson();
    }
    if (this.event != null) {
      data['event'] = this.event!.toJson();
    }
    data['type'] = this.type;
    data['message'] = this.message;
    return data;
  }
}

class PaymentGatewayResponse {
  CodeMessages? messages;
  TransactionResponse? transactionResponse;

  PaymentGatewayResponse({this.messages, this.transactionResponse});

  PaymentGatewayResponse.fromJson(Map<String, dynamic> json) {
    messages = json['messages'] != null
        ? new CodeMessages.fromJson(json['messages'])
        : null;
    transactionResponse = json['transactionResponse'] != null
        ? new TransactionResponse.fromJson(json['transactionResponse'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.messages != null) {
      data['messages'] = this.messages!.toJson();
    }
    if (this.transactionResponse != null) {
      data['transactionResponse'] = this.transactionResponse!.toJson();
    }
    return data;
  }
}

class CodeMessages {
  List<CodeMessage>? message;
  String? resultCode;

  CodeMessages({this.message, this.resultCode});

  CodeMessages.fromJson(Map<String, dynamic> json) {
    if (json['message'] != null) {
      message = <CodeMessage>[];
      json['message'].forEach((v) {
        message!.add(new CodeMessage.fromJson(v));
      });
    }
    resultCode = json['resultCode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.message != null) {
      data['message'] = this.message!.map((v) => v.toJson()).toList();
    }
    data['resultCode'] = this.resultCode ?? '';
    return data;
  }
}

class CodeMessage {
  String? code;
  String? text;

  CodeMessage({this.code, this.text});

  CodeMessage.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    text = json['text'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['text'] = this.text;
    return data;
  }
}

class TransactionResponse {
  Profile? profile;
  String? transId;
  String? authCode;
  Messages? messages;
  String? transHash;
  String? refTransID;
  String? accountType;
  String? testRequest;
  String? responseCode;
  String? accountNumber;
  String? avsResultCode;
  String? cvvResultCode;
  String? transHashSha2;
  String? cavvResultCode;

  TransactionResponse(
      {this.profile,
      this.transId,
      this.authCode,
      this.messages,
      this.transHash,
      this.refTransID,
      this.accountType,
      this.testRequest,
      this.responseCode,
      this.accountNumber,
      this.avsResultCode,
      this.cvvResultCode,
      this.transHashSha2,
      this.cavvResultCode});

  TransactionResponse.fromJson(Map<String, dynamic> json) {
    profile =
        json['profile'] != null ? new Profile.fromJson(json['profile']) : null;
    transId = json['transId'];
    authCode = json['authCode'];
    messages = json['messages'] != null
        ? new Messages.fromJson(json['messages'])
        : null;
    transHash = json['transHash'];
    refTransID = json['refTransID'];
    accountType = json['accountType'];
    testRequest = json['testRequest'];
    responseCode = json['responseCode'];
    accountNumber = json['accountNumber'];
    avsResultCode = json['avsResultCode'];
    cvvResultCode = json['cvvResultCode'];
    transHashSha2 = json['transHashSha2'];
    cavvResultCode = json['cavvResultCode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.profile != null) {
      data['profile'] = this.profile!.toJson();
    }
    data['transId'] = this.transId;
    data['authCode'] = this.authCode;
    if (this.messages != null) {
      data['messages'] = this.messages!.toJson();
    }
    data['transHash'] = this.transHash;
    data['refTransID'] = this.refTransID;
    data['accountType'] = this.accountType;
    data['testRequest'] = this.testRequest;
    data['responseCode'] = this.responseCode;
    data['accountNumber'] = this.accountNumber;
    data['avsResultCode'] = this.avsResultCode;
    data['cvvResultCode'] = this.cvvResultCode;
    data['transHashSha2'] = this.transHashSha2;
    data['cavvResultCode'] = this.cavvResultCode;
    return data;
  }
}

class Profile {
  String? customerProfileId;
  String? customerPaymentProfileId;

  Profile({this.customerProfileId, this.customerPaymentProfileId});

  Profile.fromJson(Map<String, dynamic> json) {
    customerProfileId = json['customerProfileId'];
    customerPaymentProfileId = json['customerPaymentProfileId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['customerProfileId'] = this.customerProfileId;
    data['customerPaymentProfileId'] = this.customerPaymentProfileId;
    return data;
  }
}

class Messages {
  List<Message>? message;

  Messages({this.message});

  Messages.fromJson(Map<String, dynamic> json) {
    if (json['message'] != null) {
      message = <Message>[];
      json['message'].forEach((v) {
        message!.add(new Message.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.message != null) {
      data['message'] = this.message!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Message {
  String? code;
  String? description;

  Message({this.code, this.description});

  Message.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['description'] = this.description;
    return data;
  }
}

class FromUserInfo {
  String? firstname;
  String? lastname;

  FromUserInfo({this.firstname, this.lastname});

  FromUserInfo.fromJson(Map<String, dynamic> json) {
    firstname = json['firstname'];
    lastname = json['lastname'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['firstname'] = this.firstname;
    data['lastname'] = this.lastname;
    return data;
  }
}

class Event {
  int? id;
  String? name;

  Event({this.id, this.name});

  Event.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    return data;
  }
}
