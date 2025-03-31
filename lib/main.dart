
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:week8_crud/model/pancake.dart';
import 'package:week8_crud/provider/pancake_provider.dart';
import 'package:week8_crud/repository/firebase_pancake_repository.dart';
import 'package:week8_crud/repository/pancake_repository.dart';



class App extends StatelessWidget {
  const App({super.key});

  void _onAddPressed(BuildContext context) {
    final Pancakeprovider pancakeProvider = context.read<Pancakeprovider>();
    pancakeProvider.addPancake("blue", 3.1);
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
                IconButton(
                  icon: Icon(Icons.delete, color: Colors.red), 
                  onPressed: () => pancakeProvider.deletePancake(pancakes[index].id),
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

// 5 - MAIN
void main() async {
  // 1 - Create repository
  final PancakeRepository pancakeRepository = FirebasePancakeRepository();
  //final PancakeRepository mockPancakeRepo = MockPancakeRepository();

  // 2-  Run app
  runApp(
    ChangeNotifierProvider(
      create: (context) => Pancakeprovider(pancakeRepository),
      child: MaterialApp(debugShowCheckedModeBanner: false, home: const App()),
    ),
  );
}
