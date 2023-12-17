import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mybooklistmobile/models/book_review.dart';

class BookReviewsRepository {
  static String urlApi = 'http://192.168.1.22:8000';

  static Future<void> createReview(BookReview review, context) async {
    var response = await http.post(
      Uri.parse("$urlApi/book/create-review/"),
      body: jsonEncode({
        'book_id': review.bookId,
        'username': review.username,
        'comment': review.comment,
        'rating': review.rating,
      }),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(
            const SnackBar(content: Text("Review-mu berhasil ditambahkan!")));
    } else {
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(
            const SnackBar(content: Text("Review-mu gagal ditambahkan!")));
    }
  }

  static Future<List<BookReview>> getBookReview(bookId) async {
    var response = await http.get(
      Uri.parse("$urlApi/book/show-review-json/$bookId"),
    );

    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body) as List;
      return jsonResponse.map((json) => BookReview.fromJson(json)).toList();
    } else {
      return [];
    }
  }
}
