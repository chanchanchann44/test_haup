import 'package:http/http.dart' as http;
import 'package:test_haup/models/CatModels.dart';

Future<List<String>> getCategories() async {
  var response = await http.get('https://api.publicapis.org/categories');
  List<String> data = catFromJson(response.body);

  return data;
}
