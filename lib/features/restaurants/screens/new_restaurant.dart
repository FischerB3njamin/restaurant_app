import 'package:flutter/material.dart';
import 'package:restaurant_app/features/restaurants/data/restuarant_repo.dart';
import 'package:restaurant_app/features/restaurants/model/restaurant.dart';

class NewRestaurantScreen extends StatefulWidget {
  final RestuarantRepo repo;
  final Restaurant? restaurant;

  const NewRestaurantScreen({
    super.key,
    required this.repo,
    required this.restaurant,
  });

  @override
  State<NewRestaurantScreen> createState() => _NewRestaurantScreenState();
}

class _NewRestaurantScreenState extends State<NewRestaurantScreen> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController titleController;
  late final TextEditingController ratingController;
  late final TextEditingController plzController;

  @override
  void initState() {
    if (widget.restaurant != null) {
      titleController = TextEditingController(text: widget.restaurant!.title);
      plzController = TextEditingController(text: widget.restaurant!.plz);
      ratingController =
          TextEditingController(text: widget.restaurant!.rating.toString());
    }

    super.initState();
  }

  void save() async {
    if (!_formKey.currentState!.validate()) return;

    final restaurant = Restaurant(
        plz: plzController.text,
        title: titleController.text,
        id: "",
        rating: int.parse(
          ratingController.text,
        ));
    if (widget.restaurant == null) {
      await widget.repo.addRestaurant(restaurant);
    } else {
      restaurant.id = widget.restaurant!.id;
      await widget.repo.updateRestaurant(restaurant);
    }

    if (mounted) {
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(' Neues Restaurant')),
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          spacing: 32,
          children: [
            Form(
              key: _formKey,
              child: Column(
                spacing: 16,
                children: [
                  TextFormField(
                    controller: titleController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Name des Restaurants darf nicht leer sein";
                      }
                      return null;
                    },
                    decoration: InputDecoration(hintText: "Name"),
                  ),
                  TextFormField(
                    controller: plzController,
                    validator: (value) {
                      if (value == null ||
                          int.tryParse(value) == null ||
                          value.length != 5) {
                        return "gib eine gültige Postleitzahl ein ";
                      }
                      return null;
                    },
                    decoration: InputDecoration(hintText: "Postleitzahl"),
                  ),
                  TextFormField(
                    controller: ratingController,
                    validator: (value) {
                      if (value == null ||
                          value.isEmpty ||
                          int.tryParse(value) == null ||
                          (int.tryParse(value)! < 1 ||
                              int.tryParse(value)! > 5)) {
                        return "Bewertung muss zwischen 1 und 5 sein";
                      }
                      return null;
                    },
                    decoration: InputDecoration(hintText: "Rating"),
                  ),
                ],
              ),
            ),
            Row(
              spacing: 32,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text('Abbrechen'),
                ),
                ElevatedButton(
                  onPressed: save,
                  child: Text("speichern"),
                ),
              ],
            )
          ],
        ),
      )),
    );
  }

  @override
  void dispose() {
    titleController.dispose();
    ratingController.dispose();
    plzController.dispose();
    super.dispose();
  }
}
