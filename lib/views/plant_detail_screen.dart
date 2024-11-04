import 'package:flutter/material.dart';
import 'package:plants_mobile/models/plant.dart';
import 'package:plants_mobile/services/plant_service.dart';
import 'package:plants_mobile/views/plant_form_screen.dart';
import 'package:plants_mobile/views/plant_list_screen.dart';
import 'package:plants_mobile/components/toast.dart';

/// Tela de detalhes da planta.
class PlantDetailScreen extends StatelessWidget {
  final Plant plant;
  final PlantService _plantService = PlantService();

  PlantDetailScreen({super.key, required this.plant});

  /// Função para excluir uma planta.
  ///
  /// [context] é o contexto da aplicação.
  Future<void> _deletePlant(BuildContext context) async {
    try {
      await _plantService
          .deletePlant(plant.id!); // Exclui a planta do banco de dados
      Toast.showSuccess("Planta excluída com sucesso!",
          backgroundColor: Colors.red); // Exibe mensagem de sucesso
      if (context.mounted) {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  PlantListScreen()), // Redireciona para a tela de lista de plantas
          (Route<dynamic> route) => false,
        );
      }
    } catch (e) {
      Toast.showError("Erro ao excluir a planta: $e"); // Exibe mensagem de erro
    }
  }

  /// Exibe um diálogo de confirmação para excluir uma planta.
  ///
  /// [context] é o contexto da aplicação.
  void _showDeleteConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Confirmar Exclusão',
              style: TextStyle(color: Colors.white)),
          content: const Text('Tem certeza de que deseja excluir esta planta?',
              style: TextStyle(color: Colors.white)),
          actions: <Widget>[
            TextButton(
              child:
                  const Text('Cancelar', style: TextStyle(color: Colors.white)),
              onPressed: () {
                Navigator.of(context).pop(); // Fecha o diálogo
              },
            ),
            TextButton(
              child:
                  const Text('Excluir', style: TextStyle(color: Colors.white)),
              onPressed: () {
                Navigator.of(context).pop(); // Fecha o diálogo
                _deletePlant(context); // Chama a função para excluir a planta
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
      appBar: AppBar(
        title:
            Text(plant.name, style: const TextStyle(color: Color(0xFF1A1A19))),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit, color: Color(0xFF31511E)),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => PlantFormScreen(
                      plant: plant), // Navega para a tela de edição de planta
                ),
              );
            },
          ),
          Padding(
            padding: const EdgeInsets.only(
                right: 30.0), // Move button to the left by 30 pixels
            child: IconButton(
              icon: const Icon(Icons.delete, color: Colors.red),
              onPressed: () => _showDeleteConfirmationDialog(
                  context), // Exibe o diálogo de confirmação de exclusão
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
