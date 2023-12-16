import 'dart:convert';
import 'package:http/http.dart';
import 'package:mybooklistmobile/models/books.dart';

class BookRepository {
  // Django server ip
  static String urlApi = 'http://192.168.1.22:8000/';

  Future<List<Book>> getBook() async {
    var response = await get(
      Uri.parse("$urlApi/xml/json"),
    );

    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body) as List;
      return jsonResponse.map((json) => Book.fromJson(json)).toList();
    } else {
      return [];
    }
  }
}
