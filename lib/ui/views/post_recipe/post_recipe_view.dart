import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'post_recipe_viewmodel.dart';

class PostRecipeView extends StackedView<PostRecipeViewModel> {
  const PostRecipeView({Key? key}) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    PostRecipeViewModel viewModel,
    Widget? child,
  ) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          // Header container with border radius
          Container(
            padding:
                const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
            decoration: const BoxDecoration(
              color: Colors.orange,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(12.0), // Curved bottom
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
                // Header Row
                const SizedBox(height: 35.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        // Profile Image
                        CircleAvatar(
                          radius: 22.0, // Smaller size
                          backgroundColor: Colors.grey.shade300,
                          backgroundImage: viewModel.profileImage.isNotEmpty
                              ? NetworkImage(viewModel.profileImage)
                              : null, // Display profile image if available
                          child: viewModel.profileImage.isEmpty
                              ? const Icon(
                                  Icons.person,
                                  size: 22.0,
                                  color: Colors.white,
                                )
                              : null, // Default placeholder
                        ),
                        const SizedBox(width: 12.0),
                        // Username and tagline
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              viewModel.username, // Username from ViewModel
                              style: const TextStyle(
                                fontSize: 17.0,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 1.0),
                            const Text(
                              'Discover recipes from other !', // Static tagline for now
                              style: TextStyle(
                                fontSize: 12.0,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    // Notification icon
                    Stack(
                      alignment: Alignment.topRight,
                      children: [
                        CircleAvatar(
                          radius: 17.0, // Reduced size of the CircleAvatar
                          backgroundColor: Colors.white,
                          child: IconButton(
                            onPressed: () {
                              // Add notification action here
                            },
                            icon: const Icon(
                              Icons.notifications,
                              color: Colors.orange,
                            ),
                            iconSize: 18.0, // Reduced size of the icon
                            padding: EdgeInsets
                                .zero, // Remove padding around the icon
                          ),
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
                        height: 35.0, // Reduced height
                        child: TextFormField(
                          decoration: InputDecoration(
                            prefixIcon: const Icon(
                              Icons.search,
                              color: Colors.orange,
                              size: 18.0, // Reduced icon size
                            ),
                            hintText: 'Search...',
                            hintStyle: const TextStyle(
                              color: Colors.grey,
                              fontSize: 13.0, // Reduced font size
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
                        ),
                      ),
                    ),
                    const SizedBox(
                        width:
                            6.0), // Reduced spacing between TextFormField and button
                    SizedBox(
                      height: 35.0, // Reduced button size
                      width: 35.0,
                      child: ElevatedButton(
                        onPressed: () {
                          // Add filter action here
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                                10.0), // Slightly smaller radius
                          ),
                          padding: EdgeInsets.zero,
                        ),
                        child: const Icon(
                          Icons.filter_list,
                          color: Colors.orange,
                          size: 18.0, // Reduced icon size
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 3.0),
              ],
            ),
          ),
          // Placeholder for the rest of the body
          const Expanded(
            child: Center(
              child: Text(
                'Post Recipes',
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  PostRecipeViewModel viewModelBuilder(BuildContext context) =>
      PostRecipeViewModel();
}
