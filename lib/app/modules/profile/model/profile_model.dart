class ProfileModel {
  ProfileModel({
    required this.success,
    required this.statusCode,
    required this.message,
    required this.data,
  });

  final bool? success;
  final int? statusCode;
  final String? message;
  final Data? data;

  ProfileModel copyWith({
    bool? success,
    int? statusCode,
    String? message,
    Data? data,
  }) {
    return ProfileModel(
      success: success ?? this.success,
      statusCode: statusCode ?? this.statusCode,
      message: message ?? this.message,
      data: data ?? this.data,
    );
  }

  factory ProfileModel.fromJson(Map<String, dynamic> json){
    return ProfileModel(
      success: json["success"],
      statusCode: json["statusCode"],
      message: json["message"],
      data: json["data"] == null ? null : Data.fromJson(json["data"]),
    );
  }

}

class Data {
  Data({
    required this.id,
    required this.name,
    required this.email,
    required this.photoUrl,
    required this.contractNumber,
    required this.status,
    required this.freeStorage,
    required this.dataId,
    required this.createdAt,
    required this.isActiveLock,
    required this.galleryKey,
    required this.freeTrialExpiry,
    required this.isEnabledFreeTrial,
    required this.storageLimit,
    required this.isActiveSubscription,
    required this.type,
    required this.isGalleryLock,
    required this.isActiveFreeTrial,
  });

  final String? id;
  final String? name;
  final String? email;
  final String? photoUrl;
  final dynamic contractNumber;
  final String? status;
  final double? freeStorage;
  final String? dataId;
  final DateTime? createdAt;
  final bool? isActiveLock;
  final String? galleryKey;
  final DateTime? freeTrialExpiry;
  final bool? isEnabledFreeTrial;
  final int? storageLimit;
  final bool? isActiveSubscription;
  final String? type;
  final bool? isGalleryLock;
  final bool? isActiveFreeTrial;

  Data copyWith({
    String? id,
    String? name,
    String? email,
    String? photoUrl,
    dynamic? contractNumber,
    String? status,
    double? freeStorage,
    String? dataId,
    DateTime? createdAt,
    bool? isActiveLock,
    String? galleryKey,
    DateTime? freeTrialExpiry,
    bool? isEnabledFreeTrial,
    int? storageLimit,
    bool? isActiveSubscription,
    String? type,
    bool? isGalleryLock,
    bool? isActiveFreeTrial,
  }) {
    return Data(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      photoUrl: photoUrl ?? this.photoUrl,
      contractNumber: contractNumber ?? this.contractNumber,
      status: status ?? this.status,
      freeStorage: freeStorage ?? this.freeStorage,
      dataId: dataId ?? this.dataId,
      createdAt: createdAt ?? this.createdAt,
      isActiveLock: isActiveLock ?? this.isActiveLock,
      galleryKey: galleryKey ?? this.galleryKey,
      freeTrialExpiry: freeTrialExpiry ?? this.freeTrialExpiry,
      isEnabledFreeTrial: isEnabledFreeTrial ?? this.isEnabledFreeTrial,
      storageLimit: storageLimit ?? this.storageLimit,
      isActiveSubscription: isActiveSubscription ?? this.isActiveSubscription,
      type: type ?? this.type,
      isGalleryLock: isGalleryLock ?? this.isGalleryLock,
      isActiveFreeTrial: isActiveFreeTrial ?? this.isActiveFreeTrial,
    );
  }

  factory Data.fromJson(Map<String, dynamic> json){
    return Data(
      id: json["_id"],
      name: json["name"],
      email: json["email"],
      photoUrl: json["photoUrl"],
      contractNumber: json["contractNumber"],
      status: json["status"],
      freeStorage: json["freeStorage"] == null
          ? null
          : (json["freeStorage"] is int
          ? (json["freeStorage"] as int).toDouble()
          : json["freeStorage"] as double),
      dataId: json["id"],
      createdAt: DateTime.tryParse(json["createdAt"] ?? ""),
      isActiveLock: json["isActiveLock"],
      galleryKey: json["galleryKey"],
      freeTrialExpiry: DateTime.tryParse(json["freeTrialExpiry"] ?? ""),
      isEnabledFreeTrial: json["isEnabledFreeTrial"],
      storageLimit: json["storageLimit"],
      isActiveSubscription: json["isActiveSubscription"],
      type: json["type"],
      isGalleryLock: json["isGalleryLock"],
      isActiveFreeTrial: json["isActiveFreeTrial"],
    );
  }

}
