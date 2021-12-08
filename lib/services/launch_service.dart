import 'dart:convert';

import 'package:flashtask/models/launch.dart';
import 'package:flashtask/models/past_launches.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class LaunchService {

  Future<Launch> fetchLaunch() async {
    var response = await http.get(Uri.parse('https://api.spacexdata.com/v3/launches/upcoming'));

    var json = convert.jsonDecode(response.body);

    var launch = Launch.fromJson(json[0]);

    return launch;
  }
  Future <List<PastLaunches>> fetchPastLaunches() async {
    final response =
    await http.get(Uri.parse('https://api.spacexdata.com/v5/launches/past'));
    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse.map((data) => new PastLaunches.fromJson(data)).toList();
    } else {
      throw Exception('Unexpected error occured!');
    }
  }

}