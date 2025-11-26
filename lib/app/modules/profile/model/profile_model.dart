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
    required this.galleryKey,
    required this.status,
    required this.freeStorage,
    required this.dataId,
    required this.createdAt,
    required this.isActiveLock,
    required this.storageLimit,
    required this.isActiveSubscription,
    required this.type,
    required this.isGalleryLock,
  });

  final String? id;
  final String? name;
  final String? email;
  final String? photoUrl;
  final dynamic contractNumber;
  final dynamic galleryKey;
  final String? status;
  final double? freeStorage;
  final String? dataId;
  final DateTime? createdAt;
  final bool? isActiveLock;
  final int? storageLimit;
  final bool? isActiveSubscription;
  final String? type;
  final bool? isGalleryLock;

  factory Data.fromJson(Map<String, dynamic> json){
    return Data(
      id: json["_id"],
      name: json["name"],
      email: json["email"],
      photoUrl: json["photoUrl"],
      contractNumber: json["contractNumber"],
      galleryKey: json["galleryKey"],
      status: json["status"],
      freeStorage: json["freeStorage"] == null
          ? null
          : (json["freeStorage"] is int
          ? (json["freeStorage"] as int).toDouble()
          : json["freeStorage"] as double),
      dataId: json["id"],
      createdAt: DateTime.tryParse(json["createdAt"] ?? ""),
      isActiveLock: json["isActiveLock"],
      storageLimit: json["storageLimit"],
      isActiveSubscription: json["isActiveSubscription"],
      type: json["type"],
      isGalleryLock: json["isGalleryLock"],
    );
  }

}
