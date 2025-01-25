import 'package:flutter/material.dart';
import 'package:food_ai_thesis/ui/views/widget_search_allrecipes/widget_search_allrecipes_view.dart';

class DashboardHeader extends StatelessWidget {
  final String profileImage;
  final String username;

  const DashboardHeader({
    Key? key,
    required this.profileImage,
    required this.username,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
      decoration: const BoxDecoration(
        color: Colors.orange,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(12.0),
          bottomRight: Radius.circular(12.0),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 6,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          const SizedBox(height: 35.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    radius: 22.0,
                    backgroundColor: Colors.grey.shade300,
                    backgroundImage: profileImage.isNotEmpty
                        ? NetworkImage(profileImage)
                        : null,
                    child: profileImage.isEmpty
                        ? const Icon(
                            Icons.person,
                            size: 22.0,
                            color: Colors.white,
                          )
                        : null,
                  ),
                  const SizedBox(width: 12.0),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        username,
                        style: const TextStyle(
                          fontSize: 17.0,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 1.0),
                      const Text(
                        'Discover filipino recipes!',
                        style: TextStyle(
                          fontSize: 12.0,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Row(
                children: [
                  const SizedBox(width: 10.0),
                  _buildIcon(
                    icon: Icons.notification_add,
                    onTap: () {
                      // Add your add functionality here
                      print('Add icon tapped');
                    },
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 16.0),
          // Search bar with filter button
          Row(
            children: [
              Expanded(
                child: SizedBox(
                  height: 45.0, // Reduced height
                  child: TextFormField(
                    readOnly: true,
                    decoration: InputDecoration(
                      prefixIcon: const Icon(
                        Icons.search,
                        color: Colors.orange,
                        size: 22.0, // Reduced icon size
                      ),
                      hintText: 'Search...',
                      hintStyle: const TextStyle(
                        color: Colors.grey,
                        fontSize: 14.0, // Reduced font size
                      ),
                      filled: true,
                      fillColor: Colors.grey.shade100,
                      contentPadding: const EdgeInsets.symmetric(
                        vertical: 6.0, // Reduced vertical padding
                        horizontal: 6.0, // Reduced horizontal padding
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(
                            10.0), // Slightly smaller radius
                        borderSide: BorderSide.none,
                      ),
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              const WidgetSearchAllrecipesView(),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 2.0),
        ],
      ),
    );
  }

  Widget _buildIcon({required IconData icon, required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(8.0),
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 4,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Icon(
          icon,
          size: 17.0,
          color: Colors.orange,
        ),
      ),
    );
  }
}
