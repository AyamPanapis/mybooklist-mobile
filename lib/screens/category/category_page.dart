import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:mybooklistmobile/models/books.dart';
import 'package:mybooklistmobile/widgets/left_drawer.dart';
import 'package:mybooklistmobile/screens/book/book_page.dart';

void main() {
  runApp(CategoryApp());
}

class CategoryApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Category Page',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: CategoryPage(),
    );
  }
}

class CategoryPage extends StatelessWidget {
  Future<List<Book>> fetchItem() async {
    var url = Uri.parse('https://mybooklist-k1-tk.pbp.cs.ui.ac.id/xml/json/');
    var response = await http.get(
      url,
      headers: {"Content-Type": "application/json"},
    );

    // decode the response to JSON
    var data = jsonDecode(utf8.decode(response.bodyBytes));

    List<Book> list_book = [];
    for (var d in data) {
      if (d != null) {
        list_book.add(Book.fromJson(d));
      }
    }
    return list_book;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xFF001C30),
        appBar: AppBar(
          title: Text('Category Page'),
          backgroundColor: const Color(0xFF64CCC5),
          foregroundColor: Colors.white,
        ),
        drawer: const Drawer(
          child: LeftDrawer(),
        ),
        body: FutureBuilder(
            future: fetchItem(),
            builder: (context, AsyncSnapshot snapshot) {
              if (snapshot.data == null) {
                return const Center(child: CircularProgressIndicator());
              } else {
                if (!snapshot.hasData) {
                  return const Column(
                    children: [
                      Text(
                        "No item data available.",
                        style:
                            TextStyle(color: Color(0xFF64CCC5), fontSize: 20),
                      ),
                      SizedBox(height: 8),
                    ],
                  );
                } else {
                  return Column(
                    children: <Widget>[
                      // Category buttons
                      Center(
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: ElevatedButton(
                                        onPressed: () {
                                          Navigator.pushReplacement(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  CategoryPage(),
                                            ),
                                          );
                                        },
                                        child: Text('All'),
                                        style: ElevatedButton.styleFrom(
                                            backgroundColor:
                                                const Color(0xFF232831),
                                            foregroundColor: Colors.white,
                                            side: const BorderSide(
                                                color: Color(0xFF64CCC5)))),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: ElevatedButton(
                                        onPressed: () {
                                          Navigator.pushReplacement(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  EconomicsPage(),
                                            ),
                                          );
                                        },
                                        child: Text('Economics'),
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor:
                                              const Color(0xFF64CCC5),
                                          foregroundColor: Colors.white,
                                        )),
                                  ),
                                ],
                              ),
                              // Second row with 3 buttons
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: ElevatedButton(
                                        onPressed: () {
                                          Navigator.pushReplacement(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  FictionPage(),
                                            ),
                                          );
                                        },
                                        child: Text('Fiction'),
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor:
                                              const Color(0xFF64CCC5),
                                          foregroundColor: Colors.white,
                                        )),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: ElevatedButton(
                                        onPressed: () {
                                          Navigator.pushReplacement(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) => ArtPage(),
                                            ),
                                          );
                                        },
                                        child: Text('Art'),
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor:
                                              const Color(0xFF64CCC5),
                                          foregroundColor: Colors.white,
                                        )),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: ElevatedButton(
                                        onPressed: () {
                                          Navigator.pushReplacement(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  HistoryPage(),
                                            ),
                                          );
                                        },
                                        child: Text('History'),
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor:
                                              const Color(0xFF64CCC5),
                                          foregroundColor: Colors.white,
                                        )),
                                  ),
                                ],
                              ),
                              // Third row with 2 buttons
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: ElevatedButton(
                                        onPressed: () {
                                          Navigator.pushReplacement(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  SciencePage(),
                                            ),
                                          );
                                        },
                                        child: Text('Science'),
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor:
                                              const Color(0xFF64CCC5),
                                          foregroundColor: Colors.white,
                                        )),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: ElevatedButton(
                                        onPressed: () {
                                          Navigator.pushReplacement(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  PhilosophyPage(),
                                            ),
                                          );
                                        },
                                        child: Text('Philosophy'),
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor:
                                              const Color(0xFF64CCC5),
                                          foregroundColor: Colors.white,
                                        )),
                                  ),
                                ],
                              ),
                            ]),
                      ),
                      // Scrollable Image Grid
                      Expanded(
                        child: GridView.builder(
                          padding: const EdgeInsets.all(4.0),
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            childAspectRatio: 1 / 1.5,
                            crossAxisSpacing: 10,
                            mainAxisSpacing: 10,
                          ),
                          itemCount: snapshot.data!.length,
                          itemBuilder: (BuildContext context, int index) {
                            // In a real app, you would load images from a service or local assets.
                            return InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => BookDetailPage(
                                        book: snapshot.data![index]),
                                  ),
                                );
                              },
                              child: Column(
                                children: [
                                  Image.network(
                                    snapshot.data![index].fields.imageLink,
                                    fit: BoxFit.cover,
                                  ),
                                  SizedBox(
                                      height:
                                          2), // Adjust the spacing between image and text
                                  Text(
                                    snapshot.data![index].fields.title,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  );
                }
              }
            }));
  }
}

