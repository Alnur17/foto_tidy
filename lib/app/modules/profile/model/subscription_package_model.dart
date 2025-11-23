class SubscriptionPackageModel {
  SubscriptionPackageModel({
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
  final List<SubsPackageDatum> data;

  factory SubscriptionPackageModel.fromJson(Map<String, dynamic> json){
    return SubscriptionPackageModel(
      success: json["success"],
      statusCode: json["statusCode"],
      message: json["message"],
      meta: json["meta"] == null ? null : Meta.fromJson(json["meta"]),
      data: json["data"] == null ? [] : List<SubsPackageDatum>.from(json["data"]!.map((x) => SubsPackageDatum.fromJson(x))),
    );
  }

}

class SubsPackageDatum {
  SubsPackageDatum({
    required this.id,
    required this.title,
    required this.type,
    required this.billingCycle,
    required this.description,
    required this.price,
    required this.popularity,
    required this.isDeleted,
    required this.createdAt,
    required this.updatedAt,
  });

  final String? id;
  final String? title;
  final String? type;
  final String? billingCycle;
  final List<String> description;
  final double? price;
  final int? popularity;
  final bool? isDeleted;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  factory SubsPackageDatum.fromJson(Map<String, dynamic> json){
    return SubsPackageDatum(
      id: json["_id"],
      title: json["title"],
      type: json["type"],
      billingCycle: json["billingCycle"],
      description: json["description"] == null ? [] : List<String>.from(json["description"]!.map((x) => x)),
      price: json["price"] == null
          ? null
          : (json["price"] is int
          ? (json["price"] as int).toDouble()
          : json["price"] as double),
      popularity: json["popularity"],
      isDeleted: json["isDeleted"],
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
