import 'package:flutter/material.dart';
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
    return Scaffold(
      backgroundColor: Colors.orange.shade50,
      appBar: AppBar(
        title: const Text('Create Recipe'),
        backgroundColor: Colors.orange,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Food Name
            TextField(
              controller: viewModel.foodNameController,
              decoration: InputDecoration(
                labelText: 'Food Name',
                border: OutlineInputBorder(
                  // Adds a border
                  borderRadius: BorderRadius.circular(10.0), // Rounded corners
                  borderSide: const BorderSide(
                      color: Colors.orange,
                      width: 2.0), // Border color & thickness
                ),
                focusedBorder: OutlineInputBorder(
                  // Border when focused
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide:
                      const BorderSide(color: Colors.deepOrange, width: 2.5),
                ),
                enabledBorder: OutlineInputBorder(
                  // Border when not focused
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide:
                      const BorderSide(color: Colors.orange, width: 2.0),
                ),
              ),
            ),

            const SizedBox(height: 10),
            // Description
            TextField(
              controller: viewModel.descriptionController,
              decoration: InputDecoration(
                labelText: 'Description',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide:
                      const BorderSide(color: Colors.orange, width: 2.0),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide:
                      const BorderSide(color: Colors.deepOrange, width: 2.5),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide:
                      const BorderSide(color: Colors.orange, width: 2.0),
                ),
              ),
              maxLines: 3,
            ),
            const SizedBox(height: 10),

            // Servings Counter
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("Serves",
                    style:
                        TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.remove, color: Colors.orange),
                      onPressed: () {
                        int current =
                            int.tryParse(viewModel.servingsController.text) ??
                                1;
                        if (current > 1) {
                          viewModel.servingsController.text =
                              (current - 1).toString();
                        }
                      },
                    ),
                    SizedBox(
                      width: 40,
                      child: TextField(
                        controller: viewModel.servingsController,
                        textAlign: TextAlign.center,
                        keyboardType: TextInputType.number,
                        decoration:
                            const InputDecoration(border: InputBorder.none),
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.add, color: Colors.orange),
                      onPressed: () {
                        int current =
                            int.tryParse(viewModel.servingsController.text) ??
                                1;
                        viewModel.servingsController.text =
                            (current + 1).toString();
                      },
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 10),

            // Total Cook Time (Row with Number Input & Dropdown)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Total Cook Time",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  width: 70,
                  child: TextFormField(
                    controller: viewModel.totalCookTimeController,
                    keyboardType: TextInputType.number,
                    style: const TextStyle(
                        fontSize: 14, height: 1), // Reduced line height
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 8,
                          horizontal: 8), // Further minimized height
                      isDense: true, // Ensures a compact design
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(
                            6.0), // Slightly smaller radius
                        borderSide:
                            const BorderSide(color: Colors.orange, width: 2.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(6.0),
                        borderSide: const BorderSide(
                            color: Colors.deepOrange, width: 2.5),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(6.0),
                        borderSide:
                            const BorderSide(color: Colors.orange, width: 2.0),
                      ),
                      hintText: '0',
                      hintStyle: const TextStyle(fontSize: 14),
                    ),
                  ),
                ),
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
            const SizedBox(height: 10),

            // Category
            TextField(
              controller: viewModel.categoryController,
              decoration: InputDecoration(
                labelText: 'Category',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide:
                      const BorderSide(color: Colors.orange, width: 2.0),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide:
                      const BorderSide(color: Colors.deepOrange, width: 2.5),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide:
                      const BorderSide(color: Colors.orange, width: 2.0),
                ),
              ),
            ),
            const SizedBox(height: 20),

// Preparation Tips (Moved above instructions)

            // Dynamic Instructions Input with Preparation Tips inside
            const Text(
              'Preparation:',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 15),

// Preparation Tips inside the Preparation Section
            // Preparation Tips inside the Preparation Section
            TextField(
              controller: viewModel.preparationTipsController,
              decoration: InputDecoration(
                labelText: 'Enter Preparation Tips',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide:
                      const BorderSide(color: Colors.orange, width: 2.0),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide:
                      const BorderSide(color: Colors.deepOrange, width: 2.5),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide:
                      const BorderSide(color: Colors.orange, width: 2.0),
                ),
              ),
              maxLines: 2,
            ),
            const SizedBox(height: 20),

