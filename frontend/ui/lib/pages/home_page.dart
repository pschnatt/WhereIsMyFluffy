import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:ui/widgets/pets_postcard.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<dynamic> _posts = [];

  @override
  void initState() {
    super.initState();
    _fetchPosts();
  }

  Future<void> _fetchPosts() async {
    final response = await http.get(Uri.parse('http://10.0.2.2:8000/post/getPosts/'));

    if (response.statusCode == 200) {
      setState(() {
        _posts = jsonDecode(response.body);
        debugPrint(response.body);
      });
    } else {
      throw Exception('Failed to load posts');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: ListView(
        children: [
          _buildSearchBar(),
          const SizedBox(height: 16.0),
          _posts.isEmpty ? _buildEmptyAdvertisement() : _buildPostList(),
        ],
      ),
    );
  }

  Widget _buildSearchBar() {
    return TextField(
      decoration: InputDecoration(
        hintText: 'Search',
        prefixIcon: const Icon(Icons.search),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
    );
  }

  Widget _buildEmptyAdvertisement() {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
      elevation: 4,
      child: const Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(
              'No posts found',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            SizedBox(height: 8),
            Text(
              'Try again later',
              style: TextStyle(
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPostList() {
    return Column(
      children: _posts.map((post) {
        return _buildPetsPostCard(
          name: post['name'],
          userImageUrl: 'https://example.com/user-profile.png', // Replace with actual user image URL if available
          description: post['description'] ?? 'No description provided', // You can change this if you have a description field
          distance: 'Unknown distance', // Modify this as needed
          petImageUrl: post['petImageUrl'] ?? 'https://example.com/pet-image.png', // Replace with actual pet image URL
        );
      }).toList(),
    );
  }

  Widget _buildPetsPostCard({
    required String name,
    required String userImageUrl,
    required String description,
    required String distance,
    required String petImageUrl,
  }) {
    return PetsPostCard(
      name: name,
      userImageUrl: userImageUrl,
      description: description,
      distance: distance,
      petImageUrl: petImageUrl,
    );
  }
}