class ArtPage extends StatelessWidget {
  Future<List<Book>> fetchItem() async {
    var url = Uri.parse('https://mybooklist-k1-tk.pbp.cs.ui.ac.id/xml/json/');
    var response = await http.get(
      url,
      headers: {"Content-Type": "application/json"},
    );

    // decode the response to JSON
    var data = jsonDecode(utf8.decode(response.bodyBytes));

    List<Book> list_book_art = [];
    for (var d in data) {
      if (d != null) {
        if (d['fields']['categories'] == 'Art')
          list_book_art.add(Book.fromJson(d));
      }
    }
    return list_book_art;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xFF001C30),
        appBar: AppBar(
          title: Text('Art Page'),
          backgroundColor: const Color(0xFF64CCC5),
          foregroundColor: Colors.white,
        ),
        drawer: const Drawer(
          child: LeftDrawer(),
        ),
        body: FutureBuilder(
            future: fetchItem(),
            builder: (context, AsyncSnapshot snapshot) {
              if (snapshot.data == null) {
                return const Center(child: CircularProgressIndicator());
              } else {
                if (!snapshot.hasData) {
                  return const Column(
                    children: [
                      Text(
                        "No item data available.",
                        style:
                            TextStyle(color: Color(0xFF64CCC5), fontSize: 20),
                      ),
                      SizedBox(height: 8),
                    ],
                  );
                } else {
                  return Column(
                    children: <Widget>[
                      // Category buttons
                      Center(
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: ElevatedButton(
                                        onPressed: () {
                                          Navigator.pushReplacement(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  CategoryPage(),
                                            ),
                                          );
                                        },
                                        child: Text('All'),
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor:
                                              const Color(0xFF64CCC5),
                                          foregroundColor: Colors.white,
                                        )),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: ElevatedButton(
                                        onPressed: () {
                                          Navigator.pushReplacement(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  EconomicsPage(),
                                            ),
                                          );
                                        },
                                        child: Text('Economics'),
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor:
                                              const Color(0xFF64CCC5),
                                          foregroundColor: Colors.white,
                                        )),
                                  ),
                                ],
                              ),
                              // Second row with 3 buttons
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: ElevatedButton(
                                        onPressed: () {
                                          Navigator.pushReplacement(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  FictionPage(),
                                            ),
                                          );
                                        },
                                        child: Text('Fiction'),
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor:
                                              const Color(0xFF64CCC5),
                                          foregroundColor: Colors.white,
                                        )),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: ElevatedButton(
                                        onPressed: () {
                                          Navigator.pushReplacement(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) => ArtPage(),
                                            ),
                                          );
                                        },
                                        child: Text('Art'),
                                        style: ElevatedButton.styleFrom(
                                            backgroundColor:
                                                const Color(0xFF232831),
                                            foregroundColor: Colors.white,
                                            side: const BorderSide(
                                                color: Color(0xFF64CCC5)))),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: ElevatedButton(
                                        onPressed: () {
                                          Navigator.pushReplacement(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  HistoryPage(),
                                            ),
                                          );
                                        },
                                        child: Text('History'),
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor:
                                              const Color(0xFF64CCC5),
                                          foregroundColor: Colors.white,
                                        )),
                                  ),
                                ],
                              ),
                              // Third row with 2 buttons
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: ElevatedButton(
                                        onPressed: () {
                                          Navigator.pushReplacement(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  SciencePage(),
                                            ),
                                          );
                                        },
                                        child: Text('Science'),
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor:
                                              const Color(0xFF64CCC5),
                                          foregroundColor: Colors.white,
                                        )),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: ElevatedButton(
                                        onPressed: () {
                                          Navigator.pushReplacement(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  PhilosophyPage(),
                                            ),
                                          );
                                        },
                                        child: Text('Philosophy'),
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor:
                                              const Color(0xFF64CCC5),
                                          foregroundColor: Colors.white,
                                        )),
                                  ),
                                ],
                              ),
                            ]),
                      ),
                      // Scrollable Image Grid
                      Expanded(
                        child: GridView.builder(
                          padding: const EdgeInsets.all(4.0),
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            childAspectRatio: 1 / 1.5,
                            crossAxisSpacing: 10,
                            mainAxisSpacing: 10,
                          ),
                          itemCount: snapshot.data!.length,
                          itemBuilder: (BuildContext context, int index) {
                            // In a real app, you would load images from a service or local assets.
                            return InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => BookDetailPage(
                                        book: snapshot.data![index]),
                                  ),
                                );
                              },
                              child: Column(
                                children: [
                                  Image.network(
                                    snapshot.data![index].fields.imageLink,
                                    fit: BoxFit.cover,
                                  ),
                                  SizedBox(
                                      height:
                                          2), // Adjust the spacing between image and text
                                  Text(
                                    snapshot.data![index].fields.title,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  );
                }
              }
            }));
  }
}

