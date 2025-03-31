
import 'package:week8_crud/model/pancake.dart';

abstract class PancakeRepository {
  Future<Pancake> addPancake({required String color, required double price});
  Future<List<Pancake>> getPancakes();
  Future<void> deletePancake({required String id});
  Future<void> updatePancake({required String id, required String newColor, required double newPrice});
}