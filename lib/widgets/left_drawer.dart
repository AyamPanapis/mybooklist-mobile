import 'package:flutter/material.dart';
import 'package:mybooklistmobile/screens/auth/login.dart';
// import 'package:mybooklistmobile/screens/auth/register.dart';
// import 'package:mybooklistmobile/screens/category/category_page.dart';
import 'package:mybooklistmobile/screens/landing/landing_page.dart';
import 'package:mybooklistmobile/screens/book/book_page.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';
import 'package:mybooklistmobile/models/drawer_models.dart';

class LeftDrawer extends StatelessWidget {
  const LeftDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();
    return Drawer(
      backgroundColor: const Color(0xFF176B87),
      child: ListView(
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(
              color: Color(0xFFDAFFFB),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(padding: EdgeInsets.only(top: 44)),
                Text(
                  'Hez',
                  style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                Text(
                  "See Profile>>",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w100,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
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
            // redirect to MyHomePage
            onTap: () {
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MyHomePage(),
                  ));
            },
          ),
          Divider(
            // Add a white divider
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
              onTap: () {
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => BookDetailPage(),
                    ));
              }),
          Divider(
            // Add a white divider
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
          ),
          Divider(
            // Add a white divider
            color: Colors.white,
            thickness: 1,
            height: 0,
          ),
          ListTile(
            contentPadding: EdgeInsets.only(top: 12, bottom: 12, left: 12),
            leading: const Icon(Icons.logout),
            iconColor: Colors.white,
            title: const Text('Logout'),
            titleTextStyle: TextStyle(
              color: Colors.white,
              fontSize: 26,
              fontWeight: FontWeight.bold,
            ),
            // redirect to ShopFormPage
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const LoginApp(),
                  ));
            },
          ),
        ],
      ),
    );
  }
}
