import 'dart:convert';
import 'dart:io';
import 'package:week8_crud/dto/pancake_dto.dart';
import 'package:week8_crud/model/pancake.dart';
import 'package:http/http.dart' as http;
import 'package:week8_crud/repository/pancake_repository.dart';

class FirebasePancakeRepository extends PancakeRepository {
  static const String baseUrl = 'https://week-8-practice-3f66d-default-rtdb.asia-southeast1.firebasedatabase.app';
  static const String pancakesCollection = "pancakes";
  static const String allPancakesUrl = '$baseUrl/$pancakesCollection.json';

  @override
  Future<Pancake> addPancake({required String color, required double price}) async {
    Uri uri = Uri.parse(allPancakesUrl);

    // Create a new data
    final newPancakeData = {'color': color, 'price': price};
    final http.Response response = await http.post(
      uri,
      headers: {'Content-Type': 'application/json'},
      body: json.encode(newPancakeData),
    );

    // Handle errors
    if (response.statusCode != HttpStatus.ok) {
      throw Exception('Failed to add user');
    }

    // Firebase returns the new ID in 'name'
    final newId = json.decode(response.body)['name'];

    // Return created user
    return Pancake(id: newId, color: color, price: price);
  }

  @override
  Future<List<Pancake>> getPancakes() async {
    Uri uri = Uri.parse(allPancakesUrl);
    final http.Response response = await http.get(uri);

    // Handle errors
    if (response.statusCode != HttpStatus.ok && response.statusCode != HttpStatus.created) {
      throw Exception('Failed to load');
    }

    // Return all users
    final data = json.decode(response.body) as Map<String, dynamic>?;

    if (data == null) return [];
    return data.entries.map((entry) => PancakeDto.fromJson(entry.key, entry.value)).toList();
  }
  
  @override
  Future<void> deletePancake({required String id}) async{
    
    Uri uri = Uri.parse('$baseUrl/$pancakesCollection/$id.json');
    
    final http.Response response = await http.delete(uri);

    // Handle errors
    if (response.statusCode != HttpStatus.ok && response.statusCode != HttpStatus.created) {
      throw Exception('Failed to delete');
    }
    

  }

  
}