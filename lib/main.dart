import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:plants_mobile/views/plant_list_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: "AIzaSyBrqgs-dPhaqb2CrqyqL4DVwNgP8Jh9z_c",
      authDomain: "plants-d9c7e.firebaseapp.com",
      projectId: "plants-d9c7e",
      storageBucket: "plants-d9c7e.appspot.com",
      messagingSenderId: "608604396574",
      appId: "1:608604396574:web:7bc1d4ffaf675168c7e20f",
      measurementId: "G-SH6VS5BQ9Y",
    ),
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Catálogo de Plantas',
      theme: ThemeData(
        primaryColor: const Color(0xFF31511E),
        scaffoldBackgroundColor: const Color(0xFFF6FCDF),
        appBarTheme: const AppBarTheme(color: Color(0xFF31511E)),
      ),
      home: PlantListScreen(),
    );
  }
}