class FictionPage extends StatelessWidget {
  Future<List<Book>> fetchItem() async {
    var url = Uri.parse('https://mybooklist-k1-tk.pbp.cs.ui.ac.id/xml/json/');
    var response = await http.get(
      url,
      headers: {"Content-Type": "application/json"},
    );

    // decode the response to JSON
    var data = jsonDecode(utf8.decode(response.bodyBytes));

    List<Book> list_book_art = [];
    for (var d in data) {
      if (d != null) {
        if (d['fields']['categories'] == 'Fiction')
          list_book_art.add(Book.fromJson(d));
      }
    }
    return list_book_art;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xFF001C30),
        appBar: AppBar(
          title: Text('Fiction Page'),
          backgroundColor: const Color(0xFF64CCC5),
          foregroundColor: Colors.white,
        ),
        drawer: const Drawer(
          child: LeftDrawer(),
        ),
        body: FutureBuilder(
            future: fetchItem(),
            builder: (context, AsyncSnapshot snapshot) {
              if (snapshot.data == null) {
                return const Center(child: CircularProgressIndicator());
              } else {
                if (!snapshot.hasData) {
                  return const Column(
                    children: [
                      Text(
                        "No item data available.",
                        style:
                            TextStyle(color: Color(0xFF64CCC5), fontSize: 20),
                      ),
                      SizedBox(height: 8),
                    ],
                  );
                } else {
                  return Column(
                    children: <Widget>[
                      // Category buttons
                      Center(
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: ElevatedButton(
                                        onPressed: () {
                                          Navigator.pushReplacement(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  CategoryPage(),
                                            ),
                                          );
                                        },
                                        child: Text('All'),
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor:
                                              const Color(0xFF64CCC5),
                                          foregroundColor: Colors.white,
                                        )),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: ElevatedButton(
                                        onPressed: () {
                                          Navigator.pushReplacement(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  EconomicsPage(),
                                            ),
                                          );
                                        },
                                        child: Text('Economics'),
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor:
                                              const Color(0xFF64CCC5),
                                          foregroundColor: Colors.white,
                                        )),
                                  ),
                                ],
                              ),
                              // Second row with 3 buttons
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: ElevatedButton(
                                        onPressed: () {
                                          Navigator.pushReplacement(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  FictionPage(),
                                            ),
                                          );
                                        },
                                        child: Text('Fiction'),
                                        style: ElevatedButton.styleFrom(
                                            backgroundColor:
                                                const Color(0xFF232831),
                                            foregroundColor: Colors.white,
                                            side: const BorderSide(
                                                color: Color(0xFF64CCC5)))),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: ElevatedButton(
                                        onPressed: () {
                                          Navigator.pushReplacement(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) => ArtPage(),
                                            ),
                                          );
                                        },
                                        child: Text('Art'),
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor:
                                              const Color(0xFF64CCC5),
                                          foregroundColor: Colors.white,
                                        )),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: ElevatedButton(
                                        onPressed: () {
                                          Navigator.pushReplacement(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  HistoryPage(),
                                            ),
                                          );
                                        },
                                        child: Text('History'),
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor:
                                              const Color(0xFF64CCC5),
                                          foregroundColor: Colors.white,
                                        )),
                                  ),
                                ],
                              ),
                              // Third row with 2 buttons
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: ElevatedButton(
                                        onPressed: () {
                                          Navigator.pushReplacement(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  SciencePage(),
                                            ),
                                          );
                                        },
                                        child: Text('Science'),
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor:
                                              const Color(0xFF64CCC5),
                                          foregroundColor: Colors.white,
                                        )),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: ElevatedButton(
                                        onPressed: () {
                                          Navigator.pushReplacement(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  PhilosophyPage(),
                                            ),
                                          );
                                        },
                                        child: Text('Philosophy'),
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor:
                                              const Color(0xFF64CCC5),
                                          foregroundColor: Colors.white,
                                        )),
                                  ),
                                ],
                              ),
                            ]),
                      ),
                      // Scrollable Image Grid
                      Expanded(
                        child: GridView.builder(
                          padding: const EdgeInsets.all(4.0),
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            childAspectRatio: 1 / 1.5,
                            crossAxisSpacing: 10,
                            mainAxisSpacing: 10,
                          ),
                          itemCount: snapshot.data!.length,
                          itemBuilder: (BuildContext context, int index) {
                            // In a real app, you would load images from a service or local assets.
                            return InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => BookDetailPage(
                                        book: snapshot.data![index]),
                                  ),
                                );
                              },
                              child: Column(
                                children: [
                                  Image.network(
                                    snapshot.data![index].fields.imageLink,
                                    fit: BoxFit.cover,
                                  ),
                                  SizedBox(
                                      height:
                                          2), // Adjust the spacing between image and text
                                  Text(
                                    snapshot.data![index].fields.title,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  );
                }
              }
            }));
  }
}

