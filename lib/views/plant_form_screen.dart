import 'package:flutter/material.dart';
import 'package:plants_mobile/models/plant.dart';
import 'package:plants_mobile/services/plant_service.dart';

class PlantFormScreen extends StatefulWidget {
  final Plant? plant;

  PlantFormScreen({this.plant});

  @override
  _PlantFormScreenState createState() => _PlantFormScreenState();
}

class _PlantFormScreenState extends State<PlantFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final PlantService _plantService = PlantService();
  late String _name;
  late String _description;
  late String _careInstructions;

  @override
  void initState() {
    super.initState();
    _name = widget.plant?.name ?? '';
    _description = widget.plant?.description ?? '';
    _careInstructions = widget.plant?.careInstructions ?? '';
  }

  Future<void> _savePlant() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      if (widget.plant == null) {
        await _plantService.addPlant(Plant(
            name: _name,
            description: _description,
            careInstructions: _careInstructions));
      } else {
        await _plantService.updatePlant(
          Plant(
              id: widget.plant!.id,
              name: _name,
              description: _description,
              careInstructions: _careInstructions),
        );
      }
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF6FCDF), // Fundo suave
      appBar: AppBar(
        title: Text(widget.plant == null ? "Adicionar Planta" : "Editar Planta",
            style: TextStyle(color: Color(0xFF1A1A19))),
        backgroundColor: Color(0xFFF6FCDF),
        elevation: 0,
        iconTheme: IconThemeData(color: Color(0xFF31511E)),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                initialValue: _name,
                decoration: InputDecoration(
                  labelText: 'Nome',
                  labelStyle: TextStyle(color: Color(0xFF31511E)),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Color(0xFF31511E)),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Color(0xFF859F3D)),
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                onSaved: (value) => _name = value!,
                validator: (value) =>
                    value!.isEmpty ? 'Campo obrigatório' : null,
              ),
              SizedBox(height: 12),
              TextFormField(
                initialValue: _description,
                decoration: InputDecoration(
                  labelText: 'Descrição',
                  labelStyle: TextStyle(color: Color(0xFF31511E)),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Color(0xFF31511E)),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Color(0xFF859F3D)),
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                onSaved: (value) => _description = value!,
                validator: (value) =>
                    value!.isEmpty ? 'Campo obrigatório' : null,
              ),
              SizedBox(height: 12),
              TextFormField(
                initialValue: _careInstructions,
                decoration: InputDecoration(
                  labelText: 'Cuidados',
                  labelStyle: TextStyle(color: Color(0xFF31511E)),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Color(0xFF31511E)),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Color(0xFF859F3D)),
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                onSaved: (value) => _careInstructions = value!,
                validator: (value) =>
                    value!.isEmpty ? 'Campo obrigatório' : null,
              ),
              SizedBox(height: 20),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF31511E),
                  padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)),
                ),
                onPressed: _savePlant,
                child: Text(widget.plant == null ? "Salvar" : "Atualizar",
                    style: TextStyle(color: Colors.white)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
