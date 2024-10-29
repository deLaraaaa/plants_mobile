import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:plants_mobile/models/plant.dart';

class PlantService {
  final CollectionReference _plantsCollection =
      FirebaseFirestore.instance.collection('plants');

  // Adicionar planta
  Future<void> addPlant(Plant plant) async {
    await _plantsCollection.add(plant.toMap());
  }

  // Obter todas as plantas
  Stream<List<Plant>> getPlants() {
    return _plantsCollection.snapshots().map((snapshot) {
      return snapshot.docs
          .map((doc) =>
              Plant.fromMap(doc.id, doc.data() as Map<String, dynamic>))
          .toList();
    });
  }

  // Atualizar planta
  Future<void> updatePlant(Plant plant) async {
    await _plantsCollection.doc(plant.id).update(plant.toMap());
  }

  // Excluir planta
  Future<void> deletePlant(String id) async {
    await _plantsCollection.doc(id).delete();
  }
}
