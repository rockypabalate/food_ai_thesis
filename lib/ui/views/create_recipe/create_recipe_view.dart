import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
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
        return await _showExitConfirmation(context) ?? false;
      },
      child: Scaffold(
        backgroundColor: Colors.grey[50],
        appBar: AppBar(
          title: const Text(
            'Create Recipe',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w600,
            ),
          ),
          backgroundColor: Colors.orange[600],
          elevation: 0,
          iconTheme: const IconThemeData(color: Colors.white),
        ),
        body: viewModel.isLoading
            ? _buildLoadingIndicator()
            : _buildFormContent(context, viewModel),
        bottomNavigationBar: _buildBottomButton(context, viewModel),
      ),
    );
  }

  Future<bool?> _showExitConfirmation(BuildContext context) {
    return showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          title: const Row(
            children: [
              Icon(Icons.warning_amber_rounded, color: Colors.orange, size: 28),
              SizedBox(width: 8),
              Text(
                'Exit Confirmation',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ],
          ),
          content: const Text('Are you sure you want to exit without saving?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context, false),
              child: const Text(
                'Cancel',
                style: TextStyle(fontSize: 16, color: Colors.black),
              ),
            ),
            GestureDetector(
              onTap: () => Navigator.pop(context, true),
              child: const Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.exit_to_app, color: Colors.orange),
                  SizedBox(width: 4),
                  Text(
                    'Exit',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.orange,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildLoadingIndicator() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SpinKitPulse(
            color: Colors.orange[600],
            size: 50.0,
          ),
          const SizedBox(height: 20),
          Text(
            'Creating Recipe...',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
              color: Colors.orange[700],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFormContent(
      BuildContext context, CreateRecipeViewModel viewModel) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildFormCard(
            context,
            title: 'Recipe Details',
            children: [
              _buildTextField(
                label: 'Food Name',
                hint: 'Enter food name',
                controller: viewModel.foodNameController,
                isRequired: true,
              ),
              const SizedBox(height: 16),
              _buildTextField(
                label: 'Category',
                hint: 'Enter category (e.g., Breakfast, Dinner)',
                controller: viewModel.categoryController,
              ),
              const SizedBox(height: 16),
              _buildServingCounter(viewModel),
              const SizedBox(height: 16),
              _buildTextField(
                label: 'Total Cook Time',
                hint: 'E.g., 45 minutes',
                controller: viewModel.totalCookTimeController,
              ),
              const SizedBox(height: 16),
              _buildDifficultyDropdown(viewModel),
            ],
          ),
          const SizedBox(height: 16),
          _buildFormCard(
            context,
            title: 'Description',
            children: [
              _buildMultilineTextField(
                hint: 'Write a brief description of your recipe...',
                controller: viewModel.descriptionController,
                maxLines: 4,
              ),
            ],
          ),
          const SizedBox(height: 16),
          _buildFormCard(
            context,
            title: 'Preparation Tips',
            children: [
              _buildMultilineTextField(
                hint: 'Any preparation tips to share...',
                controller: viewModel.preparationTipsController,
                maxLines: 4,
              ),
            ],
          ),
          const SizedBox(height: 16),
          _buildFormCard(
            context,
            title: 'Ingredients',
            children: [
              _buildIngredientsList(viewModel),
              const SizedBox(height: 16),
              _buildAddButton(
                label: 'Add Ingredient',
                onPressed: viewModel.addIngredient,
              ),
            ],
          ),
          const SizedBox(height: 16),
          _buildFormCard(
            context,
            title: 'Cooking Steps',
            children: [
              _buildInstructionsList(viewModel),
              const SizedBox(height: 16),
              _buildAddButton(
                label: 'Add Step',
                onPressed: viewModel.addInstruction,
              ),
            ],
          ),
          const SizedBox(height: 16),
          _buildFormCard(
            context,
            title: 'Nutritional Content',
            isOptional: true,
            children: [
              _buildMultilineTextField(
                hint: 'Enter nutritional information (optional)',
                controller: viewModel.nutritionalParagraphController,
                maxLines: 4,
              ),
            ],
          ),
          const SizedBox(height: 30),
        ],
      ),
    );
  }

  Widget _buildFormCard(
    BuildContext context, {
    required String title,
    required List<Widget> children,
    bool isOptional = false,
  }) {
    return Card(
      elevation: 6, // Increased for a deeper shadow
      shadowColor: Colors.black38, // Slightly darker shadow
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                if (isOptional) ...[
                  const SizedBox(width: 8),
                  Text(
                    '(Optional)',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[600],
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ],
              ],
            ),
            const Divider(height: 24),
            ...children,
          ],
        ),
      ),
    );
  }

  Widget _buildTextField({
    required String label,
    required String hint,
    required TextEditingController controller,
    bool isRequired = false,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              label,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Colors.grey[800],
              ),
            ),
            if (isRequired) ...[
              const SizedBox(width: 4),
              Text(
                '*',
                style: TextStyle(
                  color: Colors.red[700],
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ],
        ),
        const SizedBox(height: 8),
        TextField(
          controller: controller,
          style: const TextStyle(fontSize: 16),
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: TextStyle(color: Colors.grey[400]),
            filled: false, // No fill color
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(
                color: Colors.black, // Black border
                width: .5,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(
                color: Colors.black,
                width: .5,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(
                color: Colors.black,
                width: .5,
              ),
            ),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 14,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildMultilineTextField({
    required String hint,
    required TextEditingController controller,
    int maxLines = 3,
  }) {
    return TextField(
      controller: controller,
      maxLines: maxLines,
      style: const TextStyle(fontSize: 16),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: TextStyle(color: Colors.grey[400]),
        filled: false, // No background color
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(
            color: Colors.black, // Black border
            width: .5,
          ),
        ),
        contentPadding: const EdgeInsets.all(16),
      ),
    );
  }

  Widget _buildServingCounter(CreateRecipeViewModel viewModel) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Servings',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: Colors.grey[800],
          ),
        ),
        const SizedBox(height: 8),
        Container(
          height: 36,
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            color: Colors.grey[100],
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildCompactCircleButton(
                icon: Icons.remove,
                onPressed: () {
                  int current =
                      int.tryParse(viewModel.servingsController.text) ?? 1;
                  if (current > 1) {
                    viewModel.servingsController.text =
                        (current - 1).toString();
                  }
                },
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 8),
                width: 28,
                height: 28, // Ensure it's the same height as the button
                alignment: Alignment.center, // Center the child inside
                child: TextField(
                  controller: viewModel.servingsController,
                  textAlign: TextAlign.center,
                  keyboardType: TextInputType.number,
                  style: const TextStyle(fontSize: 14),
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    isCollapsed: true, // Removes extra vertical padding
                    contentPadding: EdgeInsets.zero,
                  ),
                ),
              ),
              _buildCompactCircleButton(
                icon: Icons.add,
                onPressed: () {
                  int current =
                      int.tryParse(viewModel.servingsController.text) ?? 1;
                  viewModel.servingsController.text = (current + 1).toString();
                },
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildCompactCircleButton(
      {required IconData icon, required VoidCallback onPressed}) {
    return Container(
      width: 24,
      height: 24,
      decoration: const BoxDecoration(
        color: Colors.orange,
        shape: BoxShape.circle,
      ),
      child: IconButton(
        icon: Icon(icon, color: Colors.white, size: 12),
        onPressed: onPressed,
        padding: EdgeInsets.zero,
        constraints: const BoxConstraints(),
      ),
    );
  }

  Widget _buildDifficultyDropdown(CreateRecipeViewModel viewModel) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Difficulty',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: Colors.grey[800],
          ),
        ),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
            color: Colors.grey[100],
            borderRadius: BorderRadius.circular(12),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: viewModel.difficultyLevel,
              isExpanded: true,
              icon: Icon(Icons.arrow_drop_down, color: Colors.orange[700]),
              items: ["Easy", "Medium", "Hard"].map((String level) {
                return DropdownMenuItem<String>(
                  value: level,
                  child: Text(level),
                );
              }).toList(),
              onChanged: (value) {
                viewModel.updateDifficultyLevel(value!);
              },
              style: const TextStyle(
                fontSize: 16,
                color: Colors.black87,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildIngredientsList(CreateRecipeViewModel viewModel) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: viewModel.ingredients.length,
      itemBuilder: (context, index) {
        return Container(
          margin: const EdgeInsets.only(bottom: 16),
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.orange[50],
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.orange[100]!),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      'Ingredient ${index + 1}',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.delete_outline, color: Colors.red[400]),
                    onPressed: () => viewModel.removeIngredient(index),
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              TextField(
                controller: viewModel.ingredientControllers[index],
                decoration: InputDecoration(
                  hintText: 'Ingredient name',
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide.none,
                  ),
                ),
                onChanged: (value) => viewModel.updateIngredient(index, value),
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: TextEditingController(
                          text: viewModel.quantities[index]),
                      keyboardType: TextInputType.number,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      decoration: InputDecoration(
                        hintText: 'Quantity',
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide.none,
                        ),
                      ),
                      onChanged: (value) =>
                          viewModel.updateQuantity(index, value),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: TextField(
                      controller:
                          TextEditingController(text: viewModel.units[index]),
                      decoration: InputDecoration(
                        hintText: 'Unit',
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide.none,
                        ),
                      ),
                      onChanged: (value) => viewModel.updateUnit(index, value),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildInstructionsList(CreateRecipeViewModel viewModel) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: viewModel.instructions.length,
      itemBuilder: (context, index) {
        return Container(
          margin: const EdgeInsets.only(bottom: 12),
          decoration: BoxDecoration(
            color: Colors.grey[100],
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.orange[600],
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(12),
                    bottomLeft: Radius.circular(12),
                  ),
                ),
                child: Text(
                  '${index + 1}',
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Expanded(
                child: TextField(
                  maxLines: null,
                  decoration: const InputDecoration(
                    hintText: 'Describe this step',
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.all(12),
                  ),
                  onChanged: (value) =>
                      viewModel.updateInstruction(index, value),
                ),
              ),
              IconButton(
                icon: Icon(Icons.delete_outline, color: Colors.red[400]),
                onPressed: () => viewModel.removeInstruction(index),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildAddButton(
      {required String label, required VoidCallback onPressed}) {
    return Center(
      child: ElevatedButton.icon(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.orange,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        icon: const Icon(
          Icons.add,
          color: Colors.white,
        ),
        label: Text(label),
      ),
    );
  }

  Widget _buildBottomButton(
      BuildContext context, CreateRecipeViewModel viewModel) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            offset: const Offset(0, -2),
            blurRadius: 8,
          ),
        ],
      ),
      child: SafeArea(
        child: ElevatedButton(
          onPressed: () => _showCreateConfirmation(context, viewModel),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.orange[600],
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(vertical: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            elevation: 0,
          ),
          child: const Text(
            'Create Recipe',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }

  void _showCreateConfirmation(
      BuildContext context, CreateRecipeViewModel viewModel) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          title: const Row(
            children: [
              Icon(Icons.add_circle_outline, color: Colors.orange, size: 28),
              SizedBox(width: 8),
              Text(
                'Create Recipe',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ],
          ),
          content: const Text('Are you sure you want to create this recipe?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text(
                'Cancel',
                style: TextStyle(fontSize: 16),
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
                viewModel.setLoading(true);
                viewModel.createRecipe().then((_) {
                  viewModel.setLoading(false);
                });
              },
              child: const Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.check_circle_outline, color: Colors.orange),
                  SizedBox(width: 4),
                  Text(
                    'Create',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.orange,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  CreateRecipeViewModel viewModelBuilder(BuildContext context) =>
      CreateRecipeViewModel();
}
