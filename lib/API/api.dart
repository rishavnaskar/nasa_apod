import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class Api {
  getApi() async {
    String apiKey = dotenv.env['apikey'];
    Uri url = Uri.parse('https://api.nasa.gov/planetary/apod?api_key=$apiKey');
    http.Response response = await http.get(url);

    if (response.statusCode == 200) {
      String data = response.body;
      return jsonDecode(data);
    } else
      print(response.statusCode);
  }
}
