import 'package:week8_crud/model/pancake.dart';
import 'package:week8_crud/repository/pancake_repository.dart';

class MockPancakeRepository extends PancakeRepository {
  final List<Pancake> pancakes = [];

  @override
  Future<Pancake> addPancake({required String color, required double price}) {
    return Future.delayed(Duration(seconds: 1), () {
      Pancake newPancake = Pancake(id: "0", color: color, price: 12);
      pancakes.add(newPancake);
      return newPancake;
    });
  }

  @override
  Future<List<Pancake>> getPancakes() {
    return Future.delayed(Duration(seconds: 1), () => pancakes);
  }
  
  @override
  Future<List<Pancake>> deletePancake({required String id}) {
    // TODO: implement deletePancake
    throw UnimplementedError();
  }
}