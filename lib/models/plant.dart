class Plant {
  String? id; // ID da planta, opcional
  String name; // Nome da planta
  String description; // Descrição da planta
  String careInstructions; // Instruções de cuidado da planta

  // Construtor da classe Plant
  Plant(
      {this.id,
      required this.name,
      required this.description,
      required this.careInstructions});

  // Converte um objeto Plant para um Map para salvar no Firestore
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'description': description,
      'careInstructions': careInstructions,
    };
  }

  // Converte um Map para criar um objeto Plant
  factory Plant.fromMap(String id, Map<String, dynamic> map) {
    return Plant(
      id: id,
      name: map['name'],
      description: map['description'],
      careInstructions: map['careInstructions'],
    );
  }
}
