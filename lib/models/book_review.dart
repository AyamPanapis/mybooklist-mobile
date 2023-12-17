class BookReview {
  int bookId;
  String username;
  DateTime? pubDate;
  int rating;
  String comment;

  BookReview({
    this.pubDate,
    required this.bookId,
    required this.username,
    required this.rating,
    required this.comment,
  });

  factory BookReview.fromJson(Map<String, dynamic> json) => BookReview(
        bookId: json['fields']['book'],
        username: json['fields']['user_name'],
        pubDate: DateTime.parse(json['fields']['pub_date']),
        rating: json['fields']['rating'],
        comment: json['fields']['comment'],
      );
}
