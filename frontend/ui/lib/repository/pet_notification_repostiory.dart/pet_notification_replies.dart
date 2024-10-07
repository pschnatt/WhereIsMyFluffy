// fetch pet notification replies

import 'dart:convert';

import 'package:ui/constants.dart';
import 'package:ui/repository/pet_notification_repostiory.dart/post_replies.dart';
import 'package:http/http.dart' as http;

Future<List<PetNotificationReplies>> fetchPosts() async {
    final response = await http.get(Uri.parse('https://your-api-endpoint.com/posts'));

    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse.map((post) => PetNotificationReplies.fromJson(post)).toList();
    } else {
      throw Exception('Failed to load posts');
    }
  }