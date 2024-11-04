import 'package:flutter/material.dart';
import 'package:plants_mobile/models/plant.dart';
import 'package:plants_mobile/services/plant_service.dart';
import 'package:plants_mobile/views/plant_form_screen.dart';
import 'package:plants_mobile/views/plant_detail_screen.dart';
import 'package:plants_mobile/components/toast.dart';

/// Tela principal que lista todas as plantas.
class PlantListScreen extends StatelessWidget {
  final PlantService _plantService = PlantService();

  PlantListScreen({super.key});

  /// Exibe um diálogo de confirmação para excluir uma planta.
  ///
  /// [context] é o contexto da aplicação.
  /// [plant] é a planta a ser excluída.
  void _showDeleteConfirmationDialog(BuildContext context, Plant plant) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: const Color(0xFF31511E),
          title: const Text('Confirmar Exclusão',
              style: TextStyle(color: Colors.white)), // Título do diálogo
          content: const Text('Tem certeza de que deseja excluir esta planta?',
              style: TextStyle(color: Colors.white)), // Conteúdo do diálogo
          actions: <Widget>[
            TextButton(
              style: TextButton.styleFrom(
                backgroundColor: const Color(0xFF859F3D),
              ),
              child: const Text('Cancelar',
                  style: TextStyle(color: Colors.white)),
              onPressed: () {
                Navigator.of(context).pop(); // Fecha o diálogo
              },
            ),
            TextButton(
              style: TextButton.styleFrom(
                backgroundColor: Colors.red,
              ),
              child: const Text('Excluir',
                  style: TextStyle(color: Colors.white)), // Texto branco
              onPressed: () {
                Navigator.of(context).pop(); // Fecha o diálogo
                _plantService.deletePlant(plant.id!).then((_) {
                  Toast.showSuccess("Planta excluída com sucesso!",
                      backgroundColor: Colors.red); // Exibe mensagem de sucesso
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => PlantListScreen()),
                    (Route<dynamic> route) => false,
                  ); // Redireciona para a tela de lista de plantas
                }).catchError((e) {
                  Toast.showError(
                      "Erro ao excluir a planta: $e"); // Exibe mensagem de erro
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
      backgroundColor: const Color(0xFF1A1A19),
      appBar: AppBar(
        title: const Text(
          "Catálogo de Plantas",
          style:
              TextStyle(color: Color(0xFF859F3D)),
        ),
        backgroundColor:
            const Color(0xFF1A1A19),
        elevation: 0,
        iconTheme: const IconThemeData(color: Color(0xFF31511E)),
      ),
      body: StreamBuilder<List<Plant>>(
        stream: _plantService.getPlants(), // Obtém a lista de plantas
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
                child:
                    CircularProgressIndicator()); // Exibe um indicador de carregamento
          }
          final plants = snapshot.data ??
              []; // Obtém a lista de plantas ou uma lista vazia
          return ListView.builder(
            padding: const EdgeInsets.all(
                16),
            itemCount: plants.length,
            itemBuilder: (context, index) {
              final plant = plants[index];
              return Card(
                margin: const EdgeInsets.symmetric(
                    vertical: 8),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(
                      15),
                ),
                color: const Color(0xFFFFFFFF),
                elevation: 3,
                child: ListTile(
                  contentPadding: const EdgeInsets.all(
                      16),
                  title: Text(
                    plant.name,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color:
                          Color(0xFF31511E),
                    ),
                  ),
                  subtitle: Text(
                    plant.description,
                    style: const TextStyle(
                        color: Color(
                            0xFF859F3D)), // Verde mais claro para a descrição
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
                        ), // Navega para a tela de edição de planta
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete, color: Colors.red),
                        onPressed: () => _showDeleteConfirmationDialog(context,
                            plant), // Exibe o diálogo de confirmação de exclusão
                      ),
                    ],
                  ),
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PlantDetailScreen(plant: plant),
                    ),
                  ), // Navega para a tela de detalhes da planta
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
        elevation: 6,
        backgroundColor: const Color(0xFF31511E),
        child: const Icon(Icons.add,
            color: Color(0xFF1A1A19)),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation
          .endFloat,
    );
  }
}
