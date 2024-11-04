import 'package:flutter/material.dart';
import 'package:plants_mobile/models/plant.dart';
import 'package:plants_mobile/services/plant_service.dart';
import 'package:plants_mobile/components/toast.dart';

/// Tela de formulário para adicionar ou editar uma planta.
class PlantFormScreen extends StatefulWidget {
  final Plant? plant;

  const PlantFormScreen({super.key, this.plant});

  @override
  PlantFormScreenState createState() => PlantFormScreenState();
}

class PlantFormScreenState extends State<PlantFormScreen> {
  final _formKey = GlobalKey<FormState>(); // Chave global para o formulário
  final PlantService _plantService =
      PlantService(); // Instância do serviço de plantas

  late TextEditingController _nameController;
  late TextEditingController _descriptionController;
  late TextEditingController _careInstructionsController;

  @override
  void initState() {
    super.initState();
    // Inicializa os controladores de texto com os valores da planta, se houver
    _nameController = TextEditingController(text: widget.plant?.name ?? '');
    _descriptionController =
        TextEditingController(text: widget.plant?.description ?? '');
    _careInstructionsController =
        TextEditingController(text: widget.plant?.careInstructions ?? '');
  }

  @override
  void dispose() {
    // Libera os recursos dos controladores de texto
    _nameController.dispose();
    _descriptionController.dispose();
    _careInstructionsController.dispose();
    super.dispose();
  }

  /// Salva a planta no banco de dados.
  ///
  /// Se a planta já existir, ela será atualizada. Caso contrário, uma nova planta será adicionada.
  Future<void> _savePlant() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      try {
        if (widget.plant == null) {
          // Adiciona uma nova planta
          await _plantService.addPlant(Plant(
              name: _nameController.text,
              description: _descriptionController.text,
              careInstructions: _careInstructionsController.text));
          Toast.showSuccess("Planta adicionada com sucesso!");
        } else {
          // Atualiza uma planta existente
          await _plantService.updatePlant(
            Plant(
                id: widget.plant!.id,
                name: _nameController.text,
                description: _descriptionController.text,
                careInstructions: _careInstructionsController.text),
          );
          Toast.showSuccess("Planta atualizada com sucesso!");
        }
        if (mounted) {
          Navigator.pop(context); // Fecha a tela de formulário
        }
      } catch (e) {
        Toast.showError(
            "Erro ao salvar a planta: $e"); // Exibe mensagem de erro
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:
            Text(widget.plant == null ? "Adicionar Planta" : "Editar Planta"),
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
                validator: (value) => value!.isEmpty
                    ? 'Campo obrigatório'
                    : null, // Validação do campo
              ),
              const SizedBox(height: 16),
              Flexible(
                child: TextFormField(
                  controller: _descriptionController,
                  decoration: const InputDecoration(labelText: 'Descrição'),
                  validator: (value) => value!.isEmpty
                      ? 'Campo obrigatório'
                      : null, // Validação do campo
                  maxLines: null,
                ),
              ),
              const SizedBox(height: 16),
              Flexible(
                child: TextFormField(
                  controller: _careInstructionsController,
                  decoration: const InputDecoration(labelText: 'Cuidados'),
                  validator: (value) => value!.isEmpty
                      ? 'Campo obrigatório'
                      : null, // Validação do campo
                  maxLines: null,
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _savePlant, // Chama a função para salvar a planta
                child: Text(widget.plant == null ? "Salvar" : "Atualizar"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