class EconomicsPage extends StatelessWidget {
  Future<List<Book>> fetchItem() async {
    var url = Uri.parse('https://mybooklist-k1-tk.pbp.cs.ui.ac.id/xml/json/');
    var response = await http.get(
      url,
      headers: {"Content-Type": "application/json"},
    );

    // decode the response to JSON
    var data = jsonDecode(utf8.decode(response.bodyBytes));

    List<Book> list_book_art = [];
    for (var d in data) {
      if (d != null) {
        if (d['fields']['categories'] == 'Economics')
          list_book_art.add(Book.fromJson(d));
      }
    }
    return list_book_art;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xFF001C30),
        appBar: AppBar(
          title: Text('Economics Page'),
          backgroundColor: const Color(0xFF64CCC5),
          foregroundColor: Colors.white,
        ),
        drawer: const Drawer(
          child: LeftDrawer(),
        ),
        body: FutureBuilder(
            future: fetchItem(),
            builder: (context, AsyncSnapshot snapshot) {
              if (snapshot.data == null) {
                return const Center(child: CircularProgressIndicator());
              } else {
                if (!snapshot.hasData) {
                  return const Column(
                    children: [
                      Text(
                        "No item data available.",
                        style:
                            TextStyle(color: Color(0xFF64CCC5), fontSize: 20),
                      ),
                      SizedBox(height: 8),
                    ],
                  );
                } else {
                  return Column(
                    children: <Widget>[
                      // Category buttons
                      Center(
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: ElevatedButton(
                                        onPressed: () {
                                          Navigator.pushReplacement(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  CategoryPage(),
                                            ),
                                          );
                                        },
                                        child: Text('All'),
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor:
                                              const Color(0xFF64CCC5),
                                          foregroundColor: Colors.white,
                                        )),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: ElevatedButton(
                                        onPressed: () {
                                          Navigator.pushReplacement(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  EconomicsPage(),
                                            ),
                                          );
                                        },
                                        child: Text('Economics'),
                                        style: ElevatedButton.styleFrom(
                                            backgroundColor:
                                                const Color(0xFF232831),
                                            foregroundColor: Colors.white,
                                            side: const BorderSide(
                                                color: Color(0xFF64CCC5)))),
                                  ),
                                ],
                              ),
                              // Second row with 3 buttons
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: ElevatedButton(
                                        onPressed: () {
                                          Navigator.pushReplacement(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  FictionPage(),
                                            ),
                                          );
                                        },
                                        child: Text('Fiction'),
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor:
                                              const Color(0xFF64CCC5),
                                          foregroundColor: Colors.white,
                                        )),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: ElevatedButton(
                                        onPressed: () {
                                          Navigator.pushReplacement(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) => ArtPage(),
                                            ),
                                          );
                                        },
                                        child: Text('Art'),
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor:
                                              const Color(0xFF64CCC5),
                                          foregroundColor: Colors.white,
                                        )),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: ElevatedButton(
                                        onPressed: () {
                                          Navigator.pushReplacement(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  HistoryPage(),
                                            ),
                                          );
                                        },
                                        child: Text('History'),
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor:
                                              const Color(0xFF64CCC5),
                                          foregroundColor: Colors.white,
                                        )),
                                  ),
                                ],
                              ),
                              // Third row with 2 buttons
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: ElevatedButton(
                                        onPressed: () {
                                          Navigator.pushReplacement(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  SciencePage(),
                                            ),
                                          );
                                        },
                                        child: Text('Science'),
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor:
                                              const Color(0xFF64CCC5),
                                          foregroundColor: Colors.white,
                                        )),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: ElevatedButton(
                                        onPressed: () {
                                          Navigator.pushReplacement(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  PhilosophyPage(),
                                            ),
                                          );
                                        },
                                        child: Text('Philosophy'),
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor:
                                              const Color(0xFF64CCC5),
                                          foregroundColor: Colors.white,
                                        )),
                                  ),
                                ],
                              ),
                            ]),
                      ),
                      // Scrollable Image Grid
                      Expanded(
                        child: GridView.builder(
                          padding: const EdgeInsets.all(4.0),
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            childAspectRatio: 1 / 1.5,
                            crossAxisSpacing: 10,
                            mainAxisSpacing: 10,
                          ),
                          itemCount: snapshot.data!.length,
                          itemBuilder: (BuildContext context, int index) {
                            // In a real app, you would load images from a service or local assets.
                            return InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => BookDetailPage(
                                        book: snapshot.data![index]),
                                  ),
                                );
                              },
                              child: Column(
                                children: [
                                  Image.network(
                                    snapshot.data![index].fields.imageLink,
                                    fit: BoxFit.cover,
                                  ),
                                  SizedBox(
                                      height:
                                          2), // Adjust the spacing between image and text
                                  Text(
                                    snapshot.data![index].fields.title,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  );
                }
              }
            }));
  }
}

