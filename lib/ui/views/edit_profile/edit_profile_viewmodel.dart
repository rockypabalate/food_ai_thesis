import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:food_ai_thesis/app/app.locator.dart';
import 'package:food_ai_thesis/app/app_base_viewmodel.dart';
import 'package:food_ai_thesis/models/user/user_auth.dart';
import 'package:food_ai_thesis/services/api/auth/auth_api_service.dart';
import 'package:image_picker/image_picker.dart';
import 'package:stacked_services/stacked_services.dart';

class EditProfileViewModel extends AppBaseViewModel {
  final AuthApiService _authApiService = locator<AuthApiService>();
  final SnackbarService _snackbarService = locator<SnackbarService>();
  final ImagePicker _imagePicker = ImagePicker();

  User? user;
  File? profileImage;

  // TextEditingController for editable fields
  final usernameController = TextEditingController();

  Future<void> getCurrentUser() async {
    setBusy(true);
    try {
      Response response = await _authApiService.getCurrentUser();
      if (response.statusCode == 200 && response.data['user'] != null) {
        user = User.fromJson(response.data['user']);

        // Initialize controllers with user data
        usernameController.text = user?.username ?? '';
      } else {
        _snackbarService.showSnackbar(message: 'Failed to load user data');
      }
    } catch (e) {
      _snackbarService.showSnackbar(message: 'Error: ${e.toString()}');
    }
    setBusy(false);
  }

  Future<void> selectImage(BuildContext context) async {
    final imageSource = await showDialog<ImageSource>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: const Text("Choose Image Source"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, ImageSource.camera),
            child: const Text("Camera"),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, ImageSource.gallery),
            child: const Text("Gallery"),
          ),
        ],
      ),
    );

    if (imageSource != null) {
      final pickedFile = await _imagePicker.pickImage(source: imageSource);
      if (pickedFile != null) {
        profileImage = File(pickedFile.path);
        notifyListeners();
      } else {
        _snackbarService.showSnackbar(message: 'No image selected');
      }
    }
  }

  Future<void> updateUserProfile(BuildContext context) async {
    if (user == null) {
      _snackbarService.showSnackbar(message: 'User data is not loaded');
      return;
    }

    setBusy(true);
    try {
      user = user!.copyWith(
        profileImage: profileImage?.path,
        username: usernameController.text,
      );

      bool isUpdated = await _authApiService.updateUserProfile(user!);

      if (isUpdated) {
        _snackbarService.showSnackbar(message: 'Profile updated successfully');
        notifyListeners();
        Navigator.pop(context, true); // Return success result
      } else {
        _snackbarService.showSnackbar(message: 'Failed to update profile');
      }
    } catch (e) {
      _snackbarService.showSnackbar(message: 'Error: ${e.toString()}');
    } finally {
      setBusy(false);
    }
  }
}
