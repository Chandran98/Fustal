import 'package:cloud_firestore/cloud_firestore.dart';

class Products {
  String? category;
  String? categorytype;
  String? title;
  String? description;
  String? thumbnailImagelUrl;
  int? loves;
  String? sourceUrl;
  String? date;
  String? timestamp;
  int? views;

  Products(
      {this.category,
      this.categorytype,
      this.date,
      this.description,
      this.loves,
      this.sourceUrl,
      this.thumbnailImagelUrl,
      this.timestamp,
      this.title,
      this.views});

  factory Products.fromFirestore(DocumentSnapshot snapshot) {
    Map d = snapshot.data() as Map<dynamic, dynamic>;
    return Products(
      category: d['category'],
      categorytype: d['categorytype'],
      title: d['title'],
      description: d['description'],
      thumbnailImagelUrl: d['image url'],
      loves: d['loves'],
      sourceUrl: d['source'],
      date: d['date'],
      timestamp: d['timestamp'],
      views: d['views'] ?? null,
    );
  }
}
