// ignore_for_file: unnecessary_null_comparison

import 'dart:convert';
import 'dart:io';
import 'dart:async';

class Sneakers {
  final String name;
  String? imageUrl;
  String? apiname;
  String? ratingSneakers;
  String? price;
  String? description;

  int rating = 10;

  Sneakers(this.name);

  Future getImageUrl() async {
    if (imageUrl != null) {
      return;
    }

    HttpClient http = HttpClient();
    try {
      apiname = name.toLowerCase();

      var uri = Uri.https('6747459d38c8741641d61c4d.mockapi.io', '/apisneakers/v1/sneakers', {'idName': name});
      var request = await http.getUrl(uri);
      var response = await request.close();
      var responseBody = await response.transform(utf8.decoder).join();

      List data = json.decode(responseBody);
      imageUrl = data[0]['image'];
      price = data[0]['price'];
      description = data[0]['name'];
      ratingSneakers = data[0]['rating'];

    } catch (exception) {
      //print(exception);
    }
  }
}
