import 'package:flutter/material.dart';
import 'package:plants_mobile/models/plant.dart';
import 'package:plants_mobile/services/plant_service.dart';
import 'package:plants_mobile/views/plant_form_screen.dart';
import 'package:plants_mobile/views/plant_list_screen.dart';
import 'package:plants_mobile/components/toast.dart';

class PlantDetailScreen extends StatelessWidget {
  final Plant plant;
  final PlantService _plantService = PlantService();

  PlantDetailScreen({super.key, required this.plant});

  Future<void> _deletePlant(BuildContext context) async {
    try {
      await _plantService.deletePlant(plant.id!);
      Toast.showSuccess("Planta excluída com sucesso!",
          backgroundColor: Colors.red);
      if (context.mounted) {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => PlantListScreen()),
          (Route<dynamic> route) => false,
        );
      }
    } catch (e) {
      Toast.showError("Erro ao excluir a planta: $e");
    }
  }

  void _showDeleteConfirmationDialog(BuildContext context) {
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
                _deletePlant(context);
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
      backgroundColor: const Color(0xFFF6FCDF), // Fundo suave para a tela
      appBar: AppBar(
        title:
            Text(plant.name, style: const TextStyle(color: Color(0xFF1A1A19))),
        backgroundColor: const Color(0xFFF6FCDF),
        elevation: 0,
        iconTheme: const IconThemeData(color: Color(0xFF31511E)),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit, color: Color(0xFF31511E)),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => PlantFormScreen(plant: plant),
                ),
              );
            },
          ),
          Padding(
            padding: const EdgeInsets.only(
                right: 30.0), // Move button to the left by 30 pixels
            child: IconButton(
              icon: const Icon(Icons.delete, color: Colors.red),
              onPressed: () => _showDeleteConfirmationDialog(context),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              plant.name,
              style: const TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF31511E)),
            ),
            const SizedBox(height: 12),
            Text(
              plant.description,
              style: const TextStyle(fontSize: 16, color: Color(0xFF859F3D)),
            ),
            const SizedBox(height: 20),
            const Text(
              "Cuidados:",
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF31511E)),
            ),
            const SizedBox(height: 8),
            Text(
              plant.careInstructions,
              style: const TextStyle(fontSize: 16, color: Color(0xFF1A1A19)),
            ),
          ],
        ),
      ),
    );
  }
}
