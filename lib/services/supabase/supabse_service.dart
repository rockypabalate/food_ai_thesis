import 'package:food_ai_thesis/main.dart';

class SupabaseService {
  static Future<String?> submitFeedback({
    required String username,
    required String email,
    required int rating,
    required String feedback,
  }) async {
    try {
      final response = await supabase.from('feedback').insert({
        'username': username,
        'email': email,
        'ratings': rating,
        'feedback': feedback,
      }).select();

      if (response.isNotEmpty) {
        return null; 
      } else {
        return 'Failed to submit feedback.';
      }
    } catch (e) {
      return 'Unexpected error: $e';
    }
  }
}
