abstract interface class SharedPreferenceService {
  Future<void> saveBearerToken(String token);
  Future<String?> getBearerToken();
  Future<void> removeBearerToken();
}
