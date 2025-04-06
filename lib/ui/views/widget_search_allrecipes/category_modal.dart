import 'package:flutter/material.dart';

Future<void> showCategoryFilterModal({
  required BuildContext context,
  required List<String> categories,
  required String? selectedCategory,
  required Function(String) onCategorySelected,
  required VoidCallback onClearFilter,
}) {
  return showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.orange.shade100, // Lighter orange background
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
    ),
    builder: (BuildContext context) {
      return SafeArea(
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxHeight: MediaQuery.of(context).size.height * 0.5,
          ),
          child: Column(
            children: [
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 12.0),
                child: Text(
                  'Select Category',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.orange, // Light orange text for the header
                  ),
                ),
              ),
              ListTile(
                title: const Text(
                  'Clear Filter',
                  style: TextStyle(
                      color:
                          Colors.orange), // Light orange text for Clear Filter
                ),
                leading: const Icon(
                  Icons.clear,
                  color: Colors.orange, // Light orange icon for Clear Filter
                ),
                onTap: () {
                  onClearFilter();
                  Navigator.pop(context);
                },
              ),
              const Divider(color: Colors.orange), // Light orange divider
              // Make sure the highlighted category starts below the Clear Filter and Divider
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.only(
                      top: 0), // Remove any extra space above
                  itemCount: categories.length,
                  itemBuilder: (context, index) {
                    final category = categories[index];
                    final isSelected = category == selectedCategory;

                    return ListTile(
                      leading: Icon(
                        Icons.restaurant,
                        color: isSelected
                            ? Colors.orange
                            : Colors.grey, // Light grey for unselected icons
                      ),
                      title: Text(
                        category,
                        style: TextStyle(
                          color: isSelected
                              ? Colors.orange // Bold and orange for selected
                              : Colors.black.withOpacity(
                                  0.6), // Light black text for unselected
                          fontWeight: isSelected
                              ? FontWeight.bold // Bold for selected
                              : FontWeight.normal, // Normal for unselected
                        ),
                      ),
                      trailing: isSelected
                          ? const Icon(Icons.check,
                              color: Colors
                                  .orange) // Orange checkmark for selected
                          : null,
                      onTap: () {
                        onCategorySelected(category);
                        Navigator.pop(context);
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}
