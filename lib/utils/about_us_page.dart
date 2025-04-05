import 'package:flutter/material.dart';

class AboutUsPage extends StatelessWidget {
  final List<Map<String, String>> dependencies = [
    {"name": "Flutter SDK", "description": "Cross-platform mobile framework"},
    {"name": "Dio", "description": "Powerful HTTP client for API requests"},
    {"name": "Stacked", "description": "MVVM state management solution"},
    {
      "name": "Image Picker",
      "description": "Select images from gallery/camera"
    },
    {"name": "QR Code Scanner", "description": "Scan and generate QR codes"},
    {"name": "MySQL2", "description": "Database integration for Node.js"},
    {"name": "Node.js", "description": "Backend API handling"},
  ];

  AboutUsPage({super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          'About Us',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.orange,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header Section with App Logo
            Center(
              child: Column(
                children: [
                  Image.asset(
                    'lib/assets/foodlogo.png',
                    fit: BoxFit.contain,
                    width: screenWidth * 0.6, // Adjust width dynamically
                    height: screenWidth * 0.6, // Adjust height dynamically
                    errorBuilder: (context, error, stackTrace) =>
                        const Icon(Icons.error, size: 100, color: Colors.red),
                  ),
                  const Text(
                    "About Our App",
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 5),
                  const Text(
                    "Bringing innovation with Flutter technology",
                    style: TextStyle(fontSize: 16, color: Colors.black54),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // App Description
            Card(
              color: Colors.white,
              elevation: 3,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Padding(
                padding: EdgeInsets.all(16.0),
                child: Text(
                  "This application is built using Flutter, ensuring a seamless and fast user experience. We use the latest technologies to provide efficient features and a modern UI.",
                  style: TextStyle(fontSize: 16, color: Colors.black87),
                  textAlign: TextAlign.justify,
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Dependencies Section
            const Text(
              "Technologies Used:",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 10),
            ...dependencies.map((dep) => Card(
                  color: Colors.white,
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: ListTile(
                    leading: const Icon(Icons.extension, color: Colors.orange),
                    title: Text(dep["name"]!,
                        style: const TextStyle(fontSize: 16)),
                    subtitle: Text(dep["description"]!,
                        style: const TextStyle(
                            fontSize: 14, color: Colors.black54)),
                  ),
                )),
            const SizedBox(height: 20),

            // Contact Section
            const Text(
              "Contact Us:",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 10),
            Card(
              color: Colors.white,
              elevation: 3,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: const ListTile(
                leading: Icon(Icons.email, color: Colors.orange),
                title: Text("support@yourapp.com"),
                subtitle: Text("Get in touch with our team"),
              ),
            ),
            Card(
              color: Colors.white,
              elevation: 3,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: const ListTile(
                leading: Icon(Icons.web, color: Colors.orange),
                title: Text("www.yourapp.com"),
                subtitle: Text("Visit our official website"),
              ),
            ),
            const SizedBox(height: 20),

            // Footer
            const Center(
              child: Text(
                "© 2025 Food AI Name. All Rights Reserved.",
                style: TextStyle(fontSize: 14, color: Colors.black54),
              ),
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
