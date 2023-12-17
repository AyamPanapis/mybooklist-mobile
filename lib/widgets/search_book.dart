import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:mybooklistmobile/widgets/left_drawer.dart';
import 'package:mybooklistmobile/models/books.dart';
import 'package:mybooklistmobile/screens/book/book_page.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  List<Book> allBooks = [];
  List<Book> displayedBooks = [];

  Future<void> fetchBooks() async {
    var url = Uri.parse('http://localhost:8000/xml/json/');
    var response = await http.get(
      url,
      headers: {"Content-Type": "application/json"},
    );

    var data = jsonDecode(utf8.decode(response.bodyBytes));

    List<Book> listBook = [];
    for (var d in data) {
      if (d != null) {
        listBook.add(Book.fromJson(d));
      }
    }

    setState(() {
      allBooks = listBook;
    });
  }

  void filterBooks(String query) {
    fetchBooks();
    setState(() {
      if (query.isEmpty) {
        displayedBooks = []; // Return an empty list when the query is empty
      } else {
        displayedBooks = allBooks
            .where((book) =>
                book.fields.title.toLowerCase().contains(query.toLowerCase()))
            .toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF001C30),
      appBar: AppBar(
        title: const Text('Search For Books'),
        backgroundColor: const Color(0xFF64CCC5),
      ),
      drawer: const LeftDrawer(),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              onChanged: (query) => filterBooks(query),
              decoration: InputDecoration(
                labelText: 'Search by book title',
                labelStyle: TextStyle(color: Color(0xFF64CCC5)),
                prefixIcon: Icon(Icons.search, color: Color(0xFF64CCC5)),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Color(0xFF64CCC5)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Color(0xFF64CCC5)),
                ),
              ),
              style: TextStyle(color: Color(0xFF64CCC5)),
            ),
          ),
          Expanded(
            child: displayedBooks.isEmpty
                ? const Center(
                    child: Text(
                      "No matching books found.",
                      style: TextStyle(color: Color(0xFF64CCC5), fontSize: 20),
                    ),
                  )
                : ListView.builder(
                    itemBuilder: (_, index) => InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => BookDetailPage(
                              book: displayedBooks[index],
                            ),
                          ),
                        );
                      },
                      child: Card(
                        color: const Color(0xFF176B87),
                        elevation: 5,
                        margin: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 12,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Row(
                            children: [
                              Hero(
                                tag:
                                    "book-${displayedBooks[index].fields.title}",
                                child: Image.network(
                                  "${displayedBooks[index].fields.imageLink}",
                                  width: 80,
                                  height: 120,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              const SizedBox(width: 16),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "${displayedBooks[index].fields.title}",
                                      style: const TextStyle(
                                        fontSize: 18.0,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                    ),
                                    const SizedBox(height: 10),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    itemCount: displayedBooks.length,
                  ),
          ),
        ],
      ),
    );
  }
}
