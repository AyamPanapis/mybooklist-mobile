import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:mybooklistmobile/models/books.dart';
import 'package:mybooklistmobile/widgets/left_drawer.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:mybooklistmobile/models/reviewbook.dart';

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
  List<int> list = <int>[1, 2, 3, 4, 5];
  int? selectedValue;
  final TextEditingController _reviewController = TextEditingController();
  final List<Map<String, dynamic>> _reviews = [];
  final _formKey = GlobalKey<FormState>();
  final int _toread = 0;
  final int _reading = 1;
  final int _finished = 2;
  String _comment = '';
  double _rating = 0.0;

  Future<List<Review>> fetchReviews(BuildContext context) async {
    var url = Uri.parse(
        'https://mybooklist-k1-tk.pbp.cs.ui.ac.id/book/show-review-json/${widget.book.pk}/');
    var response = await http.get(
      url,
      headers: {"Content-Type": "application/json"},
    );
    var data = jsonDecode(utf8.decode(response.bodyBytes));
    List<Review> listProduct = [];
    for (var d in data) {
      if (d != null) {
        listProduct.add(Review.fromJson(d));
      }
    }
    return listProduct;
  }

  Future<String> _getUserName(BuildContext context) async {
    var response = await context.read<CookieRequest>().get(
          'https://mybooklist-k1-tk.pbp.cs.ui.ac.id/auth/user_data/',
        );
    String uname = response['username'];
    return uname;
  }

  double calculateAverageRating(List<Review> reviews) {
    if (reviews.isEmpty) {
      return 0; // Return 0 if there are no reviews to avoid division by zero
    }

    double totalRating = 0.0;
    for (var review in reviews) {
      totalRating += review.fields.rating.toDouble();
    }

    double averageRating = totalRating / reviews.length;

    return double.parse(averageRating.toStringAsFixed(2));
  }

  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();
    return Scaffold(
      backgroundColor: const Color(0xFF04364A), // Changed background color
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
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 20.0,
                    ),
                  ),
                  Text(
                    "Publisher: ${widget.book.fields.publisher}",
                    textAlign: TextAlign.center,
                    style: const TextStyle(color: Colors.white, fontSize: 20.0),
                  ),
                  Text(
                    "Category: ${widget.book.fields.categories.toString().split(".").last}",
                    textAlign: TextAlign.center,
                    style: const TextStyle(color: Colors.white, fontSize: 20.0),
                  ),
                ],
              ),
              titleTextStyle: const TextStyle(
                color: Colors.white,
              ),
              subtitleTextStyle: const TextStyle(color: Colors.white),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: FutureBuilder<List<Review>>(
                future: fetchReviews(context),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator();
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else {
                    List<Review> reviews = snapshot.data ?? [];
                    return Text(
                      '⭐ ${calculateAverageRating(reviews)} (${reviews.length} reviews)',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    );
                  }
                },
              ),
            ),
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
                  onPressed: () async {
                    final response = await request.postJson(
                        'https://mybooklist-k1-tk.pbp.cs.ui.ac.id/book/wishlist/${widget.book.pk}/',
                        jsonEncode(<String, String>{
                          'num': _toread.toString(),
                        }));
                    if (response['status'] == 'success') {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text(
                            "Your book has been added to your to read wishlist!"),
                      ));
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content:
                            Text("Something went wrong, please try again."),
                      ));
                    }
                  },
                  child: const Text('To Read'),
                ),
                ElevatedButton(
                  onPressed: () async {
                    final response = await request.postJson(
                        'https://mybooklist-k1-tk.pbp.cs.ui.ac.id/book/wishlist/${widget.book.pk}/',
                        jsonEncode(<String, String>{
                          'num': _reading.toString(),
                        }));
                    if (response['status'] == 'success') {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text(
                            "Your book has been added to your reading wishlist!"),
                      ));
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content:
                            Text("Something went wrong, please try again."),
                      ));
                    }
                  },
                  // style: ElevatedButton.styleFrom(primary: Colors.blue),
                  child: const Text('Reading'),
                ),
                ElevatedButton(
                  onPressed: () async {
                    final response = await request.postJson(
                        'https://mybooklist-k1-tk.pbp.cs.ui.ac.id/book/wishlist/${widget.book.pk}/',
                        jsonEncode(<String, String>{
                          'num': _finished.toString(),
                        }));
                    if (response['status'] == 'success') {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text(
                            "Your book has been added to your finished wishlist!"),
                      ));
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content:
                            Text("Something went wrong, please try again."),
                      ));
                    }
                  },
                  // style: ElevatedButton.styleFrom(primary: Colors.blue),
                  child: const Text('Finish Reading'),
                ),
              ],
            ),
            const SizedBox(
              height: 16.0,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "Rate this book!",
                textAlign: TextAlign.justify,
                style: const TextStyle(color: Colors.white, fontSize: 20),
              ),
            ),
            Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  // Wrapped DropdownButton in Container with a fixed width
                  RatingBar.builder(
                    initialRating: _rating,
                    tapOnlyMode: true,
                    minRating: 1,
                    direction: Axis.horizontal,
                    allowHalfRating: false,
                    itemCount: 5,
                    itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
                    itemBuilder: (context, _) => const Icon(
                      Icons.star,
                      color: Colors.amber,
                    ),
                    onRatingUpdate: (rating) {
                      _rating = rating;
                    },
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  // Expanded TextField to take remaining space
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 8.0, vertical: 16.0),
                    child: TextField(
                      controller: _reviewController,
                      style: const TextStyle(color: Colors.white),
                      onChanged: (String? value) {
                        setState(() {
                          _comment = value!;
                        });
                      },
                      decoration: InputDecoration(
                        hintText: 'Submit your review:',
                        hintStyle: const TextStyle(color: Colors.white54),
                        border: const OutlineInputBorder(),
                        enabledBorder: const OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                        ),
                        focusedBorder: const OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                        ),
                        suffixIcon: IconButton(
                          icon: const Icon(
                            Icons.send,
                            color: Colors.white,
                          ),
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              final uname = await _getUserName(context);
                              final response = await request.postJson(
                                'https://mybooklist-k1-tk.pbp.cs.ui.ac.id/book/add-book-review/${widget.book.pk}/',
                                jsonEncode(<String, dynamic>{
                                  'name': uname,
                                  'comment': _comment,
                                  'rating': _rating,
                                }),
                              );
                              if (response['status'] == 'success') {
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(const SnackBar(
                                  content: Text("Your review has been added!"),
                                ));
                                List<Review> updatedReviews =
                                    await fetchReviews(context);

                                // Update the state with the new reviews
                                setState(() {
                                  _reviews.clear();
                                  _reviews.addAll(updatedReviews
                                      .map((review) => review.toJson()));
                                  _reviewController.clear();
                                  _rating = 0.0;
                                });
                              } else {
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(const SnackBar(
                                  content: Text(
                                      "Something went wrong, please try again."),
                                ));
                              }
                            }
                          },
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

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
            FutureBuilder<List<Review>>(
              future: fetchReviews(context),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator(); // Loading indicator
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else {
                  List<Review> reviews = snapshot.data ?? [];
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      for (var review in reviews)
                        Container(
                          margin: const EdgeInsets.only(bottom: 8.0),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.white),
                            borderRadius: BorderRadius.circular(5.0),
                            color: const Color(0xFF04364A),
                          ),
                          child: ListTile(
                            title: Row(
                              children: [
                                Text(
                                  review.fields.userName,
                                  style: const TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                                RatingBar.builder(
                                  initialRating:
                                      review.fields.rating.toDouble(),
                                  itemSize: 16,
                                  minRating: 1,
                                  direction: Axis.horizontal,
                                  allowHalfRating: false,
                                  ignoreGestures: true,
                                  itemCount: 5,
                                  itemPadding:
                                      const EdgeInsets.symmetric(horizontal: 2),
                                  itemBuilder: (context, _) => const Icon(
                                    Icons.star,
                                    color: Colors.amber,
                                  ),
                                  onRatingUpdate: (rating) {
                                    _rating = rating;
                                  },
                                ),
                              ],
                            ),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  review.fields.comment,
                                  style: const TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                    ],
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
