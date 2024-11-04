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
          backgroundColor:
              const Color(0xFFFCCD2A)); // Exibe mensagem de sucesso
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
          backgroundColor: const Color(0xFF347928), // Fundo verde escuro
          title: const Text('Confirmar Exclusão',
              style: TextStyle(color: Color(0xFFFCCD2A))), // Título do diálogo
          content: const Text('Tem certeza de que deseja excluir esta planta?',
              style:
                  TextStyle(color: Color(0xFFFCCD2A))), // Conteúdo do diálogo
          actions: <Widget>[
            TextButton(
              style: TextButton.styleFrom(
                backgroundColor: const Color(0xFFC0EBA6), // Fundo verde claro
              ),
              child: const Text('Cancelar',
                  style: TextStyle(
                      color: Color(0xFF347928))), // Texto verde escuro
              onPressed: () {
                Navigator.of(context).pop(); // Fecha o diálogo
              },
            ),
            TextButton(
              style: TextButton.styleFrom(
                backgroundColor: const Color(0xFFFCCD2A), // Fundo amarelo
              ),
              child: const Text('Excluir',
                  style: TextStyle(
                      color: Color(0xFF347928))), // Texto verde escuro
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
      backgroundColor: const Color(0xFFFFFBE6), // Fundo suave para a tela
      appBar: AppBar(
        title:
            Text(plant.name, style: const TextStyle(color: Color(0xFF347928))),
        backgroundColor: const Color(0xFFFCCD2A),
        elevation: 0,
        iconTheme: const IconThemeData(color: Color(0xFF347928)),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit, color: Color(0xFF347928)),
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
              icon: const Icon(Icons.delete, color: Color.fromARGB(255, 252, 42, 42)),
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
                  color: Color(0xFF347928)),
            ),
            const SizedBox(height: 12),
            Text(
              plant.description,
              style: const TextStyle(fontSize: 16, color: Color(0xFFC0EBA6)),
            ),
            const SizedBox(height: 20),
            const Text(
              "Cuidados:",
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF347928)),
            ),
            const SizedBox(height: 8),
            Text(
              plant.careInstructions,
              style: const TextStyle(fontSize: 16, color: Color(0xFF347928)),
            ),
          ],
        ),
      ),
    );
  }
}
