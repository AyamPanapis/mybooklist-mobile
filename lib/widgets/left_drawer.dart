import 'package:flutter/material.dart';
import 'package:mybooklistmobile/screens/auth/login.dart';

import 'package:mybooklistmobile/screens/category/category_page.dart';

import 'package:mybooklistmobile/screens/landing/landing_page.dart';
import 'package:mybooklistmobile/screens/book/book_page.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';
import 'package:mybooklistmobile/models/drawer_models.dart';
import 'package:mybooklistmobile/screens/profile/profile_page.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class LeftDrawer extends StatefulWidget {
  const LeftDrawer({Key? key}) : super(key: key);

  @override
  _LeftDrawerState createState() => _LeftDrawerState();
}

class _LeftDrawerState extends State<LeftDrawer> {
  Future<String> _getUserName(BuildContext context) async {
    if (context.read<CookieRequest>().loggedIn) {
      // Make an HTTP request to get the username
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
        // Handle the error, you can return an error message or throw an exception
        return "Error getting username";
      }
    } else {
      return "Guest";
    }
  }

  Future<String> _inOrout(BuildContext context) async {
    // Your logic to get the user's name goes here.
    if (context.read<CookieRequest>().loggedIn) {
      return "Logout";
    } else {
      return "Login";
    }
  }

  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();

    return Drawer(
      backgroundColor: const Color(0xFF176B87),
      child: ListView(
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: Color(0xFFDAFFFB),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(padding: EdgeInsets.only(top: 68)),
                FutureBuilder<String>(
                  future: Future.delayed(
                      Duration.zero, () => _getUserName(context)),
                  builder: (context, AsyncSnapshot<String> snapshot) {
                    return Text(
                      snapshot.data ?? "Guest",
                      style: TextStyle(
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
          InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const ProductPage(),
                ),
              );
            },
            child: ListTile(
              contentPadding: EdgeInsets.only(top: 12, bottom: 12, left: 12),
              leading: const Icon(Icons.person),
              iconColor: Colors.white,
              title: const Text(
                'See Profile',
                style: TextStyle(
                  color: Colors.white, // Set the text color
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          Divider(
            color: Colors.white,
            thickness: 1,
            height: 0,
          ),
          ListTile(
            contentPadding: EdgeInsets.only(top: 12, bottom: 12, left: 12),
            leading: const Icon(Icons.home_outlined),
            iconColor: Colors.white,
            title: const Text('Home'),
            titleTextStyle: TextStyle(
              color: Colors.white,
              fontSize: 26,
              fontWeight: FontWeight.bold,
            ),
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => MyHomePage(),
                ),
              );
            },
          ),
          Divider(
            color: Colors.white,
            thickness: 1,
            height: 0,
          ),
          ListTile(
            contentPadding: EdgeInsets.only(top: 12, bottom: 12, left: 12),
            leading: const Icon(Icons.search),
            iconColor: Colors.white,
            title: const Text('Search'),
            titleTextStyle: TextStyle(
              color: Colors.white,
              fontSize: 26,
              fontWeight: FontWeight.bold,
            ),
            onTap: () async {
              if (request.loggedIn) {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => BookDetailPage(),
                  ),
                );
              } else {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const LoginApp(),
                  ),
                );
              }
            },
          ),
          Divider(
            color: Colors.white,
            thickness: 1,
            height: 0,
          ),
          ListTile(
            contentPadding: EdgeInsets.only(top: 12, bottom: 12, left: 12),
            leading: const Icon(Icons.book_sharp),
            iconColor: Colors.white,
            title: const Text('Category'),
            titleTextStyle: TextStyle(
              color: Colors.white,
              fontSize: 26,
              fontWeight: FontWeight.bold,
            ),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CategoryPage(),
                  ));
            },
          ),
          Divider(
            color: Colors.white,
            thickness: 1,
            height: 0,
          ),
          ListTile(
            contentPadding: EdgeInsets.only(top: 12, bottom: 12, left: 12),
            leading: const Icon(Icons.logout),
            iconColor: Colors.white,
            title: FutureBuilder<String>(
              future: Future.delayed(Duration.zero, () => _inOrout(context)),
              builder: (context, AsyncSnapshot<String> snapshot) {
                return Text(
                  snapshot.data ?? "Login",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                  ),
                );
              },
            ),
            onTap: () {
              if (request.loggedIn) {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const LoginApp(),
                  ),
                );
              } else {
                // Navigate to the login page
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const LoginApp(),
                  ),
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
