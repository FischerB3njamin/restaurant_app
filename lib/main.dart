import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:restaurant_app/features/restaurants/data/firestore_restaurant_repo.dart';
import 'package:restaurant_app/features/restaurants/data/restuarant_repo.dart';
import 'package:restaurant_app/firebase_options.dart';
import 'package:restaurant_app/main_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  FirebaseFirestore firebase = FirebaseFirestore.instance;

  RestuarantRepo repo = FirestoreRestaurantRepo(firebase);

  runApp(MainApp(repo: repo));
}
