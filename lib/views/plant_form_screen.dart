import 'package:flutter/material.dart';
import 'package:plants_mobile/models/plant.dart';
import 'package:plants_mobile/services/plant_service.dart';

class PlantFormScreen extends StatefulWidget {
  final Plant? plant;

  const PlantFormScreen({super.key, this.plant});

  @override
  PlantFormScreenState createState() => PlantFormScreenState();
}

class PlantFormScreenState extends State<PlantFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final PlantService _plantService = PlantService();

  late TextEditingController _nameController;
  late TextEditingController _descriptionController;
  late TextEditingController _careInstructionsController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.plant?.name ?? '');
    _descriptionController =
        TextEditingController(text: widget.plant?.description ?? '');
    _careInstructionsController =
        TextEditingController(text: widget.plant?.careInstructions ?? '');
  }

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    _careInstructionsController.dispose();
    super.dispose();
  }

  Future<void> _savePlant() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      if (widget.plant == null) {
        await _plantService.addPlant(Plant(
            name: _nameController.text,
            description: _descriptionController.text,
            careInstructions: _careInstructionsController.text));
      } else {
        await _plantService.updatePlant(
          Plant(
              id: widget.plant!.id,
              name: _nameController.text,
              description: _descriptionController.text,
              careInstructions: _careInstructionsController.text),
        );
      }
      if (mounted) {
        Navigator.pop(context);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6FCDF), // Fundo suave
      appBar: AppBar(
        title: Text(widget.plant == null ? "Adicionar Planta" : "Editar Planta",
            style: const TextStyle(color: Color(0xFF1A1A19))),
        backgroundColor: const Color(0xFFF6FCDF),
        elevation: 0,
        iconTheme: const IconThemeData(color: Color(0xFF31511E)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(labelText: 'Nome'),
                validator: (value) =>
                    value!.isEmpty ? 'Campo obrigatório' : null,
              ),
              const SizedBox(height: 16),
              Flexible(
                child: TextFormField(
                  controller: _descriptionController,
                  decoration: const InputDecoration(labelText: 'Descrição'),
                  validator: (value) =>
                      value!.isEmpty ? 'Campo obrigatório' : null,
                  maxLines: null,
                ),
              ),
              const SizedBox(height: 16),
              Flexible(
                child: TextFormField(
                  controller: _careInstructionsController,
                  decoration: const InputDecoration(labelText: 'Cuidados'),
                  validator: (value) =>
                      value!.isEmpty ? 'Campo obrigatório' : null,
                  maxLines: null,
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF31511E),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)),
                ),
                onPressed: _savePlant,
                child: Text(widget.plant == null ? "Salvar" : "Atualizar",
                    style: const TextStyle(color: Colors.white)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
