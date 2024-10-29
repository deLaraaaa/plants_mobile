class Plant {
  String? id;
  String name;
  String description;
  String careInstructions;

  Plant(
      {this.id,
      required this.name,
      required this.description,
      required this.careInstructions});

  // Converter para Map para salvar no Firestore
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'description': description,
      'careInstructions': careInstructions,
    };
  }

  // Converter de Map para criar um objeto Plant
  factory Plant.fromMap(String id, Map<String, dynamic> map) {
    return Plant(
      id: id,
      name: map['name'],
      description: map['description'],
      careInstructions: map['careInstructions'],
    );
  }
}
