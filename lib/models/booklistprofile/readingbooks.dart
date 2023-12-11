// To parse this JSON data, do
//
//     final product = productFromJson(jsonString);

import 'dart:convert';

List<Product> productFromJson(String str) => List<Product>.from(json.decode(str).map((x) => Product.fromJson(x)));

String productToJson(List<Product> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Product {
    String model;
    int pk;
    Fields fields;

    Product({
        required this.model,
        required this.pk,
        required this.fields,
    });

    factory Product.fromJson(Map<String, dynamic> json) => Product(
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
    String title;
    String author;
    String publisher;
    String description;
    String categories;
    String imageLink;

    Fields({
        required this.title,
        required this.author,
        required this.publisher,
        required this.description,
        required this.categories,
        required this.imageLink,
    });

    factory Fields.fromJson(Map<String, dynamic> json) => Fields(
        title: json["title"],
        author: json["author"],
        publisher: json["publisher"],
        description: json["description"],
        categories: json["categories"],
        imageLink: json["image_link"],
    );

    Map<String, dynamic> toJson() => {
        "title": title,
        "author": author,
        "publisher": publisher,
        "description": description,
        "categories": categories,
        "image_link": imageLink,
    };
}
