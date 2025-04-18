import 'package:flutter/material.dart';
import 'package:food_ai_thesis/models/list_recipes/single_display_recipe.dart';
import 'package:food_ai_thesis/ui/views/display_single_recipe/export_pdf_recipe.dart';

class PdfExportPage extends StatefulWidget {
  final FoodInfoById recipe;

  const PdfExportPage({super.key, required this.recipe});

  @override
  State<PdfExportPage> createState() => _PdfExportPageState();
}

class _PdfExportPageState extends State<PdfExportPage> {
  bool _isGenerating = false;
  String? _filePath;

  Future<void> _generatePdf() async {
    setState(() => _isGenerating = true);

    final file = await PdfExportService.generateRecipePDF(widget.recipe);

    setState(() {
      _filePath = file.path;
      _isGenerating = false;
    });
  }

  @override
  void initState() {
    super.initState();
    _generatePdf(); // auto-generate on open
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Recipe PDF')),
      body: Center(
        child: _isGenerating
            ? const CircularProgressIndicator()
            : _filePath != null
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.check_circle,
                          color: Colors.green, size: 60),
                      const SizedBox(height: 20),
                      const Text("PDF saved at:",
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Text(_filePath!, textAlign: TextAlign.center),
                      ),
                    ],
                  )
                : const Text("Failed to generate PDF"),
      ),
    );
  }
}
