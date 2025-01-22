class Event {
  final String title;
  final String description;
  final DateTime dateTime;
  final String location;
  final String imgUrl;
  final String refundPolicy;
  final String price;
  final String status;
  final String category;

  Event({
    required this.title,
    required this.description,
    required this.dateTime,
    required this.location,
    required this.imgUrl,
    required this.refundPolicy,
    required this.price,
    required this.status,
    required this.category,
  });

  factory Event.fromJson(Map<String, dynamic> json) {
    return Event(
      title: json['title'],
      description: json['description'],
      dateTime: DateTime.parse(json['date_time']),
      location: json['location'],
      imgUrl: json['img_url'],
      refundPolicy: json['refund_policy'],
      price: json['price'],
      status: json['status'],
      category: json['category'],
    );
  }
}
