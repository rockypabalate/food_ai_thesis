import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:stacked/stacked.dart';
import 'create_recipe_viewmodel.dart';

class CreateRecipeView extends StackedView<CreateRecipeViewModel> {
  const CreateRecipeView({Key? key}) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    CreateRecipeViewModel viewModel,
    Widget? child,
  ) {
    return WillPopScope(  
      onWillPop: () async {
        bool? exitConfirmed = await showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Exit Confirmation'),
              content: const Text('Are you sure you want to exit without saving?'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context, false); // Stay on the page
                  },
                  child: const Text('Cancel'),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pop(context, true); // Exit the page
                  },
                  child: const Text(
                    'Yes',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            );
          },
        );

        return exitConfirmed ?? false; // Prevent exit if null
      },
    child: Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          'Create Recipe',
          style: TextStyle(color: Colors.white), // Make title text white
        ),
        backgroundColor: Colors.orange,
        iconTheme:
            const IconThemeData(color: Colors.white), // Make back arrow white
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Food Name
            Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start, // Align text to the left
              children: [
                const Text(
                  'Food Name:',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 4), // Space between text and TextField
                TextField(
                  controller: viewModel.foodNameController,
                  style: const TextStyle(fontSize: 16),
                  decoration: const InputDecoration(
                    hintText: 'Enter food name',
                    hintStyle: TextStyle(color: Colors.grey),
                    border: UnderlineInputBorder(),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.orange, width: 1),
                    ),
                    isDense: true, // Reduce TextField height
                    contentPadding: EdgeInsets.symmetric(
                        vertical: 4), // Bring text closer to line
                  ),
                ),
              ],
            ),

            const SizedBox(height: 20),

            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Category:',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 4), // Space between text and TextField
                TextField(
                  controller: viewModel.categoryController,
                  style: const TextStyle(fontSize: 16),
                  decoration: const InputDecoration(
                    hintText: 'Enter category',
                    hintStyle: TextStyle(color: Colors.grey),
                    border: UnderlineInputBorder(),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.orange, width: 1),
                    ),
                    isDense: true, // Reduce TextField height
                    contentPadding: EdgeInsets.symmetric(
                        vertical: 4), // Bring text closer to line
                  ),
                ),
              ],
            ),

            const SizedBox(height: 25),

            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Total Serving:",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(left: 3), // Move Row to the right
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const Text(
                        "Serves",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                          width: 16), // Small space between text and counter
                      Row(
                        children: [
                          Container(
                            width: 20, // Reduced button size
                            height: 20,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.white, // White circular background
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black26, // Soft shadow
                                  blurRadius: 2,
                                  offset: Offset(1, 1),
                                )
                              ],
                            ),
                            child: IconButton(
                              padding: EdgeInsets.zero, // Remove extra padding
                              iconSize: 16, // Reduce icon size
                              icon: const Icon(Icons.remove,
                                  color: Colors.orange),
                              onPressed: () {
                                int current = int.tryParse(
                                        viewModel.servingsController.text) ??
                                    1;
                                if (current > 1) {
                                  viewModel.servingsController.text =
                                      (current - 1).toString();
                                }
                              },
                            ),
                          ),
                          const SizedBox(width: 6), // Adjusted spacing
                          SizedBox(
                            width: 30,
                            child: TextField(
                              controller: viewModel.servingsController,
                              textAlign: TextAlign.center,
                              keyboardType: TextInputType.number,
                              style: const TextStyle(
                                  fontSize: 14), // Adjust text size
                              decoration: const InputDecoration(
                                  border: InputBorder.none),
                            ),
                          ),
                          const SizedBox(width: 6),
                          Container(
                            width: 20, // Reduced button size
                            height: 20,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.white, // White circular background
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black26, // Soft shadow
                                  blurRadius: 2,
                                  offset: Offset(1, 1),
                                )
                              ],
                            ),
                            child: IconButton(
                              padding: EdgeInsets.zero, // Remove extra padding
                              iconSize: 16, // Reduce icon size
                              icon: const Icon(Icons.add, color: Colors.orange),
                              onPressed: () {
                                int current = int.tryParse(
                                        viewModel.servingsController.text) ??
                                    1;
                                viewModel.servingsController.text =
                                    (current + 1).toString();
                              },
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),

            const SizedBox(height: 10),

            // Total Cook Time (Row with Number Input & Dropdown)
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Total Cook Time:",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                    height: 6), // Small space between header and fields
                Row(
                  children: [
                    SizedBox(
                      width: 70,
                      child: TextFormField(
                          controller: viewModel.totalCookTimeController,
                          keyboardType: TextInputType.number,
                          style: const TextStyle(
                              fontSize: 14, height: 1), // Compact text
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.symmetric(
                                vertical: 8, horizontal: 8),
                            isDense: true, // Compact field height
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(6.0),
                              borderSide: const BorderSide(
                                  color: Colors.grey, width: 1), // Default grey
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(6.0),
                              borderSide: const BorderSide(
                                  color: Colors.orange,
                                  width: 2), // Orange when selected
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(6.0),
                              borderSide: const BorderSide(
                                  color: Colors.grey,
                                  width: 1), // Grey when not focused
                            ),
                            hintText: '0',
                            hintStyle: const TextStyle(fontSize: 14),
                          )),
                    ),
                    const SizedBox(
                        width:
                            16), // Small space between text field and dropdown
                    DropdownButton<String>(
                      value: viewModel.cookTimeUnit,
                      items: ["Minutes", "Hours"].map((String unit) {
                        return DropdownMenuItem<String>(
                          value: unit,
                          child: Text(unit),
                        );
                      }).toList(),
                      onChanged: (value) {
                        viewModel.updateCookTimeUnit(value!);
                      },
                    ),
                  ],
                ),
              ],
            ),

            const SizedBox(height: 20),
            // Description
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Recipe Description:", // Title Header
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                    height: 8), // Small space between title and input
                TextField(
                  controller: viewModel.descriptionController,
                  decoration: InputDecoration(
                    hintText: 'Enter a brief description...', // Hint text
                    labelStyle: const TextStyle(color: Colors.grey),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: const BorderSide(
                          color: Colors.grey,
                          width: 1.0), // Grey when not selected
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: const BorderSide(
                          color: Colors.orange,
                          width: 1.5), // Orange when selected
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: const BorderSide(
                          color: Colors.grey,
                          width: 1.0), // Grey when not selected
                    ),
                  ),
                  maxLines: 5,
                ),
              ],
            ),

            const SizedBox(height: 20),

            // Dynamic Instructions Input with Preparation Tips inside
            const Text(
              'Preparation:',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: viewModel.preparationTipsController,
              decoration: InputDecoration(
                hintText: 'Any tips for preparation...',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: const BorderSide(
                      color: Colors.grey, width: 1.0), // Grey when not selected
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: const BorderSide(
                      color: Colors.orange, width: 1.5), // Orange when selected
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: const BorderSide(
                      color: Colors.grey, width: 1.0), // Grey when not selected
                ),
              ),
              maxLines: 5,
            ),
            const SizedBox(height: 20),

            // List of Instructions with Dynamic Step Numbering and Spacing
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 10.0),
                  child: Text(
                    "Cooking Steps:",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: viewModel.instructions.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.only(
                          bottom: 10.0), // Add space below each field
                      child: Row(
                        children: [
                          Expanded(
                            child: TextFormField(
                              decoration: InputDecoration(
                                labelText: 'Step ${index + 1}',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                  borderSide: const BorderSide(
                                      color: Colors.grey,
                                      width: 1.0), // Grey when inactive
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                  borderSide: const BorderSide(
                                      color: Colors.orange,
                                      width: 1.5), // Orange when selected
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                  borderSide: const BorderSide(
                                      color: Colors.grey,
                                      width: 1.0), // Grey when inactive
                                ),
                              ),
                              onChanged: (value) =>
                                  viewModel.updateInstruction(index, value),
                            ),
                          ),
                          IconButton(
                            icon: const Icon(Icons.delete, color: Colors.red),
                            onPressed: () => viewModel.removeInstruction(index),
                          ),
                        ],
                      ),
                    );
                  },
                ),

                // Centered "Add Instruction" Button
                Center(
                  child: ElevatedButton.icon(
                    onPressed: viewModel.addInstruction,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orange,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                    icon: const Icon(Icons.add, color: Colors.white),
                    label: const Text(
                      'Add Instruction',
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 20),

            // Dynamic Ingredients Input
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 10.0),
                  child: Text(
                    "Ingredients:",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: viewModel.ingredients.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.only(
                          bottom: 10.0), // Adds space below each field
                      child: Row(
                        children: [
                          Expanded(
                            child: TextFormField(
                              decoration: InputDecoration(
                                labelText:
                                    'Ingredient ${index + 1}', // Dynamic numbering
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                  borderSide: const BorderSide(
                                      color: Colors.grey,
                                      width: 1.0), // Grey when inactive
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                  borderSide: const BorderSide(
                                      color: Colors.orange,
                                      width: 1.5), // Orange when selected
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                  borderSide: const BorderSide(
                                      color: Colors.grey,
                                      width: 1.0), // Grey when inactive
                                ),
                              ),
                              onChanged: (value) =>
                                  viewModel.updateIngredient(index, value),
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: TextFormField(
                              keyboardType:
                                  TextInputType.number, // Allows only numbers
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly
                              ], // Restricts input to digits
                              decoration: InputDecoration(
                                labelText: 'Quantity',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                  borderSide: const BorderSide(
                                      color: Colors.grey,
                                      width: 1.0), // Grey when inactive
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                  borderSide: const BorderSide(
                                      color: Colors.orange,
                                      width: 1.5), // Orange when selected
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                  borderSide: const BorderSide(
                                      color: Colors.grey,
                                      width: 1.0), // Grey when inactive
                                ),
                              ),
                              onChanged: (value) =>
                                  viewModel.updateQuantity(index, value),
                            ),
                          ),
                          IconButton(
                            icon: const Icon(Icons.delete, color: Colors.red),
                            onPressed: () => viewModel.removeIngredient(index),
                          ),
                        ],
                      ),
                    );
                  },
                ),

                // Centered "Add Ingredient" Button
                Center(
                  child: ElevatedButton.icon(
                    onPressed: viewModel.addIngredient,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orange,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                    icon: const Icon(Icons.add, color: Colors.white),
                    label: const Text(
                      'Add Ingredient',
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            // Nutritional Paragraph Input
            const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Nutritional Content:',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  '(Adding Nutritional Content is optional)',
                  style: TextStyle(
                    fontSize: 10,
                    fontStyle: FontStyle.italic,
                    fontWeight: FontWeight.normal, // Ensure it’s not bold
                  ),
                ),
              ],
            ),

            const SizedBox(height: 10),
            TextFormField(
              controller: viewModel.nutritionalParagraphController,
              decoration: InputDecoration(
                hintText: 'Enter Nutritional Information',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: const BorderSide(
                      color: Colors.grey, width: 1.0), // Grey when inactive
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: const BorderSide(
                      color: Colors.orange, width: 1), // Orange when selected
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: const BorderSide(
                      color: Colors.grey, width: 1.0), // Grey when inactive
                ),
              ),

              maxLines: 5, // Allows multi-line input
            ),

            const SizedBox(height: 20),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Text('Confirmation'),
                        content: const Text(
                            'Are you sure you want to create this recipe?'),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context); // Cancel
                            },
                            child: const Text('Cancel'),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context); // Close dialog
                              viewModel.createRecipe(); // Call the method
                            },
                            child: const Text(
                              'Yes',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      );
                    },
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
                child: const Text(
                  'Create Recipe',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    )
    );
      

  }

  @override
  CreateRecipeViewModel viewModelBuilder(BuildContext context) =>
      CreateRecipeViewModel();
}
