// To parse this JSON data, do
//
//     final review = reviewFromJson(jsonString);

import 'dart:convert';

List<Review> reviewFromJson(String str) =>
    List<Review>.from(json.decode(str).map((x) => Review.fromJson(x)));

String reviewToJson(List<Review> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Review {
  String model;
  int pk;
  Fields fields;

  Review({
    required this.model,
    required this.pk,
    required this.fields,
  });

  factory Review.fromJson(Map<String, dynamic> json) => Review(
        model: json["model"],
        pk: json["pk"],
        fields: Fields.fromJson(json["fields"]),
      );

  Map<String, dynamic> toJson() => {
        "model": model,
        "pk": pk,
        "fields": fields.toJson(),
      };
}

class Fields {
  int book;
  String userName;
  String comment;
  DateTime pubDate;
  int rating;

  Fields({
    required this.book,
    required this.userName,
    required this.comment,
    required this.pubDate,
    required this.rating,
  });

  factory Fields.fromJson(Map<String, dynamic> json) => Fields(
        book: json["book"],
        userName: json["user_name"],
        comment: json["comment"],
        pubDate: DateTime.parse(json["pub_date"]),
        rating: json["rating"],
      );

  Map<String, dynamic> toJson() => {
        "book": book,
        "user_name": userName,
        "comment": comment,
        "pub_date": pubDate.toIso8601String(),
        "rating": rating,
      };
}
