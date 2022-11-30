class UploadChatImageResponseModel {
  bool? success;
  String? message;
  List<Data>? data;

  UploadChatImageResponseModel({this.success, this.message, this.data});

  UploadChatImageResponseModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  String? fieldname;
  String? originalname;
  String? encoding;
  String? mimetype;
  int? size;
  String? bucket;
  String? key;
  String? acl;
  String? contentType;
  Null? contentDisposition;
  Null? contentEncoding;
  String? storageClass;
  Null? serverSideEncryption;
  Metadata? metadata;
  String? location;
  String? etag;

  Data(
      {this.fieldname,
        this.originalname,
        this.encoding,
        this.mimetype,
        this.size,
        this.bucket,
        this.key,
        this.acl,
        this.contentType,
        this.contentDisposition,
        this.contentEncoding,
        this.storageClass,
        this.serverSideEncryption,
        this.metadata,
        this.location,
        this.etag});

  Data.fromJson(Map<String, dynamic> json) {
    fieldname = json['fieldname'];
    originalname = json['originalname'];
    encoding = json['encoding'];
    mimetype = json['mimetype'];
    size = json['size'];
    bucket = json['bucket'];
    key = json['key'];
    acl = json['acl'];
    contentType = json['contentType'];
    contentDisposition = json['contentDisposition'];
    contentEncoding = json['contentEncoding'];
    storageClass = json['storageClass'];
    serverSideEncryption = json['serverSideEncryption'];
    metadata = json['metadata'] != null
        ? new Metadata.fromJson(json['metadata'])
        : null;
    location = json['location'];
    etag = json['etag'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['fieldname'] = this.fieldname;
    data['originalname'] = this.originalname;
    data['encoding'] = this.encoding;
    data['mimetype'] = this.mimetype;
    data['size'] = this.size;
    data['bucket'] = this.bucket;
    data['key'] = this.key;
    data['acl'] = this.acl;
    data['contentType'] = this.contentType;
    data['contentDisposition'] = this.contentDisposition;
    data['contentEncoding'] = this.contentEncoding;
    data['storageClass'] = this.storageClass;
    data['serverSideEncryption'] = this.serverSideEncryption;
    if (this.metadata != null) {
      data['metadata'] = this.metadata!.toJson();
    }
    data['location'] = this.location;
    data['etag'] = this.etag;
    return data;
  }
}

class Metadata {
  String? fieldName;

  Metadata({this.fieldName});

  Metadata.fromJson(Map<String, dynamic> json) {
    fieldName = json['fieldName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['fieldName'] = this.fieldName;
    return data;
  }
}
