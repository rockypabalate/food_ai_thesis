import 'package:flutter_test/flutter_test.dart';
import 'package:food_ai_thesis/app/app.locator.dart';

import '../helpers/test_helpers.dart';

void main() {
  group('DisplaySingleRecipeViewModel Tests -', () {
    setUp(() => registerServices());
    tearDown(() => locator.reset());
  });
}
