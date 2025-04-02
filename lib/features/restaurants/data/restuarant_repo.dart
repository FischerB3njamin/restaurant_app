import 'package:restaurant_app/features/restaurants/model/restaurant.dart';

abstract class RestuarantRepo {
  Future<void> addRestaurant(Restaurant restaurant);
  Future<void> deleteRestaurant(String docID);
  Future<void> updateRestaurant(Restaurant restaurant);
  Future<List<Restaurant>> getRestaurants();
  Stream<List<Restaurant>> getRestaurantsStream();
  Future<List<Restaurant>> filterByRating(int rating);
  Future<List<Restaurant>> filterByPostalcode(String postalcode);
  Future<List<Restaurant>> filterByPostalcodeAndRating(
      String postalcode, int rating);
}
