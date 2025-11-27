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

  // THIS WAS MISSING — ADD THIS!
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

  factory ProfileModel.fromJson(Map<String, dynamic> json) {
    return ProfileModel(
      success: json["success"],
      statusCode: json["statusCode"],
      message: json["message"],
      data: json["data"] == null ? null : Data.fromJson(json["data"] as Map<String, dynamic>),
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

  // You already added this — perfect!
  Data copyWith({
    String? id,
    String? name,
    String? email,
    String? photoUrl,
    dynamic contractNumber,
    dynamic galleryKey,
    String? status,
    double? freeStorage,
    String? dataId,
    DateTime? createdAt,
    bool? isActiveLock,
    int? storageLimit,
    bool? isActiveSubscription,
    String? type,
    bool? isGalleryLock,
  }) {
    return Data(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      photoUrl: photoUrl ?? this.photoUrl,
      contractNumber: contractNumber ?? this.contractNumber,
      galleryKey: galleryKey ?? this.galleryKey,
      status: status ?? this.status,
      freeStorage: freeStorage ?? this.freeStorage,
      dataId: dataId ?? this.dataId,
      createdAt: createdAt ?? this.createdAt,
      isActiveLock: isActiveLock ?? this.isActiveLock,
      storageLimit: storageLimit ?? this.storageLimit,
      isActiveSubscription: isActiveSubscription ?? this.isActiveSubscription,
      type: type ?? this.type,
      isGalleryLock: isGalleryLock ?? this.isGalleryLock,
    );
  }

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      id: json["_id"] as String?,
      name: json["name"] as String?,
      email: json["email"] as String?,
      photoUrl: json["photoUrl"] as String?,
      contractNumber: json["contractNumber"],
      galleryKey: json["galleryKey"],
      status: json["status"] as String?,
      freeStorage: json["freeStorage"] == null
          ? null
          : (json["freeStorage"] is int
          ? (json["freeStorage"] as int).toDouble()
          : json["freeStorage"] as double),
      dataId: json["id"] as String?,
      createdAt: json["createdAt"] == null ? null : DateTime.tryParse(json["createdAt"] as String),
      isActiveLock: json["isActiveLock"] as bool?,
      storageLimit: json["storageLimit"] as int?,
      isActiveSubscription: json["isActiveSubscription"] as bool?,
      type: json["type"] as String?,
      isGalleryLock: json["isGalleryLock"] as bool?,
    );
  }
}