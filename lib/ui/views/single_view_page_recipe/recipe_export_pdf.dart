import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/services.dart';
import 'package:food_ai_thesis/models/single_view_created_recipe/single_view_created_recipe.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:http/http.dart' as http;
import 'package:permission_handler/permission_handler.dart';

class RecipeExportPdf {
  static Future<File> generateRecipePDF(SingleDisplayRecipe recipe) async {
    final pdf = pw.Document();

    // Load the logo from assets
    final ByteData logoData = await rootBundle.load('lib/assets/logologo.png');
    final Uint8List logoBytes = logoData.buffer.asUint8List();
    final pw.MemoryImage logoImage = pw.MemoryImage(logoBytes);

    // Get recipe image if available
    Uint8List? recipeImageBytes;
    if (recipe.images.isNotEmpty) {
      try {
        final response = await http.get(Uri.parse(recipe.images.first));
        if (response.statusCode == 200) {
          recipeImageBytes = response.bodyBytes;
        }
      } catch (e) {
        print('Failed to load recipe image: $e');
      }
    }

    // Define styles for consistency
    final titleStyle =
        pw.TextStyle(fontSize: 24, fontWeight: pw.FontWeight.bold);
    final headerStyle =
        pw.TextStyle(fontSize: 16, fontWeight: pw.FontWeight.bold);
    final bodyStyle = const pw.TextStyle(fontSize: 12);
    final sectionSpacing = 16.0;
    const paragraphSpacing = 8.0;

    // First page with logo and FOOD AI text
    pdf.addPage(
      pw.Page(
        pageTheme: pw.PageTheme(
          margin: const pw.EdgeInsets.all(40),
          buildBackground: (pw.Context context) {
            return pw.Container(
              decoration: pw.BoxDecoration(
                border: pw.Border.all(color: PdfColors.grey300, width: 1),
              ),
              padding: const pw.EdgeInsets.all(20),
            );
          },
        ),
        build: (pw.Context context) {
          return pw.Center(
            child: pw.Column(
              mainAxisAlignment: pw.MainAxisAlignment.center,
              crossAxisAlignment: pw.CrossAxisAlignment.center,
              children: [
                pw.Image(logoImage, height: 150),
                pw.SizedBox(height: 30),
                pw.Text(
                  'FOOD AI',
                  style: pw.TextStyle(
                    fontSize: 40,
                    fontWeight: pw.FontWeight.bold,
                    color: PdfColors.black,
                  ),
                ),
                pw.SizedBox(height: 50),
                pw.Text(
                  recipe.foodName,
                  style: pw.TextStyle(
                      fontSize: 28, fontWeight: pw.FontWeight.bold),
                  textAlign: pw.TextAlign.center,
                ),
                pw.SizedBox(height: 20),
                if (recipeImageBytes != null)
                  pw.ClipRRect(
                    horizontalRadius: 8,
                    verticalRadius: 8,
                    child: pw.Container(
                      width: 300,
                      height: 200,
                      child: pw.Image(pw.MemoryImage(recipeImageBytes),
                          fit: pw.BoxFit.cover),
                    ),
                  ),
              ],
            ),
          );
        },
      ),
    );

    // Content pages
    pdf.addPage(
      pw.MultiPage(
        pageTheme: pw.PageTheme(
          margin: const pw.EdgeInsets.all(40),
          buildBackground: (pw.Context context) {
            return pw.Container(
              decoration: pw.BoxDecoration(
                border: pw.Border.all(color: PdfColors.grey300, width: 1),
              ),
              padding: const pw.EdgeInsets.all(20),
            );
          },
        ),
        footer: (pw.Context context) {
          return pw.Container(
            alignment: pw.Alignment.centerRight,
            margin: const pw.EdgeInsets.only(top: 10),
            child: pw.Text(
              'Page ${context.pageNumber} of ${context.pagesCount}',
              style: const pw.TextStyle(fontSize: 10, color: PdfColors.grey),
            ),
          );
        },
        build: (pw.Context context) => [
          // Recipe basic info section with styling
          pw.Container(
            padding: const pw.EdgeInsets.all(10),
            decoration: pw.BoxDecoration(
              color: PdfColors.grey100,
              borderRadius: pw.BorderRadius.circular(8),
            ),
            child: pw.Row(
              mainAxisAlignment: pw.MainAxisAlignment.spaceEvenly,
              children: [
                pw.Column(
                  children: [
                    pw.Text('Serving Size',
                        style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                    pw.Text('${recipe.servings}', style: bodyStyle),
                  ],
                ),
                pw.Column(
                  children: [
                    pw.Text('Cook Time',
                        style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                    pw.Text('${recipe.totalCookTime}', style: bodyStyle),
                  ],
                ),
                pw.Column(
                  children: [
                    pw.Text('Difficulty',
                        style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                    pw.Text('${recipe.difficulty}', style: bodyStyle),
                  ],
                ),
                pw.Column(
                  children: [
                    pw.Text('Category',
                        style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                    pw.Text('${recipe.category}', style: bodyStyle),
                  ],
                ),
              ],
            ),
          ),
          pw.SizedBox(height: sectionSpacing),

          // Description
          pw.Text("Description", style: headerStyle),
          pw.Divider(),
          pw.Text(recipe.description, style: bodyStyle),
          pw.SizedBox(height: sectionSpacing),

          // Ingredients section
          pw.Text("Ingredients", style: headerStyle),
          pw.Divider(),
          pw.SizedBox(height: paragraphSpacing),
          pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: recipe.ingredients
                .asMap()
                .entries
                .map((entry) => pw.Padding(
                      padding: const pw.EdgeInsets.only(bottom: 4),
                      child: pw.Row(
                        crossAxisAlignment: pw.CrossAxisAlignment.start,
                        children: [
                          pw.Container(
                            width: 5,
                            height: 5,
                            margin: const pw.EdgeInsets.only(top: 4, right: 5),
                            decoration: const pw.BoxDecoration(
                              color: PdfColors.black,
                              shape: pw.BoxShape.circle,
                            ),
                          ),
                          pw.Expanded(
                            child: pw.Text(
                                "${entry.value} - ${recipe.quantities[entry.key]}",
                                style: bodyStyle),
                          ),
                        ],
                      ),
                    ))
                .toList(),
          ),
          pw.SizedBox(height: sectionSpacing),

          // Instructions section
          pw.Text("Instructions", style: headerStyle),
          pw.Divider(),
          pw.SizedBox(height: paragraphSpacing),
          ...recipe.instructions.asMap().entries.map(
                (entry) => pw.Padding(
                  padding: const pw.EdgeInsets.only(bottom: 8),
                  child: pw.Row(
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    children: [
                      pw.Container(
                        width: 20,
                        child: pw.Text("${entry.key + 1}.",
                            style:
                                pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                      ),
                      pw.Expanded(
                        child: pw.Text(entry.value, style: bodyStyle),
                      ),
                    ],
                  ),
                ),
              ),
          pw.SizedBox(height: sectionSpacing),

          // Nutritional Info section
          if (recipe.nutritionalParagraph.isNotEmpty) ...[
            pw.Text("Nutritional Information", style: headerStyle),
            pw.Divider(),
            pw.SizedBox(height: paragraphSpacing),
            pw.Text(recipe.nutritionalParagraph, style: bodyStyle),
            pw.SizedBox(height: sectionSpacing),
          ],

          // Preparation Tips
          if (recipe.preparationTips.isNotEmpty) ...[
            pw.Text("Preparation Tips", style: headerStyle),
            pw.Divider(),
            pw.SizedBox(height: paragraphSpacing),
            pw.Container(
              padding: const pw.EdgeInsets.all(10),
              decoration: pw.BoxDecoration(
                border: pw.Border.all(color: PdfColors.grey300),
                borderRadius: pw.BorderRadius.circular(8),
              ),
              child: pw.Text(recipe.preparationTips, style: bodyStyle),
            ),
          ],
        ],
      ),
    );

    // Request storage permission (especially for Android 10 and below)
    final status = await Permission.manageExternalStorage.request();
    if (!status.isGranted) {
      throw Exception("Storage permission not granted");
    }

    // Save to Downloads directory
    Directory? downloadsDir;
    if (Platform.isAndroid) {
      downloadsDir = Directory('/storage/emulated/0/Download');
    } else if (Platform.isIOS) {
      downloadsDir =
          await getApplicationDocumentsDirectory(); // iOS doesn't allow access to Downloads
    }

    final file = File(
        '${downloadsDir!.path}/${recipe.foodName.replaceAll(RegExp(r'[<>:"/\\|?*]'), "_")}.pdf');
    await file.writeAsBytes(await pdf.save());

    return file;
  }
}
