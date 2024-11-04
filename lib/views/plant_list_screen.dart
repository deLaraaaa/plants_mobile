import 'package:flutter/material.dart';
import 'package:plants_mobile/models/plant.dart';
import 'package:plants_mobile/services/plant_service.dart';
import 'package:plants_mobile/views/plant_form_screen.dart';
import 'package:plants_mobile/views/plant_detail_screen.dart';
import 'package:plants_mobile/components/toast.dart';

class PlantListScreen extends StatelessWidget {
  final PlantService _plantService = PlantService();

  PlantListScreen({super.key});

  void _showDeleteConfirmationDialog(BuildContext context, Plant plant) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: const Color(0xFF31511E), // Dark green background
          title: const Text('Confirmar Exclusão',
              style: TextStyle(color: Colors.white)),
          content: const Text('Tem certeza de que deseja excluir esta planta?',
              style: TextStyle(color: Colors.white)),
          actions: <Widget>[
            TextButton(
              style: TextButton.styleFrom(
                backgroundColor:
                    const Color(0xFF859F3D), // Light green background
              ),
              child: const Text('Cancelar',
                  style: TextStyle(color: Colors.white)), // White text
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              style: TextButton.styleFrom(
                backgroundColor: Colors.red, // Red background
              ),
              child: const Text('Excluir',
                  style: TextStyle(color: Colors.white)), // White text
              onPressed: () {
                Navigator.of(context).pop();
                _plantService.deletePlant(plant.id!).then((_) {
                  Toast.showSuccess("Planta excluída com sucesso!",
                      backgroundColor: Colors.red);
                }).catchError((e) {
                  Toast.showError("Erro ao excluir a planta: $e");
                });
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1A1A19), // Light background color
      appBar: AppBar(
        title: const Text(
          "Catálogo de Plantas",
          style: TextStyle(color: Color(0xFF859F3D)), // Dark color for title
        ),
        backgroundColor:
            const Color(0xFF1A1A19), // Light background color for the header
        elevation: 0,
        iconTheme: const IconThemeData(color: Color(0xFF31511E)),
      ),
      body: StreamBuilder<List<Plant>>(
        stream: _plantService.getPlants(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          final plants = snapshot.data ?? [];
          return ListView.builder(
            padding:
                const EdgeInsets.all(16), // Add padding for a cleaner layout
            itemCount: plants.length,
            itemBuilder: (context, index) {
              final plant = plants[index];
              return Card(
                margin: const EdgeInsets.symmetric(
                    vertical: 8), // Add spacing between cards
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(
                      15), // Rounded edges for a modern look
                ),
                color: const Color(0xFFFFFFFF), // White background for the card
                elevation: 3, // Soft shadow effect
                child: ListTile(
                  contentPadding:
                      const EdgeInsets.all(16), // Add padding inside the card
                  title: Text(
                    plant.name,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: Color(0xFF31511E), // Dark green color for titles
                    ),
                  ),
                  subtitle: Text(
                    plant.description,
                    style: const TextStyle(
                        color:
                            Color(0xFF859F3D)), // Lighter green for description
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.edit, color: Color(0xFF31511E)),
                        onPressed: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => PlantFormScreen(plant: plant),
                          ),
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete, color: Colors.red),
                        onPressed: () =>
                            _showDeleteConfirmationDialog(context, plant),
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
          MaterialPageRoute(builder: (context) => const PlantFormScreen()),
        ),
        elevation: 6, // Elevation to add shadow and depth
        backgroundColor: const Color(0xFF31511E), // Dark green color for FAB
        child: const Icon(Icons.add,
            color: Color(0xFF1A1A19)), // Contrast color for FAB icon
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation
          .endFloat, // Align FAB to the bottom right
    );
  }
}
