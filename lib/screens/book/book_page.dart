import 'package:flutter/material.dart';
import 'package:mybooklistmobile/widgets/left_drawer.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';
import 'dart:convert';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter UI Challenge',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: BookDetailPage(),
    );
  }
}

class BookDetailPage extends StatefulWidget {
  @override
  _BookDetailPageState createState() => _BookDetailPageState();
}

class _BookDetailPageState extends State<BookDetailPage> {
  final TextEditingController _reviewController = TextEditingController();
  final List<Map<String, dynamic>> _reviews = [];

  void _submitReview() {
    if (_reviewController.text.isNotEmpty) {
      setState(() {
        _reviews.insert(0, {
          "username": "ardhika23",
          "timestamp": DateTime.now().toString(),
          "review": _reviewController.text,
          "rating": 5, // Add a default rating or fetch from user input
        });
        _reviewController.clear();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Book Details'),
        backgroundColor: Color(0xFF64CCC5), // Changed AppBar color
      ),
      drawer: const Drawer( child: LeftDrawer()),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Top part with the image
            Container(
              height: 300,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage('Your_Book_Cover_Image_URL'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            // Book title and author
            ListTile(
              title: Text('Harry Potter and the Deathly Hallows'),
              subtitle: Text('J.K. Rowling'),
              titleTextStyle: TextStyle(
                color: Colors.white,
              ),
              subtitleTextStyle: TextStyle(
                color: Colors.white
              ),

            ),
            // Star rating and read count
Padding(
  padding: const EdgeInsets.all(8.0),
  child: Text(
    '⭐ 4.9 (107.3k)  •  0.27M Read',
    style: TextStyle(color: Colors.white), // This line sets the text color to white
  ),
),

            // Genres/tags
            Wrap(
              spacing: 8.0,
              children: <Widget>[
                Chip(label: Text('Action')),
                Chip(label: Text('Fantasy')),
                Chip(label: Text('Supernatural')),
              ],
            ),
            // Description
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Harry Potter and the Deathly Hallows is the seventh and final book in the Harry Potter series by J. K. Rowling...',
                textAlign: TextAlign.justify,
                style: TextStyle(color: Colors.white)
              ),
              
            ),
            // Add to library and read now buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    // Handle add to library
                  },
                  child: Text('Add To Library'),
                ),
                ElevatedButton(
                  onPressed: () {
                    // Handle read now
                  },
                  style: ElevatedButton.styleFrom(primary: Colors.blue),
                  child: Text('Read Now'),
                ),
              ],
            ),
            
            // Review input field
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 16.0),
              child: TextField(
                controller: _reviewController,
                decoration: InputDecoration(
                  hintText: 'Submit your review:',
                  hintStyle: TextStyle(color: Colors.white),
                  border: OutlineInputBorder(),
                  suffixIcon: IconButton(
                    icon: Icon(Icons.send),
                    onPressed: _submitReview,
                  ),
                ),
              ),
            ),
            // Submit button
            ElevatedButton(
              onPressed: _submitReview,
              child: Text('Submit'),
            ),
            
            // Reviews header
Padding(
  padding: const EdgeInsets.symmetric(vertical: 8.0),
  child: Text(
    'Reviews:',
    style: TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.bold,
      color: Colors.white, // This sets the text color to white
    ),
  ),
),

            // Display reviews with a border and gap
            ..._reviews.map((review) => Container(
              margin: const EdgeInsets.only(bottom: 8.0), // Gap between comments
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.shade400), // Comment border
                borderRadius: BorderRadius.circular(5.0), // Rounded corners of the border
                color: Colors.grey.shade200, // Background color of the container
              ),
              child: ListTile(
                title: Text('${review["username"]} (${DateTime.parse(review["timestamp"]).toLocal().toString()})'),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Rating: ${review["rating"]}'), // Assuming you have a 'rating' field
                    Text(review["review"]),
                  ],
                ),
              ),
            )).toList(),
          ],
        ),
      ),
      backgroundColor: Color(0xFF04364A), // Changed background color
    );
  }
}
