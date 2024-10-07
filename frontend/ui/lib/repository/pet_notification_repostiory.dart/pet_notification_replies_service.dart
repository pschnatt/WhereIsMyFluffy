// fetch pet notification replies

import 'dart:convert';

import 'package:ui/constants.dart';
import 'package:ui/repository/pet_notification_repostiory.dart/post_replies.dart';
import 'package:http/http.dart' as http;

class PetNotificationRepliesService {
  static Future<List<PetNotificationReplies>> fetchPetNotificationReplies(String id) async {
    final response = await http.get(Uri.parse('$APIURL/post/getReplies/'));
    final url = Uri.parse('$APIURL/post/getReplies/');
    final request = http.Request('GET', url);
    request.body = jsonEncode(id);
    request.headers.addAll({
      'Content-Type': 'application/json',
    });

    

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      return data.map((json) => PetNotificationReplies.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load posts');
    }
    
  }

  
    
}
