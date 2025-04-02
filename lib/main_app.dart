import 'package:flutter/material.dart';
import 'package:restaurant_app/features/restaurants/data/restuarant_repo.dart';
import 'package:restaurant_app/features/restaurants/screens/restaurant_list_view.dart';

class MainApp extends StatelessWidget {
  final RestuarantRepo repo;
  const MainApp({
    super.key,
    required this.repo,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: RestaurantListView(repo: repo),
    );
  }
}
