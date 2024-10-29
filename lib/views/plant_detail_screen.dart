import 'package:flutter/material.dart';
import 'package:plants_mobile/models/plant.dart';

class PlantDetailScreen extends StatelessWidget {
  final Plant plant;

  PlantDetailScreen({required this.plant});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF6FCDF), // Fundo suave para a tela
      appBar: AppBar(
        title: Text(plant.name, style: TextStyle(color: Color(0xFF1A1A19))),
        backgroundColor: Color(0xFFF6FCDF),
        elevation: 0,
        iconTheme: IconThemeData(color: Color(0xFF31511E)),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              plant.name,
              style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF31511E)),
            ),
            SizedBox(height: 12),
            Text(
              plant.description,
              style: TextStyle(fontSize: 16, color: Color(0xFF859F3D)),
            ),
            SizedBox(height: 20),
            Text(
              "Cuidados:",
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF31511E)),
            ),
            SizedBox(height: 8),
            Text(
              plant.careInstructions,
              style: TextStyle(fontSize: 16, color: Color(0xFF1A1A19)),
            ),
          ],
        ),
      ),
    );
  }
}
