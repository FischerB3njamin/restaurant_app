class Restaurant {
  String title;
  String plz;
  int rating;
  String id;

  Restaurant({
    required this.plz,
    required this.title,
    required this.id,
    required this.rating,
  });

  factory Restaurant.fromMap(Map<String, dynamic> map, String docId) =>
      Restaurant(
          plz: map["plz"],
          title: map["title"],
          rating: map["rating"],
          id: docId);

  Map<String, dynamic> toMap(Restaurant restaurant) => {
        'title': title,
        'plz': plz,
        'rating': rating,
      };
}
