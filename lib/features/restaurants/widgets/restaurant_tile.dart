import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:restaurant_app/features/restaurants/data/restuarant_repo.dart';
import 'package:restaurant_app/features/restaurants/model/restaurant.dart';
import 'package:restaurant_app/features/restaurants/screens/new_restaurant.dart';

class RestaurantTile extends StatefulWidget {
  const RestaurantTile({
    super.key,
    required this.restaurant,
    required this.repo,
  });

  final Restaurant restaurant;
  final RestuarantRepo repo;

  @override
  State<RestaurantTile> createState() => _RestaurantTileState();
}

class _RestaurantTileState extends State<RestaurantTile>
    with SingleTickerProviderStateMixin {
  late final controller = SlidableController(this);
  void doNothing(BuildContext context) {}

  @override
  Widget build(BuildContext context) {
    return Slidable(
      endActionPane: ActionPane(
        motion: const ScrollMotion(),
        children: [
          SlidableAction(
            onPressed: (context) async =>
                await widget.repo.deleteRestaurant(widget.restaurant.id),
            backgroundColor: const Color(0xFFFE4A49),
            foregroundColor: Colors.white,
            icon: Icons.delete,
          ),
          SlidableAction(
            onPressed: (_) => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => NewRestaurantScreen(
                    repo: widget.repo, restaurant: widget.restaurant),
              ),
            ),
            backgroundColor: const Color(0xFF0392CF),
            foregroundColor: Colors.white,
            icon: Icons.edit,
          ),
        ],
      ),
      child: ListTile(
        contentPadding: EdgeInsets.only(right: 16),
        title: Text(
          widget.restaurant.title,
          style: TextTheme.of(context)
              .headlineSmall!
              .copyWith(fontWeight: FontWeight.w500),
        ),
        subtitle: Text(widget.restaurant.plz),
        trailing: Text(widget.restaurant.rating.toString(),
            style: TextTheme.of(context)
                .headlineSmall!
                .copyWith(fontWeight: FontWeight.w500)),
      ),
    );
  }
}
