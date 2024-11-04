import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:plants_mobile/models/plant.dart';

/// Serviço responsável por gerenciar as operações CRUD para plantas no Firestore.
class PlantService {
  // Referência para a coleção 'plants' no Firestore.
  final CollectionReference _plantsCollection =
      FirebaseFirestore.instance.collection('plants');

  /// Adiciona uma nova planta ao Firestore.
  ///
  /// [plant] é a planta a ser adicionada.
  Future<void> addPlant(Plant plant) async {
    await _plantsCollection
        .add(plant.toMap()); // Adiciona a planta convertida em mapa à coleção
  }

  /// Obtém todas as plantas do Firestore.
  ///
  /// Retorna um stream de listas de plantas.
  Stream<List<Plant>> getPlants() {
    return _plantsCollection.snapshots().map((snapshot) {
      return snapshot.docs
          .map((doc) => Plant.fromMap(
              doc.id,
              doc.data() as Map<String,
                  dynamic>)) // Converte cada documento em um objeto Plant
          .toList();
    });
  }

  /// Atualiza uma planta existente no Firestore.
  ///
  /// [plant] é a planta a ser atualizada.
  Future<void> updatePlant(Plant plant) async {
    await _plantsCollection.doc(plant.id).update(
        plant.toMap()); // Atualiza o documento da planta com os novos dados
  }

  /// Exclui uma planta do Firestore.
  ///
  /// [id] é o ID da planta a ser excluída.
  Future<void> deletePlant(String id) async {
    await _plantsCollection
        .doc(id)
        .delete(); // Exclui o documento da planta pelo ID
  }
}
