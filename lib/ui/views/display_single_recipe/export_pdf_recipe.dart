import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/services.dart';
import 'package:food_ai_thesis/models/list_recipes/single_display_recipe.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:http/http.dart' as http;
import 'package:permission_handler/permission_handler.dart';

class PdfExportService {
  static Future<File> generateRecipePDF(FoodInfoById recipe) async {
    final pdf = pw.Document();

    Uint8List? imageBytes;
    if (recipe.images.isNotEmpty) {
      final response = await http.get(Uri.parse(recipe.images.first.imageUrl));
      if (response.statusCode == 200) {
        imageBytes = response.bodyBytes;
      }
    }

    pdf.addPage(
      pw.MultiPage(
        build: (pw.Context context) => [
          pw.Text(recipe.foodName,
              style:
                  pw.TextStyle(fontSize: 24, fontWeight: pw.FontWeight.bold)),
          pw.SizedBox(height: 10),
          if (imageBytes != null)
            pw.Center(child: pw.Image(pw.MemoryImage(imageBytes), height: 200)),
          pw.SizedBox(height: 16),
          pw.Text("Description:",
              style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
          pw.Text(recipe.description),
          pw.SizedBox(height: 12),
          pw.Text("Serving Size: ${recipe.servingSize}"),
          pw.Text("Cook Time: ${recipe.totalCookTime ?? 'N/A'}"),
          pw.Text("Difficulty: ${recipe.difficulty ?? 'N/A'}"),
          pw.Text("Category: ${recipe.category ?? 'N/A'}"),
          pw.SizedBox(height: 16),
          pw.Text("Ingredients:",
              style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
          ...recipe.ingredients
              .map((i) => pw.Bullet(text: "${i.quantity} ${i.name}"))
              .toList(),
          pw.SizedBox(height: 16),
          pw.Text("Instructions:",
              style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
          ...recipe.instructions.asMap().entries.map(
              (entry) => pw.Bullet(text: "${entry.key + 1}. ${entry.value}")),
          pw.SizedBox(height: 16),
          if (recipe.nutritionalParagraph != null)
            pw.Column(children: [
              pw.Text("Nutritional Info:",
                  style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
              pw.Text(recipe.nutritionalParagraph!),
              pw.SizedBox(height: 16),
            ]),
          if (recipe.nutritionalContent.isNotEmpty)
            pw.Column(children: [
              pw.Text("Nutrition Breakdown:",
                  style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
              ...recipe.nutritionalContent.map((e) => pw.Bullet(text: e))
            ]),
          if (recipe.preparationTips != null) ...[
            pw.SizedBox(height: 16),
            pw.Text("Preparation Tips:",
                style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
            pw.Text(recipe.preparationTips!),
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
          await getApplicationDocumentsDirectory(); // iOS doesn’t allow access to Downloads
    }

    final file = File('${downloadsDir!.path}/${recipe.foodName}.pdf');
    await file.writeAsBytes(await pdf.save());

    return file;
  }
}