class HistoryPage extends StatelessWidget {
  Future<List<Book>> fetchItem() async {
    var url = Uri.parse('https://mybooklist-k1-tk.pbp.cs.ui.ac.id/xml/json/');
    var response = await http.get(
      url,
      headers: {"Content-Type": "application/json"},
    );

    // decode the response to JSON
    var data = jsonDecode(utf8.decode(response.bodyBytes));

    List<Book> list_book_art = [];
    for (var d in data) {
      if (d != null) {
        if (d['fields']['categories'] == 'History')
          list_book_art.add(Book.fromJson(d));
      }
    }
    return list_book_art;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xFF001C30),
        appBar: AppBar(
          title: Text('History Page'),
          backgroundColor: const Color(0xFF64CCC5),
          foregroundColor: Colors.white,
        ),
        drawer: const Drawer(
          child: LeftDrawer(),
        ),
        body: FutureBuilder(
            future: fetchItem(),
            builder: (context, AsyncSnapshot snapshot) {
              if (snapshot.data == null) {
                return const Center(child: CircularProgressIndicator());
              } else {
                if (!snapshot.hasData) {
                  return const Column(
                    children: [
                      Text(
                        "No item data available.",
                        style:
                            TextStyle(color: Color(0xFF64CCC5), fontSize: 20),
                      ),
                      SizedBox(height: 8),
                    ],
                  );
                } else {
                  return Column(
                    children: <Widget>[
                      // Category buttons
                      Center(
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: ElevatedButton(
                                        onPressed: () {
                                          Navigator.pushReplacement(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  CategoryPage(),
                                            ),
                                          );
                                        },
                                        child: Text('All'),
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor:
                                              const Color(0xFF64CCC5),
                                          foregroundColor: Colors.white,
                                        )),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: ElevatedButton(
                                        onPressed: () {
                                          Navigator.pushReplacement(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  EconomicsPage(),
                                            ),
                                          );
                                        },
                                        child: Text('Economics'),
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor:
                                              const Color(0xFF64CCC5),
                                          foregroundColor: Colors.white,
                                        )),
                                  ),
                                ],
                              ),
                              // Second row with 3 buttons
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: ElevatedButton(
                                        onPressed: () {
                                          Navigator.pushReplacement(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  FictionPage(),
                                            ),
                                          );
                                        },
                                        child: Text('Fiction'),
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor:
                                              const Color(0xFF64CCC5),
                                          foregroundColor: Colors.white,
                                        )),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: ElevatedButton(
                                        onPressed: () {
                                          Navigator.pushReplacement(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) => ArtPage(),
                                            ),
                                          );
                                        },
                                        child: Text('Art'),
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor:
                                              const Color(0xFF64CCC5),
                                          foregroundColor: Colors.white,
                                        )),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: ElevatedButton(
                                        onPressed: () {
                                          Navigator.pushReplacement(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  HistoryPage(),
                                            ),
                                          );
                                        },
                                        child: Text('History'),
                                        style: ElevatedButton.styleFrom(
                                            backgroundColor:
                                                const Color(0xFF232831),
                                            foregroundColor: Colors.white,
                                            side: const BorderSide(
                                                color: Color(0xFF64CCC5)))),
                                  ),
                                ],
                              ),
                              // Third row with 2 buttons
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: ElevatedButton(
                                        onPressed: () {
                                          Navigator.pushReplacement(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  SciencePage(),
                                            ),
                                          );
                                        },
                                        child: Text('Science'),
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor:
                                              const Color(0xFF64CCC5),
                                          foregroundColor: Colors.white,
                                        )),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: ElevatedButton(
                                        onPressed: () {
                                          Navigator.pushReplacement(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  PhilosophyPage(),
                                            ),
                                          );
                                        },
                                        child: Text('Philosophy'),
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor:
                                              const Color(0xFF64CCC5),
                                          foregroundColor: Colors.white,
                                        )),
                                  ),
                                ],
                              ),
                            ]),
                      ),
                      // Scrollable Image Grid
                      Expanded(
                        child: GridView.builder(
                          padding: const EdgeInsets.all(4.0),
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            childAspectRatio: 1 / 1.5,
                            crossAxisSpacing: 10,
                            mainAxisSpacing: 10,
                          ),
                          itemCount: snapshot.data!.length,
                          itemBuilder: (BuildContext context, int index) {
                            // In a real app, you would load images from a service or local assets.
                            return InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => BookDetailPage(
                                        book: snapshot.data![index]),
                                  ),
                                );
                              },
                              child: Column(
                                children: [
                                  Image.network(
                                    snapshot.data![index].fields.imageLink,
                                    fit: BoxFit.cover,
                                  ),
                                  SizedBox(
                                      height:
                                          2), // Adjust the spacing between image and text
                                  Text(
                                    snapshot.data![index].fields.title,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  );
                }
              }
            }));
  }
}

