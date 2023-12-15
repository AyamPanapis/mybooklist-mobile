import 'package:flutter/material.dart';
import 'package:mybooklistmobile/models/books.dart';
import 'package:mybooklistmobile/widgets/left_drawer.dart';

class BookDetailPage extends StatefulWidget {
  final Book book;
  const BookDetailPage({
    super.key,
    required this.book,
  });

  @override
  State<BookDetailPage> createState() => _BookDetailPageState();
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
        title: Text(widget.book.fields.title),
        backgroundColor: const Color(0xFF64CCC5), // Changed AppBar color
      ),
      drawer: const Drawer(child: LeftDrawer()),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Top part with the image
            Container(
              height: 300,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(widget.book.fields.imageLink),
                  fit: BoxFit.fitHeight,
                ),
              ),
            ),
            // Book title and author
            ListTile(
              title: Text(
                widget.book.fields.title,
                textAlign: TextAlign.center,
                style: const TextStyle(
                    fontSize: 30.0, fontWeight: FontWeight.bold),
              ),
              subtitle: Column(
                children: [
                  Text(
                    "Author: ${widget.book.fields.author}",
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 20.0),
                  ),
                  Text(
                    "Publisher: ${widget.book.fields.publisher}",
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 20.0),
                  ),
                  Text(
                    "Category: ${widget.book.fields.categories.toString().split(".").last}",
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 20.0),
                  ),
                ],
              ),
              titleTextStyle: const TextStyle(
                color: Colors.white,
              ),
              subtitleTextStyle: const TextStyle(color: Colors.white),
            ),

            // Star rating and read count
            // Padding(
            //   padding: const EdgeInsets.all(8.0),
            //   child: Text(
            //     '⭐ ${widget.book.rating ?? "n/a"} (${widget.book.ratingsCount ?? "n/a"})',
            //     style: TextStyle(
            //       color: Colors.white,
            //     ), // This line sets the text color to white
            //   ),
            // ),

            // Genres/tags
            // Wrap(
            //   spacing: 8.0,
            //   children: <Widget>[
            //     Chip(label: Text('Action')),
            //     Chip(label: Text('Fantasy')),
            //     Chip(label: Text('Supernatural')),
            //   ],
            // ),
            // Description
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                widget.book.fields.description,
                textAlign: TextAlign.justify,
                style: const TextStyle(color: Colors.white),
              ),
            ),
            // Add to library and read now buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    // Handle to read
                  },
                  child: const Text('To Read'),
                ),
                ElevatedButton(
                  onPressed: () {
                    // Handle reading
                  },
                  // style: ElevatedButton.styleFrom(primary: Colors.blue),
                  child: const Text('Reading'),
                ),
                ElevatedButton(
                  onPressed: () {
                    // Handle finish reading
                  },
                  // style: ElevatedButton.styleFrom(primary: Colors.blue),
                  child: const Text('Finish Reading'),
                ),
              ],
            ),

            // Review input field
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 8.0, vertical: 16.0),
              child: TextField(
                controller: _reviewController,
                style: const TextStyle(
                    color: Colors
                        .white), // This sets the text the user inputs to white
                decoration: InputDecoration(
                  hintText: 'Submit your review:',
                  hintStyle: const TextStyle(
                      color: Colors.white54), // Light white for the hint text
                  border: const OutlineInputBorder(),
                  enabledBorder: const OutlineInputBorder(
                    // To change the border color when TextField is enabled
                    borderSide: BorderSide(color: Colors.white),
                  ),
                  focusedBorder: const OutlineInputBorder(
                    // To change the border color when TextField is focused
                    borderSide: BorderSide(color: Colors.white),
                  ),
                  suffixIcon: IconButton(
                    icon: const Icon(
                      Icons.send,
                      color: Colors.white,
                    ), // Icon color set to white
                    onPressed: _submitReview,
                  ),
                ),
              ),
            ),
// Submit button
            ElevatedButton(
              onPressed: _submitReview,
              // style: ElevatedButton.styleFrom(
              //   primary: Colors.blue, // Button background color
              // ),
              child: const Text(
                'Submit',
                style: TextStyle(color: Colors.white),
              ), // Submit text color set to white
            ),

            // Reviews header
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 8.0),
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
            ..._reviews
                .map((review) => Container(
                      margin: const EdgeInsets.only(
                          bottom: 8.0), // Gap between comments
                      decoration: BoxDecoration(
                        border: Border.all(
                            color: Colors.white), // White comment border
                        borderRadius: BorderRadius.circular(
                            5.0), // Rounded corners of the border
                        color: const Color(
                            0xFF04364A), // Background color of the container set to #04364A
                      ),
                      child: ListTile(
                        title: Text(
                          '${review["username"]} (${DateTime.parse(review["timestamp"]).toLocal().toString()})',
                          style: const TextStyle(
                            color: Colors.white,
                          ), // Set text color to white
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Rating: ${review["rating"]}',
                              style: const TextStyle(
                                color: Colors.white,
                              ), // Set text color to white
                            ),
                            Text(
                              review["review"],
                              style: const TextStyle(
                                color: Colors.white,
                              ), // Set text color to white
                            ),
                          ],
                        ),
                      ),
                    ))
                .toList(),
          ],
        ),
      ),
      backgroundColor: const Color(0xFF04364A), // Changed background color
    );
  }
}
