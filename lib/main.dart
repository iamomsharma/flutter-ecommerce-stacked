import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'app/app.dart';
import 'app/app.locator.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();

  await Hive.initFlutter();

  await Hive.openBox("wishlist");
  await Hive.openBox("cart");
  await Hive.openBox("products");

  setupLocator();

  runApp(const MyApp());
}
