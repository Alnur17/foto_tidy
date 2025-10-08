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
  final ProfileData? data;

  factory ProfileModel.fromJson(Map<String, dynamic> json){
    return ProfileModel(
      success: json["success"],
      statusCode: json["statusCode"],
      message: json["message"],
      data: json["data"] == null ? null : ProfileData.fromJson(json["data"]),
    );
  }

}

class ProfileData {
  ProfileData({
    required this.id,
    required this.name,
    required this.email,
    required this.photoUrl,
    required this.status,
    required this.dataId,
    required this.createdAt,
  });

  final String? id;
  final String? name;
  final String? email;
  final dynamic photoUrl;
  final String? status;
  final String? dataId;
  final DateTime? createdAt;

  factory ProfileData.fromJson(Map<String, dynamic> json){
    return ProfileData(
      id: json["_id"],
      name: json["name"],
      email: json["email"],
      photoUrl: json["photoUrl"],
      status: json["status"],
      dataId: json["id"],
      createdAt: DateTime.tryParse(json["createdAt"] ?? ""),
    );
  }

}