// List of Instructions
            // List of Instructions with Dynamic Step Numbering and Spacing
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
                                  color: Colors.orange, width: 2.0),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: const BorderSide(
                                  color: Colors.deepOrange, width: 2.5),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: const BorderSide(
                                  color: Colors.orange, width: 2.0),
                            ),
                          ),
                          onChanged: (value) =>
                              viewModel.updateInstruction(index, value),
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () => viewModel.removeInstruction(index),
                      ),
                    ],
                  ),
                );
              },
            ),

// Centered "Add Instruction" Button
            Center(
              child: ElevatedButton(
                onPressed: viewModel.addInstruction,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
                child: const Text(
                  'Add Instruction',
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Dynamic Ingredients Input
            const Text(
              'Ingredients:',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
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
                                  color: Colors.orange, width: 2.0),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: const BorderSide(
                                  color: Colors.deepOrange, width: 2.5),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: const BorderSide(
                                  color: Colors.orange, width: 2.0),
                            ),
                          ),
                          onChanged: (value) =>
                              viewModel.updateIngredient(index, value),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: TextFormField(
                          decoration: InputDecoration(
                            labelText: 'Quantity',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: const BorderSide(
                                  color: Colors.orange, width: 2.0),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: const BorderSide(
                                  color: Colors.deepOrange, width: 2.5),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: const BorderSide(
                                  color: Colors.orange, width: 2.0),
                            ),
                          ),
                          onChanged: (value) =>
                              viewModel.updateQuantity(index, value),
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () => viewModel.removeIngredient(index),
                      ),
                    ],
                  ),
                );
              },
            ),

            Center(
              child: ElevatedButton(
                onPressed: viewModel.addIngredient,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
                child: const Text(
                  'Add Ingredient',
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            const SizedBox(height: 20),
            // Nutritional Paragraph Input
            const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Nutritional Content:',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 15),
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
                labelText: 'Enter Nutritional Information',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide:
                      const BorderSide(color: Colors.orange, width: 2.0),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide:
                      const BorderSide(color: Colors.deepOrange, width: 2.5),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide:
                      const BorderSide(color: Colors.orange, width: 2.0),
                ),
              ),
              maxLines: 3, // Allows multi-line input
            ),

            const SizedBox(height: 20),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: viewModel.nutritionalContent.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 10.0),
                  child: Row(
                    children: [
                      // Nutrient Name Field
                      Expanded(
                        child: TextFormField(
                          initialValue:
                              viewModel.nutritionalContent[index].name,
                          decoration: InputDecoration(
                            labelText: 'Nutrient Name',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: const BorderSide(
                                  color: Colors.orange, width: 2.0),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: const BorderSide(
                                  color: Colors.deepOrange, width: 2.5),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: const BorderSide(
                                  color: Colors.orange, width: 2.0),
                            ),
                          ),
                          onChanged: (value) =>
                              viewModel.updateNutritionalContent(
                            index,
                            value, // Updating the name
                            viewModel.nutritionalContent[index].amount,
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),

                      // Nutrient Amount Field
                      Expanded(
                        child: TextFormField(
                          initialValue:
                              viewModel.nutritionalContent[index].amount,
                          decoration: InputDecoration(
                            labelText: 'Amount',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: const BorderSide(
                                  color: Colors.orange, width: 2.0),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: const BorderSide(
                                  color: Colors.deepOrange, width: 2.5),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: const BorderSide(
                                  color: Colors.orange, width: 2.0),
                            ),
                          ),
                          onChanged: (value) =>
                              viewModel.updateNutritionalContent(
                            index,
                            viewModel.nutritionalContent[index].name,
                            value, // Updating the amount
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),

                      // Delete Button
                      IconButton(
                        icon: const Icon(Icons.delete, color: Colors.red),
                        onPressed: () =>
                            viewModel.removeNutritionalContent(index),
                      ),
                    ],
                  ),
                );
              },
            ),

// Centered "Add Nutritional Content" Button
            Center(
              child: ElevatedButton(
                onPressed: viewModel.addNutritionalContent,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
                child: const Text(
                  'Add Nutritional Content',
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ),
            ),

            const SizedBox(height: 40),

            // Submit Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  viewModel.createRecipe(); // ✅ Just call the method
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
            ),
          ],
        ),
      ),
    );
  }

  @override
  CreateRecipeViewModel viewModelBuilder(BuildContext context) =>
      CreateRecipeViewModel();
}
