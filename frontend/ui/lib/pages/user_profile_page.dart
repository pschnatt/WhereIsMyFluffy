import 'package:flutter/material.dart';

class UserProfilePage extends StatelessWidget {
  const UserProfilePage({super.key});

  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Profile'),
      ),
      body: const Center(
        child:  SingleChildScrollView(
        // This makes the content scrollable
        child: Column(
          children: [
            // Profile Section
            Profile(),
            Divider(),
            Mypet(),
            Divider(),
            Recommend()
          ],
        ),
      ),
      ),
    );
  }
}

class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          const CircleAvatar(
            radius: 40,
            backgroundImage: NetworkImage(
                'https://pbs.twimg.com/media/GV_t3lqaoAIbO3B.jpg:large'), // Replace with user image URL
          ),
          const SizedBox(width: 16),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Hi, Nene!',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text('06 24452270'),
                Text('Bangkok city, Thailand'),
              ],
            ),
          ),
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () {
              // Edit profile action
            },
          )
        ],
      ),
    );
  }
}

class Mypet extends StatelessWidget {
  const Mypet({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.all(10), // Margin around the container
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 255, 255, 255),
        borderRadius:
            BorderRadius.circular(16), // Rounded corners for the container
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Title Row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Your Pet',
                style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF4574D0)),
              ),
              TextButton(
                onPressed: () {
                  // See all pets action
                },
                child: const Text('See All +'),
              ),
            ],
          ),

          // Pet Cards List
          const SizedBox(height: 1),
          SizedBox(
            height: 260, // Adjust height as needed
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                _buildPetCard('Panda', '1.2 km',
                    'https://www.americanhumane.org/app/uploads/2021/03/Panda2-1024x576.png'),
                _buildPetCard('Siri', '1.2 km',
                    'https://s.isanook.com/ns/0/ui/1913/9565922/GXPpWIraUAAFGeJ.jpg'),
                _buildPetCard('Bella', '2.5 km',
                    'https://www.readhowl.com/wp-content/uploads/2017/02/01.gif'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Widget to build pet card
  Widget _buildPetCard(String name, String distance, String imageUrl) {
    return Container(
      margin: const EdgeInsets.all(5.0),
      padding: const EdgeInsets.all(3.0),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        color: const Color(0xFF4574D0),
        child: SizedBox(
          width: 150,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                backgroundImage: NetworkImage(imageUrl),
                radius: 30,
              ),
              const SizedBox(height: 10),
              Text(
                name,
                style: const TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 5),
              Text('Distance $name from you',
                  style: const TextStyle(fontSize: 10, color: Colors.white)),
              Text(
                distance,
                style: const TextStyle(color: Colors.white),
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {
                  // Track pet action
                },
                child: const Text('More Detail'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Recommend extends StatelessWidget {
  const Recommend({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.all(16), // Padding for the entire container
      decoration: BoxDecoration(
        color: Colors.white, // Background color for the container
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Nearby Restaurants Section Title
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Pet Cafe Nearby',
                style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF4574D0)),
              ),
            ],
          ),

          const SizedBox(height: 10), // Space between title and card

          _buildRecommendationCard(
              'The Cat Cafe',
              '2.0 km',
              'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcReTsAbMThNX385LhwSNpy1snKoesi9wpkzmA&s',
              '4.8'),
          _buildRecommendationCard(
              'Pet Lovers Restaurant',
              '3.5 km',
              'https://aboutmom.co/wp-content/uploads/2022/02/littlezoocafe_30.jpg',
              '4.5'),
          _buildRecommendationCard(
              'Pet-friendly Diner',
              '5.2 km',
              'https://cdn.tatlerasia.com/tatlerasia/i/2024/03/01173100-268453314-455847395929761-18384109411955948-n_cover_1080x1307.jpg',
              '4.3'),
        ],
      ),
    );
  }

  // Function to build a recommendation card
  Widget _buildRecommendationCard(
      String name, String distance, String imageUrl, String rating) {
    return Container(
      padding:
          const EdgeInsets.symmetric(vertical: 6.0), // Padding between cards
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius:
              BorderRadius.circular(15), // Rounded corners for the card
        ),
        child: ListTile(
          leading: CircleAvatar(
            backgroundImage:
                NetworkImage(imageUrl), // Placeholder image for the restaurant
          ),
          title: Text(
            name,
            style: const TextStyle(
                fontSize: 16), // Font size for the restaurant name
          ),
          subtitle: Text(
            distance,
            style: const TextStyle(fontSize: 14), // Font size for the distance
          ),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.star, color: Colors.yellow),
              const SizedBox(
                  width: 5), // Space between the star icon and rating
              Text(
                rating,
                style:
                    const TextStyle(fontSize: 14), // Font size for the rating
              ),
            ],
          ),
        ),
      ),
    );
  }
}
