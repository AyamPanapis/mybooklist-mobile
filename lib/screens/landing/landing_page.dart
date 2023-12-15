import 'package:flutter/material.dart';
import 'package:mybooklistmobile/screens/landing/item_card.dart';
import 'package:mybooklistmobile/widgets/left_drawer.dart';

class MyHomePage extends StatelessWidget {
  MyHomePage({Key? key}) : super(key: key);

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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              Container(
                child: Column(
                  children: [
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
                  ],
                ),
              ),
              GridView.count(
                primary: true,
                padding: const EdgeInsets.all(20),
                crossAxisSpacing: 50,
                mainAxisSpacing: 50,
                crossAxisCount: 3,
                shrinkWrap: true,
                children: items.map((ShopItem item) {
                  return ShopCard(item);
                }).toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
