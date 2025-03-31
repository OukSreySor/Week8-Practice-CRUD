import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:week8_crud/model/pancake.dart';
import 'package:week8_crud/provider/pancake_provider.dart';

class PancakeForm extends StatefulWidget {
  final Pancake? pancake;
  const PancakeForm({super.key, this.pancake});

  @override
  State<PancakeForm> createState() => _PancakeFormState();
}

class _PancakeFormState extends State<PancakeForm> {

  final _formKey = GlobalKey<FormState>();
  final TextEditingController _colorController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.pancake != null) {
      _colorController.text = widget.pancake!.color;
      _priceController.text = widget.pancake!.price.toString();
    }
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      final pancakeProvider = context.read<Pancakeprovider>();
      String color = _colorController.text.trim();
      double price = double.parse(_priceController.text.trim());

      if (widget.pancake == null) {
        pancakeProvider.addPancake(color, price);
      } else {
        pancakeProvider.updatePancake(widget.pancake!.id, color, price);
      }
      
      Navigator.pop(context); 
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Add Pancake")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _colorController,
                decoration: InputDecoration(labelText: "Color"),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter a color";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 50),
              TextFormField(
                controller: _priceController,
                decoration: InputDecoration(labelText: "Price"),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter a price";
                  }
                  if (double.tryParse(value) == null) {
                    return "Please enter a valid number";
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _submitForm,
                child: Text(widget.pancake == null ? "Add Pancake" : "Update Pancake"),
              ),
            ],
          ),
        ),
      ),
    );
  }
  
}
