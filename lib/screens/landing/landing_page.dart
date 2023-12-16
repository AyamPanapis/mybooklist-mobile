import 'package:flutter/material.dart';
import 'package:mybooklistmobile/screens/auth/login.dart';
import 'package:mybooklistmobile/screens/category/category_page.dart';
import 'package:mybooklistmobile/screens/landing/item_card.dart';
import 'package:mybooklistmobile/screens/profile/profile_page.dart';
import 'package:mybooklistmobile/widgets/left_drawer.dart';
import 'package:mybooklistmobile/screens/landing/upcoming_book.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _currentIndex = 0;

  final List<ShopItem> items = [
    ShopItem("Profile", Icons.account_circle_outlined, const Color(0xFF64CCC5), "1"),
    ShopItem("Category", Icons.category_outlined, const Color(0xFF64CCC5), "2"),
    ShopItem("Logout", Icons.logout, const Color(0xFF64CCC5), "3"),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF001C30),
      appBar: AppBar(
        title: const Text(
          'MyBookList',
        ),
        backgroundColor: const Color(0xFF001C30),
        foregroundColor: Colors.white,
      ),
      drawer: const Drawer(
        child: LeftDrawer(),
      ),
      body: IndexedStack(
        index: _currentIndex,
        children: [
          MyHomePageContent(items),
          ProductPage(),
          CategoryPage(),
          LoginApp(),
          // Add other pages here like ProductPage, CategoryPage, LoginApp()
        ],
      ),
      bottomNavigationBar: _buildBottomNavigation(),
    );
  }

  BottomNavigationBar _buildBottomNavigation() {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      showSelectedLabels: false,
      showUnselectedLabels: false,
      selectedItemColor: const Color(0xFF001C30),
      currentIndex: _currentIndex,
      onTap: (index) {
        setState(() {
          _currentIndex = index;
        });
      },
      items: const [
        BottomNavigationBarItem(
          label: 'Home',
          icon: Icon(Icons.home_rounded),
        ),
        BottomNavigationBarItem(
          label: 'Profile',
          icon: Icon(Icons.account_circle),
        ),
        BottomNavigationBarItem(
          label: 'Category',
          icon: Icon(Icons.category_outlined),
        ),
        BottomNavigationBarItem(
          label: 'Logout',
          icon: Icon(Icons.logout),
        )
      ],
    );
  }
}

class MyHomePageContent extends StatelessWidget {
  final List<ShopItem> items;

  const MyHomePageContent(this.items);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Stack(
              children: [
                Align(
                  alignment: const AlignmentDirectional(0.00, 0.00),
                  child: Image.asset(
                    'lib/assets/Lovepik_com-401193570-girl-holding-a-book.png',
                    width: double.infinity,
                    height: 255,
                    fit: BoxFit.none,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
                  child: Column(
                    children: [
                      Text(
                        'MyBookList',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Color(0xFF64CCC5),
                          fontSize: 55,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'Explore new worlds, one book at a time',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Color(0xFF64CCC5),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Search Author, Title...',
                    hintStyle: TextStyle(color: Colors.grey),
                    icon: Icon(Icons.search),
                    border: InputBorder.none,
                  ),
                ),
              ),
            ),
            ComingBook(),
            GridView.count(
              primary: true,
              padding: const EdgeInsets.all(20),
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              crossAxisCount: 3,
              shrinkWrap: true,
              children: items.map((ShopItem item) {
                return ShopCard(item);
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}

