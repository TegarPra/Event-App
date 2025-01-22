import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:event/api/event.dart';

Future<List<Event>> fetchEvents() async {
  final response = await http.get(Uri.parse('https://teknologi22.xyz/project_api/api_tama/event/get_events.php'));

  if (response.statusCode == 200) {
    List<dynamic> data = json.decode(response.body);
    return data.map((json) => Event.fromJson(json)).toList();
  } else {
    throw Exception('Failed to load events');
  }
}

