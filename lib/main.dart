import 'package:flutter/material.dart';
import 'package:food_ai_thesis/app/app.bottomsheets.dart';
import 'package:food_ai_thesis/app/app.dialogs.dart';
import 'package:food_ai_thesis/app/app.locator.dart';
import 'package:food_ai_thesis/app/app.router.dart';
import 'package:stacked_services/stacked_services.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setupLocator();
  setupDialogUi();
  setupBottomSheetUi();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    final snackbarService = locator<SnackbarService>();

    snackbarService.registerSnackbarConfig(
      SnackbarConfig(
        backgroundColor: Color.fromARGB(255, 96, 95, 95),
        borderRadius: 10,
        snackPosition: SnackPosition.BOTTOM,
        textColor: const Color.fromARGB(255, 255, 255, 255),
        margin: const EdgeInsets.all(10),
        dismissDirection: DismissDirection.horizontal,
        padding: const EdgeInsets.fromLTRB(16, 10, 0, 16),
      ),
    );

    return MaterialApp(
      // initialRoute: Routes.startupView,
      debugShowCheckedModeBanner: false,
      onGenerateRoute: StackedRouter().onGenerateRoute,
      navigatorKey: StackedService.navigatorKey,
      navigatorObservers: [
        StackedService.routeObserver,
      ],
    );
  }
}