class SciencePage extends StatelessWidget {
  Future<List<Book>> fetchItem() async {
    var url = Uri.parse('https://mybooklist-k1-tk.pbp.cs.ui.ac.id/xml/json/');
    var response = await http.get(
      url,
      headers: {"Content-Type": "application/json"},
    );

    // decode the response to JSON
    var data = jsonDecode(utf8.decode(response.bodyBytes));

    List<Book> list_book_art = [];
    for (var d in data) {
      if (d != null) {
        if (d['fields']['categories'] == 'Science')
          list_book_art.add(Book.fromJson(d));
      }
    }
    return list_book_art;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xFF001C30),
        appBar: AppBar(
          title: Text('Science Page'),
          backgroundColor: const Color(0xFF64CCC5),
          foregroundColor: Colors.white,
        ),
        drawer: const Drawer(
          child: LeftDrawer(),
        ),
        body: FutureBuilder(
            future: fetchItem(),
            builder: (context, AsyncSnapshot snapshot) {
              if (snapshot.data == null) {
                return const Center(child: CircularProgressIndicator());
              } else {
                if (!snapshot.hasData) {
                  return const Column(
                    children: [
                      Text(
                        "No item data available.",
                        style:
                            TextStyle(color: Color(0xFF64CCC5), fontSize: 20),
                      ),
                      SizedBox(height: 8),
                    ],
                  );
                } else {
                  return Column(
                    children: <Widget>[
                      // Category buttons
                      Center(
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: ElevatedButton(
                                        onPressed: () {
                                          Navigator.pushReplacement(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  CategoryPage(),
                                            ),
                                          );
                                        },
                                        child: Text('All'),
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor:
                                              const Color(0xFF64CCC5),
                                          foregroundColor: Colors.white,
                                        )),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: ElevatedButton(
                                        onPressed: () {
                                          Navigator.pushReplacement(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  EconomicsPage(),
                                            ),
                                          );
                                        },
                                        child: Text('Economics'),
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor:
                                              const Color(0xFF64CCC5),
                                          foregroundColor: Colors.white,
                                        )),
                                  ),
                                ],
                              ),
                              // Second row with 3 buttons
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: ElevatedButton(
                                        onPressed: () {
                                          Navigator.pushReplacement(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  FictionPage(),
                                            ),
                                          );
                                        },
                                        child: Text('Fiction'),
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor:
                                              const Color(0xFF64CCC5),
                                          foregroundColor: Colors.white,
                                        )),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: ElevatedButton(
                                        onPressed: () {
                                          Navigator.pushReplacement(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) => ArtPage(),
                                            ),
                                          );
                                        },
                                        child: Text('Art'),
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor:
                                              const Color(0xFF64CCC5),
                                          foregroundColor: Colors.white,
                                        )),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: ElevatedButton(
                                        onPressed: () {
                                          Navigator.pushReplacement(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  HistoryPage(),
                                            ),
                                          );
                                        },
                                        child: Text('History'),
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor:
                                              const Color(0xFF64CCC5),
                                          foregroundColor: Colors.white,
                                        )),
                                  ),
                                ],
                              ),
                              // Third row with 2 buttons
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: ElevatedButton(
                                        onPressed: () {
                                          Navigator.pushReplacement(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  SciencePage(),
                                            ),
                                          );
                                        },
                                        child: Text('Science'),
                                        style: ElevatedButton.styleFrom(
                                            backgroundColor:
                                                const Color(0xFF232831),
                                            foregroundColor: Colors.white,
                                            side: const BorderSide(
                                                color: Color(0xFF64CCC5)))),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: ElevatedButton(
                                        onPressed: () {
                                          Navigator.pushReplacement(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  PhilosophyPage(),
                                            ),
                                          );
                                        },
                                        child: Text('Philosophy'),
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor:
                                              const Color(0xFF64CCC5),
                                          foregroundColor: Colors.white,
                                        )),
                                  ),
                                ],
                              ),
                            ]),
                      ),
                      // Scrollable Image Grid
                      Expanded(
                        child: GridView.builder(
                          padding: const EdgeInsets.all(4.0),
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            childAspectRatio: 1 / 1.5,
                            crossAxisSpacing: 10,
                            mainAxisSpacing: 10,
                          ),
                          itemCount: snapshot.data!.length,
                          itemBuilder: (BuildContext context, int index) {
                            // In a real app, you would load images from a service or local assets.
                            return InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => BookDetailPage(
                                        book: snapshot.data![index]),
                                  ),
                                );
                              },
                              child: Column(
                                children: [
                                  Image.network(
                                    snapshot.data![index].fields.imageLink,
                                    fit: BoxFit.cover,
                                  ),
                                  SizedBox(
                                      height:
                                          2), // Adjust the spacing between image and text
                                  Text(
                                    snapshot.data![index].fields.title,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  );
                }
              }
            }));
  }
}

