import 'package:flutter/material.dart';
import 'package:plants_mobile/models/plant.dart';
import 'package:plants_mobile/services/plant_service.dart';
import 'package:plants_mobile/views/plant_form_screen.dart';
import 'package:plants_mobile/views/plant_detail_screen.dart';

class PlantListScreen extends StatelessWidget {
  final PlantService _plantService = PlantService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF6FCDF), // Light background color
      appBar: AppBar(
        title: Text("Catálogo de Plantas"),
        backgroundColor: Color(0xFFF6FCDF), // Dark green color for the header
      ),
      body: StreamBuilder<List<Plant>>(
        stream: _plantService.getPlants(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          final plants = snapshot.data ?? [];
          return ListView.builder(
            padding: EdgeInsets.all(16), // Add padding for a cleaner layout
            itemCount: plants.length,
            itemBuilder: (context, index) {
              final plant = plants[index];
              return Card(
                margin: EdgeInsets.symmetric(
                    vertical: 8), // Add spacing between cards
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(
                      15), // Rounded edges for a modern look
                ),
                color: Color(0xFFFFFFFF), // White background for the card
                elevation: 3, // Soft shadow effect
                child: ListTile(
                  contentPadding:
                      EdgeInsets.all(16), // Add padding inside the card
                  title: Text(
                    plant.name,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: Color(0xFF31511E), // Dark green color for titles
                    ),
                  ),
                  subtitle: Text(
                    plant.description,
                    style: TextStyle(
                        color:
                            Color(0xFF859F3D)), // Lighter green for description
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: Icon(Icons.edit, color: Color(0xFF31511E)),
                        onPressed: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => PlantFormScreen(plant: plant),
                          ),
                        ),
                      ),
                      IconButton(
                        icon: Icon(Icons.delete, color: Colors.red),
                        onPressed: () => _plantService.deletePlant(plant.id!),
                      ),
                    ],
                  ),
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PlantDetailScreen(plant: plant),
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => PlantFormScreen()),
        ),
        backgroundColor: Color(0xFF31511E), // Dark green color for FAB
        child: Icon(Icons.add,
            color: Color(0xFFF6FCDF)), // Contrast color for FAB icon
        elevation: 6, // Elevation to add shadow and depth
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation
          .endFloat, // Align FAB to the bottom right
    );
  }
}
