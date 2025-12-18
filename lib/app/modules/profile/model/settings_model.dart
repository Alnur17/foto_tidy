class SettingsModel {
  SettingsModel({
    required this.success,
    required this.statusCode,
    required this.message,
    required this.meta,
    required this.data,
  });

  final bool? success;
  final int? statusCode;
  final String? message;
  final Meta? meta;
  final List<Datum> data;

  factory SettingsModel.fromJson(Map<String, dynamic> json){
    return SettingsModel(
      success: json["success"],
      statusCode: json["statusCode"],
      message: json["message"],
      meta: json["meta"] == null ? null : Meta.fromJson(json["meta"]),
      data: json["data"] == null ? [] : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
    );
  }

}

class Datum {
  Datum({
    required this.id,
    required this.aboutUs,
    required this.termsAndConditions,
    required this.privacyPolicy,
    required this.supports,
    required this.faq,
    required this.freeStorage,
    required this.isDeleted,
    required this.createdBy,
    required this.createdAt,
    required this.updatedAt,
  });

  final String? id;
  final String? aboutUs;
  final String? termsAndConditions;
  final String? privacyPolicy;
  final String? supports;
  final String? faq;
  final int? freeStorage;
  final bool? isDeleted;
  final dynamic createdBy;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  factory Datum.fromJson(Map<String, dynamic> json){
    return Datum(
      id: json["_id"],
      aboutUs: json["aboutUs"],
      termsAndConditions: json["termsAndConditions"],
      privacyPolicy: json["privacyPolicy"],
      supports: json["supports"],
      faq: json["faq"],
      freeStorage: json["freeStorage"],
      isDeleted: json["isDeleted"],
      createdBy: json["createdBy"],
      createdAt: DateTime.tryParse(json["createdAt"] ?? ""),
      updatedAt: DateTime.tryParse(json["updatedAt"] ?? ""),
    );
  }

}

class Meta {
  Meta({
    required this.page,
    required this.limit,
    required this.total,
    required this.totalPage,
  });

  final int? page;
  final int? limit;
  final int? total;
  final int? totalPage;

  factory Meta.fromJson(Map<String, dynamic> json){
    return Meta(
      page: json["page"],
      limit: json["limit"],
      total: json["total"],
      totalPage: json["totalPage"],
    );
  }

}
