// Pet Profile Screen
import 'package:flutter/material.dart';

class PetProfilePage extends StatelessWidget {
  final String petName;
  final String gender;
  final String color;
  final String age;
  final String weight;
  final String breed;
  final List<String> descriptionItems;

  const PetProfilePage({
    super.key,
    required this.petName,
    required this.gender,
    required this.color,
    required this.age,
    required this.weight,
    required this.breed,
    required this.descriptionItems,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Pet Profile'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Section 1: Pet Info
            PetInfoSection(
              petName: petName,
              gender: gender,
              color: color,
              age: age,
              weight: weight,
              breed: breed,
            ),
            const SizedBox(height: 16),
            // Section 3: Description
            PetDescriptionSection(descriptionItems: descriptionItems),
          ],
        ),
      ),
    );
  }
}

class PetInfoSection extends StatelessWidget {
  final String petName;
  final String gender;
  final String color;
  final String age;
  final String weight;
  final String breed;

  const PetInfoSection({
    super.key,
    required this.petName,
    required this.gender,
    required this.color,
    required this.age,
    required this.weight,
    required this.breed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 120,
                height: 100,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  image: const DecorationImage(
                    image: NetworkImage(
                        'https://www.americanhumane.org/app/uploads/2021/03/Panda2-1024x576.png'), // Replace with user image URL
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      petName,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(gender),
                    Text(color),
                  ],
                ),
              ),
              IconButton(
                icon: const Icon(Icons.edit),
                onPressed: () {
                  // Edit profile action
                },
              ),
            ],
          ),
          const SizedBox(height: 16),
          PetStatsSection(age: age, weight: weight, breed: breed),
        ],
      ),
    );
  }
}

// Section 2: Pet Stats
class PetStatsSection extends StatelessWidget {
  final String age;
  final String weight;
  final String breed;

  const PetStatsSection({
    super.key,
    required this.age,
    required this.weight,
    required this.breed,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: StatBox(title: 'Age', value: age),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: StatBox(title: 'Weight', value: weight),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Container(
          width: double.infinity,
          child: StatBox(title: 'Breed', value: breed),
        ),
      ],
    );
  }
}

// Reusable StatBox widget for styling
class StatBox extends StatelessWidget {
  final String title;
  final String value;

  const StatBox({super.key, required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: const Color(0xFF4574D0),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(fontSize: 16, color: Colors.white),
          ),
          Text(
            value,
            style: const TextStyle(
                fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
          ),
        ],
      ),
    );
  }
}

class PetDescriptionSection extends StatelessWidget {
  final List<String> descriptionItems;

  const PetDescriptionSection({super.key, required this.descriptionItems});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Description for Panda',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          PetDescriptionList(descriptionItems: descriptionItems),
        ],
      ),
    );
  }
}

class PetDescriptionList extends StatelessWidget {
  final List<String> descriptionItems;

  const PetDescriptionList({super.key, required this.descriptionItems});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: descriptionItems
          .map((description) => Padding(
                padding: const EdgeInsets.only(bottom: 4),
                child: Text(
                  '• $description',
                  style: const TextStyle(fontSize: 16),
                ),
              ))
          .toList(),
    );
  }
}
