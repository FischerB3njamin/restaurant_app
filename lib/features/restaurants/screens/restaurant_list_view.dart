import 'package:flutter/material.dart';
import 'package:restaurant_app/features/restaurants/data/restuarant_repo.dart';
import 'package:restaurant_app/features/restaurants/screens/filter_restaurant.dart';
import 'package:restaurant_app/features/restaurants/screens/new_restaurant.dart';
import 'package:restaurant_app/features/restaurants/widgets/restaurant_tile.dart';

class RestaurantListView extends StatefulWidget {
  final RestuarantRepo repo;

  const RestaurantListView({super.key, required this.repo});

  @override
  State<RestaurantListView> createState() => _RestaurantListViewState();
}

class _RestaurantListViewState extends State<RestaurantListView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => NewRestaurantScreen(
                repo: widget.repo,
                restaurant: null,
              ),
            ),
          );
        },
        child: CircleAvatar(
          child: Icon(Icons.add, size: 32),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Alle Restaurants',
                      style: TextTheme.of(context)
                          .headlineLarge!
                          .copyWith(fontWeight: FontWeight.bold),
                    ),
                    IconButton(
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => FilterRestaurantScreen(
                              repo: widget.repo,
                            ),
                          ),
                        );
                      },
                      icon: Icon(Icons.filter_alt_rounded, size: 32),
                    ),
                  ],
                ),
                Divider(),
                StreamBuilder(
                    stream: widget.repo.getRestaurants(),
                    builder: (constext, snapshot) {
                      if (snapshot.hasError) {
                        return Text("Fehler: ${snapshot.error}");
                      } else if (snapshot.connectionState ==
                              ConnectionState.active &&
                          !snapshot.hasData) {
                        return CircularProgressIndicator();
                      } else if (snapshot.hasData && snapshot.data != null) {
                        final restaurants = snapshot.data!;

                        return ListView.separated(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          separatorBuilder: (context, index) =>
                              SizedBox(height: 10),
                          itemCount: restaurants.length,
                          itemBuilder: (context, index) => RestaurantTile(
                            restaurant: restaurants[index],
                            repo: widget.repo,
                          ),
                        );
                      }
                      return Text("Keine Daten");
                    }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
