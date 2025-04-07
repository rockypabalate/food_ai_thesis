import 'dart:io';
import 'package:flutter/material.dart';
import 'package:food_ai_thesis/models/single_view_created_recipe/single_view_created_recipe.dart';
import 'package:food_ai_thesis/ui/views/single_view_page_recipe/recipe_export_pdf.dart';

class CreatePdfExportPage extends StatefulWidget {
  final SingleDisplayRecipe recipe;

  const CreatePdfExportPage({super.key, required this.recipe});

  @override
  _CreatePdfExportPage createState() => _CreatePdfExportPage();
}

class _CreatePdfExportPage extends State<CreatePdfExportPage> {
  bool _isGenerating = false;
  String? _filePath;

  // Method to trigger PDF generation
  Future<void> _generatePdf() async {
    setState(() {
      _isGenerating = true;
    });

    try {
      // Generate the PDF
      final file = await RecipeExportPdf.generateRecipePDF(widget.recipe);

      setState(() {
        _filePath = file.path; // Save the file path
        _isGenerating = false; // Update generating status
      });
    } catch (e) {
      setState(() {
        _isGenerating = false; // Update generating status on error
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _generatePdf(); // Optionally generate PDF when page is opened
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Export Recipe as PDF'),
      ),
      body: Center(
        child: _isGenerating
            ? const CircularProgressIndicator() // Show loading spinner while generating PDF
            : _filePath != null
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.check_circle,
                          color: Colors.green, size: 60),
                      const SizedBox(height: 20),
                      const Text(
                        "PDF saved at:",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Text(
                          _filePath!,
                          textAlign: TextAlign.center,
                          style: const TextStyle(fontSize: 14),
                        ),
                      ),
                    ],
                  )
                : const Text("Failed to generate PDF"),
      ),
    );
  }
}
