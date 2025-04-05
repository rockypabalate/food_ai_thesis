import 'package:flutter/material.dart';
import 'package:food_ai_thesis/utils/about_us_page.dart';
import 'package:food_ai_thesis/utils/qr_code.dart';
import 'package:stacked/stacked.dart';

import 'setting_page_viewmodel.dart';

class SettingPageView extends StackedView<SettingPageViewModel> {
  const SettingPageView({Key? key}) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    SettingPageViewModel viewModel,
    Widget? child,
  ) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          'Settings',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.orange,
        iconTheme: const IconThemeData(color: Colors.white), // Make icons white
      ),
      body: ListView(
        children: [
          ListTile(
            leading: const Icon(Icons.qr_code, color: Colors.orange),
            title: const Text('Download App by QR'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const QRCodePage()),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.info, color: Colors.orange),
            title: const Text('About Us'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AboutUsPage()),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.logout, color: Colors.orange),
            title: const Text('Logout'),
            onTap: () => _showLogoutDialog(context, viewModel),
          ),
        ],
      ),
    );
  }

  @override
  SettingPageViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      SettingPageViewModel();

  // Logout Confirmation Dialog
  void _showLogoutDialog(BuildContext context, SettingPageViewModel viewModel) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          title: const Column(
            children: [
              Icon(Icons.warning_amber_rounded, size: 50, color: Colors.red),
              SizedBox(height: 10),
              Text("Logout",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
            ],
          ),
          content: const Text(
            "Are you sure you want to log out?",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 16, color: Colors.black87),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context), // Close dialog
              child: const Text("Cancel", style: TextStyle(color: Colors.grey)),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context); // Close dialog
                viewModel.logout(); // Call logout function
              },
              style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
              child:
                  const Text("Logout", style: TextStyle(color: Colors.white)),
            ),
          ],
        );
      },
    );
  }
}
