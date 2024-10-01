import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:ui/pages/pet_profile_page.dart';
import 'package:ui/pages/user_profile_page.dart';
import 'package:ui/widgets/forms/found_petform.dart';

class PetsPostCard extends StatelessWidget {
  final String name;
  final String userImageUrl;
  final String description;
  final String distance;
  final String petImageUrl;

  const PetsPostCard({
    super.key,
    required this.name,
    required this.userImageUrl,
    required this.description,
    required this.distance,
    required this.petImageUrl,
  });

  void _showModalBottomSheet(BuildContext context) {
    showModalBottomSheet<void>(
      context: context,
      builder: (BuildContext context) {
        return const FoundPetForm();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              children: [
                GestureDetector(
                  onTap: () {
                    // Navigate to ProfilePage when tapped

                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const UserProfilePage()),
                    );
                  },
                  child: const CircleAvatar(
                    backgroundImage: NetworkImage(
                        'https://pbs.twimg.com/media/GV_t3lqaoAIbO3B.jpg:large'), // Replace with the user avatar
                    radius: 20,
                  ),
                ),
                const SizedBox(width: 16.0),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        name,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        description,
                        style: const TextStyle(
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Distance: $distance',
                        style: const TextStyle(
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.more_vert),
                  onPressed: () {
                    // Action when pressing more options
                  },
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Image on the left
                GestureDetector(
                  onTap: () {
                    // Navigate to ProfilePage when tapped
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const PetProfilePage(
                                petName: 'Panda',
                                gender: 'Male',
                                color: 'Black and White',
                                age: '3 years',
                                weight: '6 Lbs',
                                breed: 'Chinese Panda',
                                descriptionItems: [
                                  'Cute little panda have a black collar with name tag'
                                ],
                              )),
                    );
                  },
                  child: Container(
                    height: 200,
                    width: 150,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15.0),
                      image: DecorationImage(
                        image: NetworkImage(petImageUrl),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                // Two cards on the right stacked vertically
                Expanded(
                  child: Column(
                    children: [
                      Card(
                        elevation: 3,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: const Padding(
                          padding: EdgeInsets.all(10.0),
                          child: Column(
                            children: [
                              // Pet information
                              Row(
                                children: [
                                  Icon(Icons.pets),
                                  SizedBox(width: 5),
                                  Text(
                                    'Name',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 13,
                                    ),
                                  ),
                                  SizedBox(width: 5),
                                  Text(
                                    'Tom',
                                    style: TextStyle(
                                      color: Colors.grey,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 5),
                              Row(
                                children: [
                                  Icon(Icons.line_weight),
                                  SizedBox(width: 5),
                                  Text(
                                    'Weight',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 13,
                                    ),
                                  ),
                                  SizedBox(width: 5),
                                  Text(
                                    '5 kg',
                                    style: TextStyle(
                                      color: Colors.grey,
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Icon(Icons.cake),
                                  SizedBox(width: 5),
                                  Text(
                                    'Age',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 13,
                                    ),
                                  ),
                                  SizedBox(width: 5),
                                  Text(
                                    '2 years',
                                    style: TextStyle(
                                      color: Colors.grey,
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Icon(Icons.cake),
                                  SizedBox(width: 8),
                                  Text(
                                    'Gender',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 13,
                                    ),
                                  ),
                                  SizedBox(width: 8),
                                  Text(
                                    'Male',
                                    style: TextStyle(
                                      color: Colors.grey,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Card(
                        elevation: 3,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: const Padding(
                          padding: EdgeInsets.all(12.0),
                          child: Row(
                            children: [
                              Icon(Icons.location_on),
                              SizedBox(width: 5),
                              Text(
                                'Lost at',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 13,
                                ),
                              ),
                              SizedBox(width: 5),
                              Text(
                                'Park',
                                style: TextStyle(
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            // details of the pet

            Row(
              children: [
                const Text('Details of the pet'),
                const Spacer(),
                ElevatedButton(
                  onPressed: () {
                    // Action when adopt button is pressed
                    _showModalBottomSheet(context);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  child: const Text(
                    'Found',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
