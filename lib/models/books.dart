// To parse this JSON data, do
//
//     final book = bookFromJson(jsonString);

import 'dart:convert';

List<Book> bookFromJson(String str) => List<Book>.from(json.decode(str).map((x) => Book.fromJson(x)));

String bookToJson(List<Book> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Book {
    Model model;
    int pk;
    Fields fields;

    Book({
        required this.model,
        required this.pk,
        required this.fields,
    });

    factory Book.fromJson(Map<String, dynamic> json) => Book(
        model: modelValues.map[json["model"]]!,
        pk: json["pk"],
        fields: Fields.fromJson(json["fields"]),
    );

    Map<String, dynamic> toJson() => {
        "model": modelValues.reverse[model],
        "pk": pk,
        "fields": fields.toJson(),
    };
}

class Fields {
    String title;
    String author;
    String publisher;
    String description;
    Categories categories;
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
        categories: categoriesValues.map[json["categories"]]!,
        imageLink: json["image_link"],
    );

    Map<String, dynamic> toJson() => {
        "title": title,
        "author": author,
        "publisher": publisher,
        "description": description,
        "categories": categoriesValues.reverse[categories],
        "image_link": imageLink,
    };
}

enum Categories {
    ART,
    ECONOMICS,
    FICTION,
    HISTORY,
    PHILOSOPHY,
    SCIENCE
}

final categoriesValues = EnumValues({
    "Art": Categories.ART,
    "Economics": Categories.ECONOMICS,
    "Fiction": Categories.FICTION,
    "History": Categories.HISTORY,
    "Philosophy": Categories.PHILOSOPHY,
    "Science": Categories.SCIENCE
});

enum Model {
    DATASET_BOOK
}

final modelValues = EnumValues({
    "dataset.book": Model.DATASET_BOOK
});

class EnumValues<T> {
    Map<String, T> map;
    late Map<T, String> reverseMap;

    EnumValues(this.map);

    Map<T, String> get reverse {
        reverseMap = map.map((k, v) => MapEntry(v, k));
        return reverseMap;
    }
}
