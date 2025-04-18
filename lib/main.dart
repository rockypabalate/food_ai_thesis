import 'package:flutter/material.dart';
import 'package:food_ai_thesis/app/app.bottomsheets.dart';
import 'package:food_ai_thesis/app/app.dialogs.dart';
import 'package:food_ai_thesis/app/app.locator.dart';
import 'package:food_ai_thesis/app/app.router.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:supabase_flutter/supabase_flutter.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Supabase initialization
  await Supabase.initialize(
    url: 'https://urxwcymmfxfularsadfe.supabase.co',
    anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InVyeHdjeW1tZnhmdWxhcnNhZGZlIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NDQxMTAyMjQsImV4cCI6MjA1OTY4NjIyNH0.b0vNR-gXLz6LUI3GY0phniLvrmGPyvlRoVlGTIpGyJs',
  );

  await setupLocator();
  setupDialogUi();
  setupBottomSheetUi();

  runApp(const MainApp());
}

// Global Supabase client
final supabase = Supabase.instance.client;

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    final snackbarService = locator<SnackbarService>();

    snackbarService.registerSnackbarConfig(
      SnackbarConfig(
        backgroundColor: const Color.fromARGB(255, 96, 95, 95),
        borderRadius: 10,
        snackPosition: SnackPosition.BOTTOM,
        textColor: const Color.fromARGB(255, 255, 255, 255),
        margin: const EdgeInsets.all(10),
        dismissDirection: DismissDirection.horizontal,
        padding: const EdgeInsets.fromLTRB(16, 10, 0, 16),
      ),
    );

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      onGenerateRoute: StackedRouter().onGenerateRoute,
      navigatorKey: StackedService.navigatorKey,
      navigatorObservers: [
        StackedService.routeObserver,
      ],
    );
  }
}
