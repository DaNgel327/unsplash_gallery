import 'dart:convert';
import 'source.dart';
import 'package:http/http.dart' as http;

final List jsonExecutionQueryProperties = [
  'small', // First page image sizes
  'regular', // Second page image size
  'username' // Author's displayed info
];

Future<List> getPictures() async {
  var url = 'https://api.unsplash.com/photos/?client_id=$apiKey';
  http.Response response = await http.get(url);
  return jsonDecode(response.body);
}
