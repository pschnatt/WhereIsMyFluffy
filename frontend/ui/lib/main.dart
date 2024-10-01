import 'package:flutter/material.dart';
import 'package:ui/pages/home_page.dart';
import 'package:ui/pages/pet_notification_page.dart';
import 'package:ui/pages/user_profile_page.dart';
import 'package:ui/widgets/forms/lost_petform.dart';

/// Flutter code sample for [NavigationBar].

void main() => runApp(const NavigationBarApp());

class NavigationBarApp extends StatelessWidget {
  const NavigationBarApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(useMaterial3: true),
      home: const FluffyBottomNavBar(),
    );
  }
}

// Fluffy bottom navigation bar
class FluffyBottomNavBar extends StatefulWidget {
  const FluffyBottomNavBar({super.key});

  @override
  State<FluffyBottomNavBar> createState() => _FluffyBottomNavBarState();
}

class _FluffyBottomNavBarState extends State<FluffyBottomNavBar> {
  int currentPageIndex = 0;
  /*
  ElevatedButton(
                  child: const Text('Close BottomSheet'),
                  onPressed: () => Navigator.pop(context),
                ),
                */
  void _showModalBottomSheet(BuildContext context) {
    showModalBottomSheet<void>(
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: 500,
          color: Colors.amber,
          child: Center(child: LostPetForm()),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Scaffold(
      appBar: _buildAppBar(context),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(36.0)),
        ),
        onPressed: () {
          _showModalBottomSheet(context);
        },
        child: const Icon(Icons.add),
      ),
      bottomNavigationBar: NavigationBar(
        onDestinationSelected: (int index) {
          setState(() {
            currentPageIndex = index;
          });
        },
        indicatorColor: Colors.amber,
        selectedIndex: currentPageIndex,
        destinations: <Widget>[
          NavigationDestination(
            selectedIcon: Transform.scale(
              scale: 1.5,
              child: const Icon(Icons.pets),
            ),
            icon: Badge(
                label: const Text('2'),
                child: Transform.scale(
                  scale: 1.5,
                  child: const Icon(Icons.pets),
                )),
            label: 'Pets',
          ),
          NavigationDestination(
            selectedIcon: Transform.scale(
              scale: 1.5,
              child: const Icon(Icons.home_rounded),
            ),
            icon: Transform.scale(
              scale: 1.5,
              child: const Icon(Icons.home_rounded),
            ),
            label: 'Home',
          ),
        ],
      ),
      body: <Widget>[
        /// Pet Notification page
        const PetNotificationPage(),

        /// Home page
        const HomePage(),
      ][currentPageIndex],
    );
  }
}

AppBar _buildAppBar(BuildContext context) {
  return AppBar(
    leading: Padding(
      padding: const EdgeInsets.all(4.0),
      child: Image.network(
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ0ac-zjL8AyD6jZ-nQ-dv3PXDE1j1GS0PI3uSNqr9tJUBKLByd8bQ7B6w6etR-sSYPksA&usqp=CAU'), // Replace with your logo
    ),
    actions: [
      TextButton(
        onPressed: () {
          // Logout action
        },
        child: const Text('Logout', style: TextStyle(color: Colors.green)),
      ),
      const SizedBox(width: 10),
      GestureDetector(
        onTap: () {
          // Navigate to ProfilePage when tapped
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const UserProfilePage()),
          );
        },
        child: const CircleAvatar(
          backgroundImage: NetworkImage(
              'https://pbs.twimg.com/media/GV_t3lqaoAIbO3B.jpg:large'), // Replace with the user avatar
          radius: 20,
        ),
      ),
      const SizedBox(width: 15),
    ],
    backgroundColor: Colors.transparent,
    elevation: 0,
  );
}
