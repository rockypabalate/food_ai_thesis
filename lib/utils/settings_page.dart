import 'package:flutter/material.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
        backgroundColor: Colors.orange,
      ),
      body: ListView(
        children: [
          ListTile(
            leading: const Icon(Icons.qr_code),
            title: const Text('Share App by QR'),
            onTap: () {
              // Navigate to QR download page
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.info),
            title: const Text('About Us'),
            onTap: () {
              // Navigate to About Us page
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.logout),
            title: const Text('Logout'),
            onTap: () {
              // Handle logout functionality
            },
          ),
        ],
      ),
    );
  }
}
