import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mybooklistmobile/models/booklistprofile/readingbooks.dart';
import 'package:mybooklistmobile/widgets/left_drawer.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';

class ProductPage extends StatefulWidget {
  const ProductPage({Key? key}) : super(key: key);

  @override
  _ProductPageState createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  Future<String> fetchUser(BuildContext context) async {
    var response = await context.read<CookieRequest>().get(
          'https://mybooklist-k1-tk.pbp.cs.ui.ac.id/auth/user_data/',
        );
    String uname = response['username'];
    return uname;
  }

  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(0xFF64CCC5),
          foregroundColor: Colors.white,
          bottom: const TabBar(
            tabs: [
              Tab(text: 'Planned'),
              Tab(text: 'Reading'),
              Tab(text: 'Completed'),
            ],
          ),
          title: FutureBuilder<String>(
            future: fetchUser(context),
            builder: (context, AsyncSnapshot<String> userSnapshot) {
              if (request.loggedIn) {
                // Display the fetched username
                return Text(
                  userSnapshot.data ?? "Guest",
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                );
              } else {
                // User is not logged in
                return Text(
                  "Guest",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                );
              }
            },
          ),
        ),
        drawer: const Drawer(
          child: LeftDrawer(),
        ),
        backgroundColor: const Color(0xFF001C30),
        body: const TabBarView(
          children: [
            BookCategoryPage(endpoint: 'get-planned-flutter'),
            BookCategoryPage(endpoint: 'get-reading-flutter'),
            BookCategoryPage(endpoint: 'get-completed-flutter'),
          ],
        ),
      ),
    );
  }
}

class BookCategoryPage extends StatelessWidget {
  final String endpoint;

  const BookCategoryPage({Key? key, required this.endpoint}) : super(key: key);

  Future<List<Product>> fetchProduct(CookieRequest request) async {
    var data = await request
        .get('https://mybooklist-k1-tk.pbp.cs.ui.ac.id/profile/$endpoint/');
    List<Product> list_product = [];
    for (var d in data) {
      if (d != null) {
        list_product.add(Product.fromJson(d));
      } else {
        list_product = [];
      }
    }
    return list_product;
  }

  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();
    return FutureBuilder(
      future: fetchProduct(request),
      builder: (context, AsyncSnapshot<List<Product>> snapshot) {
        if (!snapshot.hasData ||
            snapshot.data == null ||
            snapshot.data!.isEmpty) {
          // Return a placeholder or nothing when there's no data
          return const SizedBox.shrink(); // This returns an empty widget
        }
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: snapshot.data!.map((product) {
                  return Card(
                    color: const Color(0xFF176B87),
                    margin: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 12),
                    child: Container(
                      width: 250,
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            height: 200,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: NetworkImage(product.fields.imageLink),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            "${product.fields.title}",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 24.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            "${product.fields.author}",
                            style:
                                TextStyle(color: Colors.white, fontSize: 18.0),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            "${product.fields.publisher}",
                            style:
                                TextStyle(color: Colors.white, fontSize: 18.0),
                          ),
                        ],
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
          ],
        );
      },
    );
  }
}
