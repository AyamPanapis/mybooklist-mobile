import 'package:flutter/material.dart';

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

class BookCategorySection extends StatelessWidget {
  final String title;

  BookCategorySection({required this.title});

  @override
  Widget build(BuildContext context) {
    // Dummy data for book images
    List<String> bookImages = [
      'path/to/your/book/image1.png',
      'path/to/your/book/image2.png',
      'path/to/your/book/image3.png',
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 16.0),
          child: Text(title, style: Theme.of(context).textTheme.headline5),
        ),
        Container(
          height: 200, // Adjust height accordingly
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: bookImages.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  // Navigate to book page
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => BookPage()),
                  );
                },
                child: Container(
                  width: 150, // Adjust width accordingly
                  child: Image.network(bookImages[index], fit: BoxFit.cover), // Use Image.asset for local images
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}


class BookPage extends StatelessWidget {
  // In a real app, you would pass the book details to this page.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Book Details'),
      ),
      body: Center(
        child: Text('Details of the book go here'),
      ),
    );
  }
}
