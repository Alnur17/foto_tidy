class MySubscriptionModel {
  MySubscriptionModel({
    required this.success,
    required this.statusCode,
    required this.message,
    required this.data,
  });

  final bool? success;
  final int? statusCode;
  final String? message;
  final Data? data;

  factory MySubscriptionModel.fromJson(Map<String, dynamic> json){
    return MySubscriptionModel(
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
    required this.user,
    required this.type,
    required this.package,
    required this.transactionId,
    required this.amount,
    required this.paymentStatus,
    required this.status,
    required this.expiredAt,
    required this.isExpired,
    required this.isDeleted,
    required this.createdAt,
    required this.updatedAt,
  });

  final String? id;
  final User? user;
  final String? type;
  final Package? package;
  final String? transactionId;
  final double? amount;
  final String? paymentStatus;
  final String? status;
  final DateTime? expiredAt;
  final bool? isExpired;
  final bool? isDeleted;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  factory Data.fromJson(Map<String, dynamic> json){
    return Data(
      id: json["_id"],
      user: json["user"] == null ? null : User.fromJson(json["user"]),
      type: json["type"],
      package: json["package"] == null ? null : Package.fromJson(json["package"]),
      transactionId: json["transactionId"],
      amount: json["amount"],
      paymentStatus: json["paymentStatus"],
      status: json["status"],
      expiredAt: DateTime.tryParse(json["expiredAt"] ?? ""),
      isExpired: json["isExpired"],
      isDeleted: json["isDeleted"],
      createdAt: DateTime.tryParse(json["createdAt"] ?? ""),
      updatedAt: DateTime.tryParse(json["updatedAt"] ?? ""),
    );
  }

}

class Package {
  Package({
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
    required this.v,
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
  final int? v;

  factory Package.fromJson(Map<String, dynamic> json){
    return Package(
      id: json["_id"],
      title: json["title"],
      type: json["type"],
      billingCycle: json["billingCycle"],
      description: json["description"] == null ? [] : List<String>.from(json["description"]!.map((x) => x)),
      price: json["price"],
      popularity: json["popularity"],
      isDeleted: json["isDeleted"],
      createdAt: DateTime.tryParse(json["createdAt"] ?? ""),
      updatedAt: DateTime.tryParse(json["updatedAt"] ?? ""),
      v: json["__v"],
    );
  }

}

class User {
  User({
    required this.id,
    required this.name,
    required this.email,
    required this.photoUrl,
  });

  final String? id;
  final String? name;
  final String? email;
  final String? photoUrl;

  factory User.fromJson(Map<String, dynamic> json){
    return User(
      id: json["_id"],
      name: json["name"],
      email: json["email"],
      photoUrl: json["photoUrl"],
    );
  }

}
