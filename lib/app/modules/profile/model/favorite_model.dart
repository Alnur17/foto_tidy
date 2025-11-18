class FavoriteModel {
  FavoriteModel({
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
  final List<FavoriteDatum> data;

  factory FavoriteModel.fromJson(Map<String, dynamic> json){
    return FavoriteModel(
      success: json["success"],
      statusCode: json["statusCode"],
      message: json["message"],
      meta: json["meta"] == null ? null : Meta.fromJson(json["meta"]),
      data: json["data"] == null ? [] : List<FavoriteDatum>.from(json["data"]!.map((x) => FavoriteDatum.fromJson(x))),
    );
  }

}

class FavoriteDatum {
  FavoriteDatum({
    required this.id,
    required this.user,
    required this.photo,
    required this.createdAt,
    required this.updatedAt,
  });

  final String? id;
  final String? user;
  final Photo? photo;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  factory FavoriteDatum.fromJson(Map<String, dynamic> json){
    return FavoriteDatum(
      id: json["_id"],
      user: json["user"],
      photo: json["photo"] == null ? null : Photo.fromJson(json["photo"]),
      createdAt: DateTime.tryParse(json["createdAt"] ?? ""),
      updatedAt: DateTime.tryParse(json["updatedAt"] ?? ""),
    );
  }

}

class Photo {
  Photo({
    required this.id,
    required this.image,
    required this.createdAt,
  });

  final String? id;
  final String? image;
  final DateTime? createdAt;

  factory Photo.fromJson(Map<String, dynamic> json){
    return Photo(
      id: json["_id"],
      image: json["image"],
      createdAt: DateTime.tryParse(json["createdAt"] ?? ""),
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
