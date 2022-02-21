import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;

class RemoteService {
  static var client = http.Client();

  static fetchVideos() async {
    try {
      var response = await client.get(Uri.parse(
          "https://api.bottomstreet.com/socialMediaFeed?source=youtube"));
      if (response.statusCode == 200) {
        var jsonString = response.body;
        if (kDebugMode) {
          print(response.body);
        }
        return await jsonDecode(jsonString);
      } else {
        if (kDebugMode) {
          print(response.body);
        }
        return null;
      }
    }
    on PlatformException catch(e)
    {
        return e.code.replaceAll("_", " ").toString();
    }
  }
}
