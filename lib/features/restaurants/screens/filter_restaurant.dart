import 'package:flutter/material.dart';
import 'package:restaurant_app/features/restaurants/data/restuarant_repo.dart';
import 'package:restaurant_app/features/restaurants/model/restaurant.dart';
import 'package:restaurant_app/features/restaurants/widgets/restaurant_tile.dart';

class FilterRestaurantScreen extends StatefulWidget {
  final RestuarantRepo repo;

  const FilterRestaurantScreen({
    super.key,
    required this.repo,
  });

  @override
  State<FilterRestaurantScreen> createState() => _FilterRestaurantScreenState();
}

class _FilterRestaurantScreenState extends State<FilterRestaurantScreen> {
  int? rating;
  String? errorText;
  bool isLoading = false;
  List<Restaurant> restaurants = [];
  final _formKey = GlobalKey<FormState>();
  TextEditingController plzController = TextEditingController();

  void filter() async {
    if (!_formKey.currentState!.validate()) return;

    String postalCode = plzController.text;
    errorText = "Füge Filter ein"; // Default error message

    if (rating != null && postalCode.isNotEmpty) {
      restaurants =
          await widget.repo.filterByPostalcodeAndRating(postalCode, rating!);
    } else if (rating != null) {
      restaurants = await widget.repo.filterByRating(rating!);
    } else if (postalCode.isNotEmpty) {
      restaurants = await widget.repo.filterByPostalcode(postalCode);
    } else {
      return;
    }

    errorText = '';
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Filter Restaurants"),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                DropdownMenu(
                  label: Text(
                    'Rating:',
                    style: TextTheme.of(context).headlineSmall,
                    textAlign: TextAlign.start,
                  ),
                  width: double.infinity,
                  onSelected: (value) => setState(() => rating = value),
                  dropdownMenuEntries: [
                    for (final item in List.generate(6, (i) => i))
                      DropdownMenuEntry(
                        label: "${item == 0 ? "" : item}",
                        value: item == 0 ? null : item,
                      ),
                  ],
                ),
                SizedBox(height: 16),
                Form(
                  key: _formKey,
                  child: TextFormField(
                    controller: plzController,
                    decoration: InputDecoration(hintText: "Postleitzahl"),
                    validator: (value) {
                      if (value != null && value.isNotEmpty) {
                        if (int.tryParse(value) == null || value.length != 5) {
                          return "Gib eine gültige Postleitzahl ein.";
                        }
                      }
                      return null;
                    },
                  ),
                ),
                if (errorText != null)
                  Text(
                    errorText!,
                    style: TextTheme.of(context).bodyLarge!.copyWith(
                        color: Colors.red, fontWeight: FontWeight.bold),
                  ),
                ElevatedButton(
                  onPressed: filter,
                  child: Text('Filter'),
                ),
                restaurants.isEmpty
                    ? Padding(
                        padding: const EdgeInsets.symmetric(vertical: 16.0),
                        child: Text(
                          "Keine Restaurants gefunden! Ändere deine Filter",
                          textAlign: TextAlign.center,
                          style: TextTheme.of(context)
                              .headlineSmall!
                              .copyWith(fontWeight: FontWeight.w500),
                        ),
                      )
                    : ListView.separated(
                        shrinkWrap: true,
                        itemBuilder: (context, index) => RestaurantTile(
                            restaurant: restaurants[index], repo: widget.repo),
                        separatorBuilder: (context, index) =>
                            SizedBox(height: 8),
                        itemCount: restaurants.length)
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    plzController.dispose();
    super.dispose();
  }
}
