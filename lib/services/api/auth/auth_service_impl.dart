import 'package:dio/dio.dart';
import 'package:food_ai_thesis/models/user/user_auth.dart';
import 'package:food_ai_thesis/services/api/auth/auth_api_service.dart';
import 'package:food_ai_thesis/services/api/helpers/dio_client.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthServiceImpl implements AuthApiService {
  AuthServiceImpl({Dio? dio}) : _dio = dio ?? DioClient().instance;

  final Dio _dio;

  static const String bearerTokenKey = 'bearerToken';

  @override
  Future<Response> registerUser(User user) async {
    try {
      final data = user.toJson();
      final response = await _dio.post('/auth/register', data: data);

      // Handle response
      if (response.statusCode == 201) {
        return response;
      } else {
        return Response(
          requestOptions: RequestOptions(path: ''),
          statusCode: response.statusCode,
          statusMessage: 'Failed to register user',
          data: response.data,
        );
      }
    } on DioException catch (e) {
      return e.response ??
          Response(
            requestOptions: RequestOptions(path: ''),
            statusCode: 500,
            statusMessage: 'Failed to register user',
            data: {'error': e.message},
          );
    } catch (e) {
      return Response(
        requestOptions: RequestOptions(path: ''),
        statusCode: 500,
        statusMessage: 'Unexpected error occurred',
        data: {'error': e.toString()},
      );
    }
  }

  @override
  Future<Response> loginUser(User user) async {
    try {
      final data = {
        'email': user.email,
        'password': user.password,
      };

      final response = await _dio.post('/auth/login', data: data);

      if (response.statusCode == 200) {
        // Save the Bearer token in SharedPreferences
        final token = response.data['token'];
        if (token == null || token is! String) {
          throw Exception('Invalid token in response');
        }

        final prefs = await SharedPreferences.getInstance();
        await prefs.setString(bearerTokenKey, token);

        print('Bearer Token saved: $token');
        return response;
      } else {
        return Response(
          requestOptions: RequestOptions(path: ''),
          statusCode: response.statusCode,
          statusMessage: 'Failed to log in user',
          data: response.data,
        );
      }
    } on DioException catch (e) {
      return e.response ??
          Response(
            requestOptions: RequestOptions(path: ''),
            statusCode: 500,
            statusMessage: 'Failed to log in user',
            data: {'error': e.message},
          );
    } catch (e) {
      return Response(
        requestOptions: RequestOptions(path: ''),
        statusCode: 500,
        statusMessage: 'Unexpected error occurred',
        data: {'error': e.toString()},
      );
    }
  }

  @override
  Future<Response> getCurrentUser() async {
    try {
      // Retrieve the token from SharedPreferences
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString(bearerTokenKey);

      if (token == null) {
        return Response(
          requestOptions: RequestOptions(path: ''),
          statusCode: 401,
          statusMessage: 'User not logged in. Token not found.',
          data: {'error': 'Token not found'},
        );
      }

      // Send GET request with the Bearer token
      final response = await _dio.get(
        '/auth/current-user',
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'accept': 'application/json',
          },
        ),
      );

      return response;
    } on DioException catch (e) {
      return e.response ??
          Response(
            requestOptions: RequestOptions(path: ''),
            statusCode: 500,
            statusMessage: 'Failed to retrieve current user',
            data: {'error': e.message},
          );
    } catch (e) {
      return Response(
        requestOptions: RequestOptions(path: ''),
        statusCode: 500,
        statusMessage: 'Unexpected error occurred',
        data: {'error': e.toString()},
      );
    }
  }

  @override
  Future<Response> logoutUser() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString(bearerTokenKey);

      if (token == null) {
        return Response(
          requestOptions: RequestOptions(path: ''),
          statusCode: 401,
          statusMessage: 'User not logged in. Token not found.',
          data: {'error': 'Token not found'},
        );
      }

      final response = await _dio.post(
        '/auth/logout',
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );

      if (response.statusCode == 200) {
        await prefs.remove(bearerTokenKey);
        print('Bearer Token removed.');
      }

      return response;
    } on DioException catch (e) {
      return e.response ??
          Response(
            requestOptions: RequestOptions(path: ''),
            statusCode: 500,
            statusMessage: 'Failed to log out user',
            data: {'error': e.message},
          );
    } catch (e) {
      return Response(
        requestOptions: RequestOptions(path: ''),
        statusCode: 500,
        statusMessage: 'Unexpected error occurred',
        data: {'error': e.toString()},
      );
    }
  }

@override
Future<bool> updateUserProfile(User user) async {
  try {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString(bearerTokenKey);

    if (token == null || token.isEmpty) {
      throw Exception('Unauthorized: No Bearer token found');
    }

   
    final formData = FormData.fromMap({
      'username': user.username,
   
      if (user.profileImage != null && !user.profileImage!.startsWith('http'))
        'profileImage': await MultipartFile.fromFile(
          user.profileImage!,
          filename: user.profileImage!.split('/').last,
        ),
    });

    // Perform the PUT request to update profile
    final response = await _dio.put(
      '/auth/update-profile',
      data: formData,
      options: Options(
        headers: {
          'Authorization': 'Bearer $token',
          'Accept': 'application/json',
          'Content-Type': 'multipart/form-data',
        },
      ),
    );

    if (response.statusCode == 200) {
      print('Profile updated successfully: ${response.data}');
      return true;
    } else {
      print('Failed to update profile: ${response.statusMessage}');
      return false;
    }
  } on DioException catch (e) {
   
    if (e.response?.statusCode == 401) {
      print('Unauthorized: Invalid or expired token');
    } else if (e.response != null) {
      print('Dio Error: ${e.response?.data}');
    } else {
      print('Dio Error: ${e.message}');
    }
    return false;
  } catch (e) {
 
    print('Unexpected Error: ${e.toString()}');
    return false;
  }
}

}
