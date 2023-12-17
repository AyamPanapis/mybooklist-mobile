import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:mybooklistmobile/models/book_review.dart';
import 'package:mybooklistmobile/models/books.dart';
import 'package:mybooklistmobile/repository/book_reviews_repository.dart';
import 'package:mybooklistmobile/widgets/left_drawer.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';
import 'dart:convert';

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
  final int _toread = 0;
  final int _reading = 1;
  final int _finished = 2;
  double ratingStar = 0.0;

  double getAverageRating(List<BookReview> reviewList) {
    if (reviewList.isEmpty) {
      return 0;
    }

    List<int> ratings = reviewList.map((e) => e.rating).toList();

    double ratingTotal = 0.0;

    for (var rating in ratings) {
      ratingTotal += rating;
    }

    return ratingTotal / ratings.length.toDouble();
  }

  @override
  void initState() {
    super.initState();
  }

  void resetRating() {
    _reviewController.clear();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) {
          return BookDetailPage(book: widget.book);
        },
      ),
    );
  }

  void _submitReview() {
    if (_reviewController.text.isNotEmpty && ratingStar.toInt() > 0) {
      BookReviewsRepository.createReview(
              BookReview(
                  bookId: widget.book.pk,
                  username: "sss", // username user
                  rating: ratingStar.toInt(),
                  comment: _reviewController.text),
              context)
          .then((value) => resetRating());
    } else {
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(const SnackBar(
            content: Text("You haven't added a rating or comment yet!")));
    }
  }

  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();
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
                  FutureBuilder(
                    future: BookReviewsRepository.getBookReview(widget.book.pk),
                    builder: ((context, snapshot) {
                      if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                        List<BookReview> bookReviews = snapshot.data!;

                        double averageReview = getAverageRating(bookReviews);
                        return Text(
                          "Rating: ${averageReview.toStringAsFixed(2)}",
                          textAlign: TextAlign.center,
                          style: const TextStyle(fontSize: 20.0),
                        );
                      } else if (snapshot.hasError) {
                        return Text(snapshot.error.toString());
                      } else if (snapshot.connectionState ==
                          ConnectionState.waiting) {
                        return const CircularProgressIndicator();
                      } else if (snapshot.hasData && snapshot.data!.isEmpty) {
                        return const Text(
                          'Rating: n/a',
                          style: TextStyle(fontSize: 20.0),
                        );
                      } else {
                        return const CircularProgressIndicator();
                      }
                    }),
                  )
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
                  onPressed: () async {
                    final response = await request.postJson(
                        'http://192.168.1.6:8000/book/wishlist/${widget.book.pk}/',
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
                        'http://192.168.1.22:8000/book/wishlist/${widget.book.pk}/',
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
                        'http://192.168.1.22:8000/book/wishlist/${widget.book.pk}/',
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

            // Review input field
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 8.0, vertical: 16.0),
              child: Column(
                children: [
                  RatingBar.builder(
                    initialRating: ratingStar,
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
                      ratingStar = rating;
                    },
                  ),
                  const SizedBox(
                    height: 16.0,
                  ),
                  TextField(
                    controller: _reviewController,
                    style: const TextStyle(
                        color: Colors
                            .white), // This sets the text the user inputs to white
                    decoration: InputDecoration(
                      hintText: 'Submit your review:',
                      hintStyle: const TextStyle(
                          color:
                              Colors.white54), // Light white for the hint text
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
                ],
              ),
            ),
// Submit button
            // ElevatedButton(
            //   onPressed: _submitReview,
            //   // style: ElevatedButton.styleFrom(
            //   //   primary: Colors.blue, // Button background color
            //   // ),
            //   child: const Text(
            //     'Submit',
            //   ), // Submit text color set to white
            // ),

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
            FutureBuilder(
                future: BookReviewsRepository.getBookReview(widget.book.pk),
                builder: ((context, snapshot) {
                  if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                    List<BookReview> bookReviews = snapshot.data!;

                    return ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: bookReviews.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding:
                                const EdgeInsets.fromLTRB(20.0, 0, 20.0, 20.0),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Icon(
                                  Icons.person,
                                  color: Colors.white,
                                ),
                                const SizedBox(
                                  width: 10.0,
                                ),
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width / 1.3,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        bookReviews[index].username,
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white,
                                            fontSize: 19.0),
                                      ),
                                      const SizedBox(
                                        height: 10.0,
                                      ),
                                      RatingBar.builder(
                                        initialRating: bookReviews[index]
                                            .rating
                                            .toDouble(),
                                        itemSize: 20.0,
                                        minRating: 1,
                                        direction: Axis.horizontal,
                                        allowHalfRating: false,
                                        ignoreGestures: true,
                                        itemCount: 5,
                                        itemPadding: const EdgeInsets.symmetric(
                                            horizontal: 4.0),
                                        itemBuilder: (context, _) => const Icon(
                                          Icons.star,
                                          color: Colors.amber,
                                        ),
                                        onRatingUpdate: (rating) {
                                          ratingStar = rating;
                                        },
                                      ),
                                      const SizedBox(
                                        height: 10.0,
                                      ),
                                      Text(
                                        bookReviews[index].comment,
                                        style: const TextStyle(
                                            color: Colors.white,
                                            fontStyle: FontStyle.italic,
                                            fontSize: 15.0),
                                      ),
                                      const SizedBox(
                                        height: 20.0,
                                      ),
                                      const Divider(),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          );
                        });
                  } else if (snapshot.hasError) {
                    return Text(snapshot.error.toString());
                  } else if (snapshot.connectionState ==
                      ConnectionState.waiting) {
                    return const CircularProgressIndicator();
                  } else if (snapshot.hasData && snapshot.data!.isEmpty) {
                    return const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        'Belum ada review',
                        style: TextStyle(color: Colors.white),
                      ),
                    );
                  } else {
                    return const CircularProgressIndicator();
                  }
                }))
          ],
        ),
      ),
      backgroundColor: const Color(0xFF04364A), // Changed background color
    );
  }
}
