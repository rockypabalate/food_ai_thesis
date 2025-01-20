import 'package:food_ai_thesis/services/api/shared_preferences/shared_preference_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferenceServiceImpl implements SharedPreferenceService {
  static const String bearerTokenKey = 'bearerToken';

  @override
  Future<void> saveBearerToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(bearerTokenKey, token);
  }

  @override
  Future<String?> getBearerToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(bearerTokenKey);
  }

  @override
  Future<void> removeBearerToken() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(bearerTokenKey);
  }
}
