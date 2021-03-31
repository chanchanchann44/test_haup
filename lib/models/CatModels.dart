import 'dart:convert';

List<String> catFromJson(String str) => List<String>.from(json.decode(str).map((x) => x));

String catToJson(List<String> data) => json.encode(List<dynamic>.from(data.map((x) => x)));