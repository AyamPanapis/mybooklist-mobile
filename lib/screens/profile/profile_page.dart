import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:mybooklistmobile/models/booklistprofile/readingbooks.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Good Reads!',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: BookListScreen(),
    );
  }
}

class BookListScreen extends StatelessWidget {
  final List<String> categories = ['Planned to Read', 'Reading', 'Completed'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Good Reads!'),
      ),
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'Current User',
              style: Theme.of(context).textTheme.headline6,
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: categories.length,
              itemBuilder: (context, index) {
                return BookCategorySection(
                  title: categories[index],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class BookCategorySection extends StatefulWidget {
  final String title;

  BookCategorySection({required this.title});

  @override
  _BookCategorySectionState createState() => _BookCategorySectionState();
}

class _BookCategorySectionState extends State<BookCategorySection> {
  late Future<List<Product>> books;

  @override
  void initState() {
    super.initState();
    // Obtain the user's authentication token during the login process
    String authToken = "your_auth_token_here";
    books = fetchBooks(widget.title, authToken);
  }

  Future<List<Product>> fetchBooks(String category, String authToken) async {
    String endpoint;

    switch (category) {
      case 'Planned to Read':
        endpoint = 'http://localhost:8000/profile/get-planned/';
        break;
      case 'Reading':
        endpoint = 'http://localhost:8000/profile/get-reading/';
        break;
      case 'Completed':
        endpoint = 'http://localhost:8000/profile/get-completed/';
        break;
      default:
        throw Exception('Invalid category: $category');
    }

    final response = await http.get(
      Uri.parse(endpoint),
      headers: {'Authorization': 'Bearer $authToken'},
    );

    if (response.statusCode == 200) {
      return productFromJson(response.body);
    } else {
      throw Exception('Failed to load books. Status code: ${response.statusCode}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Product>>(
      future: books,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else {
          List<Product> bookList = snapshot.data!;
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 16.0),
                child: Text(widget.title, style: Theme.of(context).textTheme.headline5),
              ),
              Container(
                height: 200,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: bookList.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => BookPage(bookList[index])),
                        );
                      },
                      child: Container(
                        width: 150,
                        child: Image.network(
                          bookList[index].fields.imageLink,
                          fit: BoxFit.cover,
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          );
        }
      },
    );
  }
}

class BookPage extends StatelessWidget {
  final Product book;

  BookPage(this.book);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Book Details'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Title: ${book.fields.title}'),
            Text('Author: ${book.fields.author}'),
            Text('Publisher: ${book.fields.publisher}'),
            Text('Description: ${book.fields.description}'),
            // Add more details as needed
          ],
        ),
      ),
    );
  }
}
