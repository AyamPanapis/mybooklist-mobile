import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mybooklistmobile/models/booklistprofile/readingbooks.dart';
import 'package:mybooklistmobile/widgets/left_drawer.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';
import 'package:mybooklistmobile/models/drawer_models.dart';

class ProductPage extends StatefulWidget {
  const ProductPage({Key? key}) : super(key: key);

  @override
  _ProductPageState createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  @override
  Future<String> fetchUser(BuildContext context) async {
    if (context.read<CookieRequest>().loggedIn) {
      var response = await http.get(
        Uri.parse('http://127.0.0.1:8000/auth/user_data/'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${context.read<CookieRequest>()}',
        },
      );

      if (response.statusCode == 200) {
        Map<String, dynamic> userData = json.decode(response.body);
        return userData['username'];
      } else {
        return "Error getting username";
      }
    } else {
      return "Guest";
    }
  }

  Widget build(BuildContext context) {
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
              return Text(
                userSnapshot.data ?? "Guest",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              );
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
    var data = await request.get('http://127.0.0.1:8000/profile/$endpoint/');
    List<Product> list_product = [];
    for (var d in data) {
      if (d != null) {
        list_product.add(Product.fromJson(d));
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
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: snapshot.data!.map((product) {
                  return Card(
                    color: const Color(0xFF64CCC5),
                    margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
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
                            style: TextStyle(color: Colors.white, fontSize: 18.0),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            "${product.fields.publisher}",
                            style: TextStyle(color: Colors.white, fontSize: 18.0),
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
