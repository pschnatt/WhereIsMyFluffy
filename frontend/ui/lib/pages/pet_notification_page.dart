import 'package:flutter/material.dart';

class PetNotificationPage extends StatelessWidget {
  const PetNotificationPage({super.key});

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
        
       _buildUserInfoCard(
          userName: 'John',
          userPhone: '0812345698',
          userLocation: 'Bangkok city, Thailand',
          userImageUrl: 'https://ntvb.tmsimg.com/assets/assets/487578_v9_bb.jpg?w=360&h=480', // User image URL
          petImageUrl: 'https://www.americanhumane.org/app/uploads/2021/03/Panda2-1024x576.png', // Pet image URL
          lastSeenTime: '5 min',
          detailsLocation: 'ABC grocery',
          petDetails: 'I found your pet beside the grocery store @ grand street',
        ),
        const SizedBox(height: 20),
    
        // Second user info card
        _buildUserInfoCard(
          userName: 'Jane',
          userPhone: '0987654321',
          userLocation: 'Chiang Mai, Thailand',
          userImageUrl: 'https://ntvb.tmsimg.com/assets/assets/487578_v9_bb.jpg?w=360&h=480', // Replace with actual image URL
          petImageUrl: 'https://www.americanhumane.org/app/uploads/2021/03/Panda2-1024x576.png', // Replace with actual pet image URL
          lastSeenTime: '10 min',
          detailsLocation: 'XYZ park',
          petDetails: 'I saw your pet near the fountain in XYZ park',
        ),
      ],
    ),
  );
}

Widget _buildUserInfoCard({
  required String userName,
  required String userPhone,
  required String userLocation,
  required String userImageUrl,
  required String petImageUrl,
  required String lastSeenTime,
  required String detailsLocation,
  required String petDetails,
}) {
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
              backgroundImage: NetworkImage(userImageUrl), // User image
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
  );
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
