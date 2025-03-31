import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:week8_crud/model/pancake.dart';
import 'package:week8_crud/provider/pancake_provider.dart';
import 'package:week8_crud/screens/pancake_form.dart';

class PancakeScreen extends StatelessWidget {
  const PancakeScreen({super.key});

  void _onAddPressed(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => PancakeForm()),
    );
  }

  void _onEditPressed(BuildContext context, Pancake pancake) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => PancakeForm(pancake: pancake)),
    );
  }

  @override
  Widget build(BuildContext context) {
    final pancakeProvider = Provider.of<Pancakeprovider>(context);

    Widget content = Text('');
    if (pancakeProvider.isLoading) {
      content = CircularProgressIndicator();
    } else if (pancakeProvider.hasData) {
      List<Pancake> pancakes = pancakeProvider.pancakesState!.data!;

      if (pancakes.isEmpty) {
        content = Text("No data yet");
      } else {
        content = ListView.builder(
          itemCount: pancakes.length,
          itemBuilder:
              (context, index) => ListTile(
                title: Text(pancakes[index].color),
                subtitle: Text("${pancakes[index].price}"),
                trailing: 
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: Icon(Icons.edit, color: Colors.blue), 
                      onPressed: () => _onEditPressed(context, pancakes[index]),
                    ),
                    IconButton(
                      icon: Icon(Icons.delete, color: Colors.red), 
                      onPressed: () => pancakeProvider.deletePancake(pancakes[index].id),
                    ),
                  ],
                ),
              ),
        );
      }
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        actions: [IconButton(onPressed: () => _onAddPressed(context), icon: const Icon(Icons.add))],
      ),
      body: Center(child: content),
    );
  }
}