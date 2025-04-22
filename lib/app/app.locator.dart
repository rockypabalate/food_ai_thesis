// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// StackedLocatorGenerator
// **************************************************************************

// ignore_for_file: public_member_api_docs, implementation_imports, depend_on_referenced_packages

import 'package:stacked_services/src/bottom_sheet/bottom_sheet_service.dart';
import 'package:stacked_services/src/dialog/dialog_service.dart';
import 'package:stacked_services/src/navigation/navigation_service.dart';
import 'package:stacked_services/src/snackbar/snackbar_service.dart';
import 'package:stacked_shared/stacked_shared.dart';

import '../services/api/api_services/api_service_impl.dart';
import '../services/api/api_services/api_service_service.dart';
import '../services/api/auth/auth_api_service.dart';
import '../services/api/auth/auth_service_impl.dart';
import '../services/api/shared_preferences/shared_preference_impl.dart';
import '../services/api/shared_preferences/shared_preference_service.dart';
import '../services/feedback_service.dart';

final locator = StackedLocator.instance;

Future<void> setupLocator({
  String? environment,
  EnvironmentFilter? environmentFilter,
}) async {
// Register environments
  locator.registerEnvironment(
      environment: environment, environmentFilter: environmentFilter);

// Register dependencies
  locator.registerLazySingleton(() => BottomSheetService());
  locator.registerLazySingleton(() => DialogService());
  locator.registerLazySingleton(() => NavigationService());
  locator.registerLazySingleton(() => SnackbarService());
  locator.registerLazySingleton<ApiServiceService>(() => ApiServiceImpl());
  locator.registerLazySingleton<AuthApiService>(() => AuthServiceImpl());
  locator.registerLazySingleton<SharedPreferenceService>(
      () => SharedPreferenceServiceImpl());
  locator.registerLazySingleton(() => FeedbackService());
}
