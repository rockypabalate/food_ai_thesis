import 'package:dio/dio.dart';
import 'package:food_ai_thesis/models/user/user_auth.dart';

abstract interface class AuthApiService {
  Future<Response> registerUser(User user);
  Future<Response> loginUser(User user);
  Future<Response> getCurrentUser();
  Future<Response> logoutUser();
  Future<bool> updateUserProfile(User user);
}
