import 'package:flutter/material.dart';
import 'package:ui/repository/pet_notification_repostiory.dart/post_replies.dart';

class PetNotificationPage extends StatelessWidget {
  
  List<PetNotificationReplies> petNotificationReplies = [];
  PetNotificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return _buildBody();
  }
}


Widget _buildBody() {
  return Padding(
    padding: const EdgeInsets.all(16.0),
    child: ListView(
      children: [
        const Text(
          'Last seen',
          style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold,
            color: Color(0xFF4574D0),
          ),
        ),
        const SizedBox(height: 20),

      ],
    ),
  );
}

class PetNotificationReplyCard extends StatelessWidget {
  final String iD;
  final String postID;
  final String userID;
  final String address;
  final String detail;
  final String createdAt;
  final String updatedAt;

  const PetNotificationReplyCard({super.key, required this.iD, required this.postID, required this.userID, required this.address, required this.detail, required this.createdAt, required this.updatedAt});

  @override
  Widget build(BuildContext context) {
    return Container(
    padding: const EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      color: const Color(0xFF4574D0),
      borderRadius: BorderRadius.circular(16.0),
    ),
    child: Column(
      children: [
        Row(
          children: [
            CircleAvatar(
              radius: 30,
              backgroundImage: NetworkImage("userImageUrl"), // User image
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    userName, // User name
                    style: const TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    userPhone, // User phone
                    style: const TextStyle(color: Colors.white),
                  ),
                  Text(
                    userLocation, // User location
                    style: const TextStyle(color: Colors.white),
                  ),
                ],
              ),
            ),
            Text(
              lastSeenTime, // Last seen time
              style: const TextStyle(color: Colors.white),
            ),
          ],
        ),
        const SizedBox(height: 20),
        const Text(
          'has seen your PANDA',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 16),
        Image.network(
          petImageUrl, // Pet image
          height: 150,
          width: double.infinity,
          fit: BoxFit.cover,
        ),
        const SizedBox(height: 10),
        const Align(
          alignment: Alignment.centerLeft,
          child: Text(
            'Details',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            petDetails, // Pet details
            style: const TextStyle(color: Colors.white),
          ),
        ),
        const SizedBox(height: 5),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Icon(
              Icons.location_on, // Location icon
              color: Colors.white,
            ),
            const SizedBox(width: 5), // Small gap between icon and text
            GestureDetector(
              onTap: () {
                // Open map or further location
              },
              child: Text(
                detailsLocation, // Location details
                style: const TextStyle(
                  color: Colors.white,
                  decoration: TextDecoration.underline,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),
        _buildActionButtons(),
      ],
    ),
  );;
  }
}



Widget _buildActionButtons() {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    children: [
      ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        onPressed: () {
          // Your pet action
        },
        child: const Text(
          'Your pet',
          style: TextStyle(color: Color(0xFF4574D0)),
        ),
      ),
      ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        onPressed: () {
          // Not your pet action
        },
        child: const Text(
          'Not your pet',
          style: TextStyle(color: Color(0xFF4574D0)),
        ),
      ),
    ],
  );
}
