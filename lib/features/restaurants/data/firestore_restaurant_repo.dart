import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:restaurant_app/features/restaurants/data/restuarant_repo.dart';
import 'package:restaurant_app/features/restaurants/model/restaurant.dart';

class FirestoreRestaurantRepo implements RestuarantRepo {
  final FirebaseFirestore _db;

  FirestoreRestaurantRepo(this._db);

  @override
  Future<void> addRestaurant(Restaurant restaurant) async {
    await _db.collection("restaurants").add(restaurant.toMap(restaurant));
  }

  @override
  Future<void> deleteRestaurant(String docID) async {
    await _db.collection("restaurants").doc(docID).delete();
  }

  @override
  Stream<List<Restaurant>> getRestaurants() =>
      _db.collection("restaurants").snapshots().map((snapshot) => snapshot.docs
          .map((doc) => Restaurant.fromMap(doc.data(), doc.id))
          .toList());

  @override
  Future<void> updateRestaurant(Restaurant restaurant) async {
    await _db
        .collection("restaurants")
        .doc(restaurant.id)
        .update(restaurant.toMap(restaurant));
  }

  @override
  Future<List<Restaurant>> filterByPostalcode(String postalcode) async {
    return await _db
        .collection("restaurants")
        .where('plz', isEqualTo: postalcode)
        .get()
        .then(
          (e) => e.docs
              .map((doc) => Restaurant.fromMap(doc.data(), doc.id))
              .toList(),
        );
  }

  @override
  Future<List<Restaurant>> filterByRating(int rating) async {
    return await _db
        .collection("restaurants")
        .where('rating', isEqualTo: rating)
        .get()
        .then(
          (e) => e.docs
              .map((doc) => Restaurant.fromMap(doc.data(), doc.id))
              .toList(),
        );
  }

  @override
  Future<List<Restaurant>> filterByPostalcodeAndRating(
      String postalcode, int rating) async {
    return await _db
        .collection("restaurants")
        .where('rating', isEqualTo: rating)
        .where('plz', isEqualTo: postalcode)
        .get()
        .then(
          (e) => e.docs
              .map((doc) => Restaurant.fromMap(doc.data(), doc.id))
              .toList(),
        );
  }
}
