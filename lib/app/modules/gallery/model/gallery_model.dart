class GalleryModel {
  GalleryModel({
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
  final List<GalleryDatum> data;

  factory GalleryModel.fromJson(Map<String, dynamic> json){
    return GalleryModel(
      success: json["success"],
      statusCode: json["statusCode"],
      message: json["message"],
      meta: json["meta"] == null ? null : Meta.fromJson(json["meta"]),
      data: json["data"] == null ? [] : List<GalleryDatum>.from(json["data"]!.map((x) => GalleryDatum.fromJson(x))),
    );
  }

}

class GalleryDatum {
  GalleryDatum({
    required this.id,
    required this.author,
    required this.tag,
    required this.image,
    required this.fileSize,
    required this.createdAt,
    required this.updatedAt,
    required this.isFavorite,
  });

  final String? id;
  final String? author;
  final Tag? tag;
  final String? image;
  final double? fileSize;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final bool? isFavorite;

  factory GalleryDatum.fromJson(Map<String, dynamic> json){
    return GalleryDatum(
      id: json["_id"],
      author: json["author"],
      tag: json["tag"] == null ? null : Tag.fromJson(json["tag"]),
      image: json["image"],
      fileSize: json["fileSize"],
      createdAt: DateTime.tryParse(json["createdAt"] ?? ""),
      updatedAt: DateTime.tryParse(json["updatedAt"] ?? ""),
      isFavorite: json["isFavorite"],
    );
  }

}

class Tag {
  Tag({
    required this.id,
    required this.title,
  });

  final String? id;
  final String? title;

  factory Tag.fromJson(Map<String, dynamic> json){
    return Tag(
      id: json["_id"],
      title: json["title"],
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
