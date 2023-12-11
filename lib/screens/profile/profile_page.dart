import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:mybooklistmobile/models/booklistprofile/readingbooks.dart';
import 'package:mybooklistmobile/widgets/left_drawer.dart';

class ProductPage extends StatefulWidget {
  const ProductPage({Key? key}) : super(key: key);

  @override
  _ProductPageState createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('MyBookList'),
          backgroundColor: const Color(0xFF001C30),
          foregroundColor: Colors.white,
          bottom: const TabBar(
            tabs: [
              Tab(text: 'Planned'),
              Tab(text: 'Reading'),
              Tab(text: 'Completed'),
            ],
          ),
        ),
        drawer: const Drawer(
          child: LeftDrawer(),
        ),
        backgroundColor: const Color(0xFF001C30),
        body: const TabBarView(
          children: [
            BookCategoryPage(endpoint: 'get-planned'),
            BookCategoryPage(endpoint: 'get-reading'),
            BookCategoryPage(endpoint: 'get-completed'),
          ],
        ),
      ),
    );
  }
}
class BookCategoryPage extends StatelessWidget {
  final String endpoint;

  const BookCategoryPage({Key? key, required this.endpoint}) : super(key: key);

  Future<List<Product>> fetchProduct() async {
    try {
      var url = Uri.parse('http://localhost:8000/profile/$endpoint/');
      var response = await http.get(
        url,
        headers: {"Content-Type": "application/json"},
      );

      print('Response: ${response.body}'); // Add this line for debugging

      if (response.statusCode == 200) {
        var data = jsonDecode(utf8.decode(response.bodyBytes));
        List<Product> list_product = [];
        for (var d in data) {
          if (d != null) {
            list_product.add(Product.fromJson(d));
          }
        }
        return list_product;
      } else {
        // Handle non-200 status codes
        throw 'Failed to load data, status code: ${response.statusCode}';
      }
    } catch (error) {
      // Handle general errors
      print('Error fetching data: $error');
      throw 'Failed to load data';
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: fetchProduct(),
      builder: (context, AsyncSnapshot<List<Product>> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(
            child: Text(
              "Error: ${snapshot.error}",
              style: TextStyle(color: Color(0xFF64CCC5), fontSize: 20),
            ),
          );
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(
            child: Text(
              "No product data available.",
              style: TextStyle(color: Color(0xFF64CCC5), fontSize: 20),
            ),
          );
        } else {
          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (_, index) => Container(
              margin: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 12,
              ),
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "${snapshot.data![index].fields.title}",
                    style: const TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text("${snapshot.data![index].fields.author}"),
                  const SizedBox(height: 10),
                  Text("${snapshot.data![index].fields.publisher}"),
                  const SizedBox(height: 10),
                  Container(
                    height: 100,
                    width: 100,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(
                          snapshot.data![index].fields.imageLink,
                        ),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        }
      },
    );
  }
}
