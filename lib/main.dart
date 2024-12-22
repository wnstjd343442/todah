import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:todah/app.dart';
import 'config/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}
