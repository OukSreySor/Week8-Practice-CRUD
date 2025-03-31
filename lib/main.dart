
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:week8_crud/provider/pancake_provider.dart';
import 'package:week8_crud/repository/firebase_pancake_repository.dart';
import 'package:week8_crud/repository/pancake_repository.dart';
import 'package:week8_crud/screens/pancake_screen.dart';


void main() async {
  // 1 - Create repository
  final PancakeRepository pancakeRepository = FirebasePancakeRepository();

  // 2-  Run app
  runApp(
    ChangeNotifierProvider(
      create: (context) => Pancakeprovider(pancakeRepository),
      child: MaterialApp(debugShowCheckedModeBanner: false, home: const PancakeScreen()),
    ),
  );
}
