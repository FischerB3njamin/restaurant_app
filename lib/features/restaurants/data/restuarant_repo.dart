import 'package:restaurant_app/features/restaurants/model/restaurant.dart';

abstract class RestuarantRepo {
  Future<void> addRestaurant(Restaurant restaurant);
  Future<void> deleteRestaurant(String docID);
  Future<void> updateRestaurant(Restaurant restaurant);
  Stream<List<Restaurant>> getRestaurants();
  Future<List<Restaurant>> filterByRating(int rating);
  Future<List<Restaurant>> filterByPostalcode(String postalcode);
  Future<List<Restaurant>> filterByPostalcodeAndRating(
      String postalcode, int rating);
}
