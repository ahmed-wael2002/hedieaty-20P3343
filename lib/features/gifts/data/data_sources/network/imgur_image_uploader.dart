import 'dart:io';
import 'package:dio/dio.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter/material.dart';

import '../../../../../common/constants/images_paths.dart';

class ImgurUploader {
  final Dio dio = Dio();
  final ImagePicker picker = ImagePicker();

  // static const String clientId = 'YOUR_IMGUR_CLIENT_ID';

  Future<String?> uploadImageToImgur() async {
    try {
      // Step 1: Check and request gallery permissions explicitly
      if (!(await _requestGalleryPermission())) {
        debugPrint('Gallery permission denied.');
        return null;
      }

      // Step 2: Pick an image from the gallery
      final XFile? pickedFile = await picker.pickImage(source: ImageSource.gallery);

      if (pickedFile == null) {
        debugPrint('No image selected.');
        return null;
      }

      File file = File(pickedFile.path);

      // Step 3: Prepare the upload request
      final formData = FormData.fromMap({
        'image': await MultipartFile.fromFile(file.path),
        'type': 'file',
      });

      // Step 4: Upload to Imgur
      final response = await dio.post(
        'https://api.imgur.com/3/upload',
        data: formData,
        options: Options(
          headers: {'Authorization': 'Client-ID $remoteImageClientId'},
        ),
      );

      // Step 5: Handle the response
      if (response.statusCode == 200 && response.data != null && response.data['success'] == true) {
        final String? imageUrl = response.data['data']?['link'];
        if (imageUrl != null) {
          debugPrint('Image uploaded successfully: $imageUrl');
          return imageUrl;
        } else {
          debugPrint('Error: No image URL in response');
          return null;
        }
      } else if (response.statusCode == 503) {
        debugPrint('Server error (503). The service might be unavailable, retrying...');
        // Optionally, you could add a retry mechanism here if necessary.
        return null;
      } else {
        debugPrint('Failed to upload image: ${response.data?['data']?['error'] ?? 'Unknown error'}');
        return null;
      }
    } catch (e) {
      debugPrint('Error uploading image: $e');
      return null;
    }
  }

  /// Request permission to access the gallery
  Future<bool> _requestGalleryPermission() async {
    Permission permission;

    // Step 1: Choose the appropriate permission for different Android versions
    if (Platform.isAndroid) {
      if (await _isAndroid13OrHigher()) {
        permission = Permission.photos; // Android 13+ uses this permission
      } else {
        permission = Permission.storage; // For older versions
      }
    } else {
      permission = Permission.photos; // iOS devices
    }

    // Step 2: Check and request the permission
    var status = await permission.status;

    if (status.isGranted) {
      return true; // Already granted
    } else if (status.isDenied || status.isLimited) {
      final result = await permission.request();
      return result.isGranted;
    } else if (status.isPermanentlyDenied) {
      debugPrint('Permission permanently denied. Opening app settings...');
      await openAppSettings();
      return false;
    }

    return false;
  }

  /// Helper function to check if Android version is 13 or higher
  Future<bool> _isAndroid13OrHigher() async {
    final int sdkInt = await _getSdkVersion();
    return sdkInt >= 33;
  }

  /// Retrieve the Android SDK version
  Future<int> _getSdkVersion() async {
    try {
      return int.parse(Platform.version.split(' ')[0]);
    } catch (e) {
      debugPrint('Error fetching SDK version: $e');
      return 32; // Default to pre-Android 13
    }
  }
}
