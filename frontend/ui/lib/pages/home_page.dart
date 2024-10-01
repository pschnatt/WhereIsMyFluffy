import 'package:flutter/material.dart';
import 'package:ui/widgets/pets_postcard.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: ListView(
        children: [
          _buildSearchBar(),
          const SizedBox(height: 16.0),
          _buildEmpytAdvertisement(),
          const SizedBox(height: 16.0),
          _buildPetsPostCard(
            name: 'Fluffy',
            userImageUrl: 
                "https://placedog.net/500",
            description: 'Cute and fluffy',
            distance: '1.5 km',
            petImageUrl: 'https://placedog.net/500',
          ),
          const SizedBox(height: 16.0),
          _buildPetsPostCard(
            name: 'Bella',
            userImageUrl: 'https://placedog.net/500/g',
            description: 'Cute and fluffy',
            distance: '1.5 km',
            petImageUrl: 'https://placedog.net/500/g',
          ),
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

  Widget _buildEmpytAdvertisement() {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
      elevation: 4,
      child: const Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(
              'No Ad found',
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
