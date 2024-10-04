import 'package:flutter/material.dart';
import 'package:ui/widgets/forms/add_petform.dart';

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
            UserPosts()
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
        borderRadius: BorderRadius.circular(16), // Rounded corners for the container
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
                  _showModalAddPet(context);
                },
                child: const Text('Add More Pet'),
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

  void _showModalAddPet(BuildContext context) {
    showModalBottomSheet<void>(
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: 500,
          color: Colors.amber,
          child: const Center(child: AddPetForm()), // Assuming AddPetForm is imported
        );
      },
    );
  }

  // Widget to build pet card
  Widget _buildPetCard(String name, String lostplace, String imageUrl) {
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
              Text('lostplace $name from you',
                  style: const TextStyle(fontSize: 10, color: Colors.white)),
              Text(
                lostplace,
                style: const TextStyle(color: Colors.white),
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {
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

class UserPosts extends StatelessWidget {
  const UserPosts({super.key});

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
          // User Posts Section Title
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'User Posts',
                style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF4574D0)),
              ),
            ],
          ),

          const SizedBox(height: 10), // Space between title and posts

          // List of User Posts
          _buildPostCard(
              'Panda',
              'ABC School',
              'https://www.americanhumane.org/app/uploads/2021/03/Panda2-1024x576.png',
              'Please help me find my lost cat.',
              'found'),
          _buildPostCard(
              'Siri',
              'Happy Palace',
              'https://s.isanook.com/ns/0/ui/1913/9565922/GXPpWIraUAAFGeJ.jpg',
              'A small kitten was found near the park.',
              'pending'),
          _buildPostCard(
              'Bella',
              'KMITL',
              'https://www.readhowl.com/wp-content/uploads/2017/02/01.gif',
              'If anyone sees her, please contact me.',
              'missing'),
          _buildPostCard(
              'Whiskers',
              'City Park',
              'https://images.squarespace-cdn.com/content/v1/5e8a2944d7ce562e250eb009/1606862534597-VR0324SOZZ1VOIQYCTDO/goki.jpg',
              'She has been returned safely!',
              'returned'),
        ],
      ),
    );
  }

  // Function to build a user post card with a status
  Widget _buildPostCard(String petname, String lostplace, String imageUrl,
      String description, String status) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 6.0), // Padding between cards
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15), // Rounded corners for the card
        ),
        child: ListTile(
          leading: CircleAvatar(
            backgroundImage: NetworkImage(imageUrl), // Placeholder image for the post
          ),
          title: Text(
            petname,
            style: const TextStyle(fontSize: 16), // Font size for the pet name
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                lostplace,
                style: const TextStyle(fontSize: 14), // Font size for the lost place
              ),
              const SizedBox(height: 4),
              Text(
                description,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                    fontSize: 12, color: Colors.grey), // Description of the post
              ),
            ],
          ),
          trailing: _buildStatusIcon(status), // Status icon
        ),
      ),
    );
  }

  // Function to return the appropriate icon based on the post status
  Widget _buildStatusIcon(String status) {
    switch (status) {
      case 'missing':
        return const Icon(Icons.close, color: Colors.red); // X icon for missing
      case 'pending':
        return const Icon(Icons.help_outline, color: Colors.orange); // ? icon for pending
      case 'found':
        return const Icon(Icons.pets, color: Colors.green); // Paw icon for found
      case 'returned':
        return const Icon(Icons.home, color: Colors.blue); // Home icon for returned
      default:
        return const Icon(Icons.error, color: Colors.grey); // Default icon
    }
  }
}
