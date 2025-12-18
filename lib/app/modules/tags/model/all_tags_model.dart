class AllTagsModel {
  AllTagsModel({
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
  final List<TagsDatum> data;

  factory AllTagsModel.fromJson(Map<String, dynamic> json){
    return AllTagsModel(
      success: json["success"],
      statusCode: json["statusCode"],
      message: json["message"],
      meta: json["meta"] == null ? null : Meta.fromJson(json["meta"]),
      data: json["data"] == null ? [] : List<TagsDatum>.from(json["data"]!.map((x) => TagsDatum.fromJson(x))),
    );
  }

}

class TagsDatum {
  TagsDatum({
    required this.id,
    required this.author,
    required this.title,
    required this.isDeleted,
    required this.createdAt,
    required this.updatedAt,
  });

  final String? id;
  final String? author;
  final String? title;
  final bool? isDeleted;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  factory TagsDatum.fromJson(Map<String, dynamic> json){
    return TagsDatum(
      id: json["_id"],
      author: json["author"],
      title: json["title"],
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