class PhilosophyPage extends StatelessWidget {
  Future<List<Book>> fetchItem() async {
    var url = Uri.parse('https://mybooklist-k1-tk.pbp.cs.ui.ac.id/xml/json/');
    var response = await http.get(
      url,
      headers: {"Content-Type": "application/json"},
    );

    // decode the response to JSON
    var data = jsonDecode(utf8.decode(response.bodyBytes));

    List<Book> list_book_art = [];
    for (var d in data) {
      if (d != null) {
        if (d['fields']['categories'] == 'Philosophy')
          list_book_art.add(Book.fromJson(d));
      }
    }
    return list_book_art;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xFF001C30),
        appBar: AppBar(
          title: Text('Philosophy Page'),
          backgroundColor: const Color(0xFF64CCC5),
          foregroundColor: Colors.white,
        ),
        drawer: const Drawer(
          child: LeftDrawer(),
        ),
        body: FutureBuilder(
            future: fetchItem(),
            builder: (context, AsyncSnapshot snapshot) {
              if (snapshot.data == null) {
                return const Center(child: CircularProgressIndicator());
              } else {
                if (!snapshot.hasData) {
                  return const Column(
                    children: [
                      Text(
                        "No item data available.",
                        style:
                            TextStyle(color: Color(0xFF64CCC5), fontSize: 20),
                      ),
                      SizedBox(height: 8),
                    ],
                  );
                } else {
                  return Column(
                    children: <Widget>[
                      // Category buttons
                      Center(
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: ElevatedButton(
                                        onPressed: () {
                                          Navigator.pushReplacement(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  CategoryPage(),
                                            ),
                                          );
                                        },
                                        child: Text('All'),
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor:
                                              const Color(0xFF64CCC5),
                                          foregroundColor: Colors.white,
                                        )),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: ElevatedButton(
                                        onPressed: () {
                                          Navigator.pushReplacement(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  EconomicsPage(),
                                            ),
                                          );
                                        },
                                        child: Text('Economics'),
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor:
                                              const Color(0xFF64CCC5),
                                          foregroundColor: Colors.white,
                                        )),
                                  ),
                                ],
                              ),
                              // Second row with 3 buttons
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: ElevatedButton(
                                        onPressed: () {
                                          Navigator.pushReplacement(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  FictionPage(),
                                            ),
                                          );
                                        },
                                        child: Text('Fiction'),
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor:
                                              const Color(0xFF64CCC5),
                                          foregroundColor: Colors.white,
                                        )),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: ElevatedButton(
                                        onPressed: () {
                                          Navigator.pushReplacement(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) => ArtPage(),
                                            ),
                                          );
                                        },
                                        child: Text('Art'),
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor:
                                              const Color(0xFF64CCC5),
                                          foregroundColor: Colors.white,
                                        )),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: ElevatedButton(
                                        onPressed: () {
                                          Navigator.pushReplacement(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  HistoryPage(),
                                            ),
                                          );
                                        },
                                        child: Text('History'),
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor:
                                              const Color(0xFF64CCC5),
                                          foregroundColor: Colors.white,
                                        )),
                                  ),
                                ],
                              ),
                              // Third row with 2 buttons
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: ElevatedButton(
                                        onPressed: () {
                                          Navigator.pushReplacement(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  SciencePage(),
                                            ),
                                          );
                                        },
                                        child: Text('Science'),
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor:
                                              const Color(0xFF64CCC5),
                                          foregroundColor: Colors.white,
                                        )),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: ElevatedButton(
                                        onPressed: () {
                                          Navigator.pushReplacement(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  PhilosophyPage(),
                                            ),
                                          );
                                        },
                                        child: Text('Philosophy'),
                                        style: ElevatedButton.styleFrom(
                                            backgroundColor:
                                                const Color(0xFF232831),
                                            foregroundColor: Colors.white,
                                            side: const BorderSide(
                                                color: Color(0xFF64CCC5)))),
                                  ),
                                ],
                              ),
                            ]),
                      ),
                      // Scrollable Image Grid
                      Expanded(
                        child: GridView.builder(
                          padding: const EdgeInsets.all(4.0),
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            childAspectRatio: 1 / 1.5,
                            crossAxisSpacing: 10,
                            mainAxisSpacing: 10,
                          ),
                          itemCount: snapshot.data!.length,
                          itemBuilder: (BuildContext context, int index) {
                            // In a real app, you would load images from a service or local assets.
                            return InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => BookDetailPage(
                                        book: snapshot.data![index]),
                                  ),
                                );
                              },
                              child: Column(
                                children: [
                                  Image.network(
                                    snapshot.data![index].fields.imageLink,
                                    fit: BoxFit.cover,
                                  ),
                                  SizedBox(
                                      height:
                                          2), // Adjust the spacing between image and text
                                  Text(
                                    snapshot.data![index].fields.title,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  );
                }
              }
            }));
  }
}
