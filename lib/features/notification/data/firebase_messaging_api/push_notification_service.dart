import 'package:flutter/material.dart';
import 'package:googleapis_auth/auth_io.dart' as auth;
// import 'package:googleapis/servicecontrol/v1.dart' as servicecontrol;

import '../../../../common/network/dio_service.dart';
import '../../../../configs/Secret/notification/notification_key.dart';

class PushNotificationService {

  static Future<String> getAccessToken() async {

    final scopes = [
      'https://www.googleapis.com/auth/userinfo.email',
      'https://www.googleapis.com/auth/firebase.database',
      'https://www.googleapis.com/auth/firebase.messaging',
    ];

    // Create credentials with the given scopes
    final credentials = auth.ServiceAccountCredentials.fromJson(serviceAccountJson);

    // Obtain the access token
    final client = await auth.clientViaServiceAccount(credentials, scopes);
    final accessToken = client.credentials.accessToken.data;

    return accessToken;
  }

  static sendNotificationToDevice({
    required String deviceToken,
    required String title,
    required String body,
  }) async {
    try {
      final String serverAccessTokenKey = await getAccessToken();
      String endpointFirebaseCloudMessaging = 'https://fcm.googleapis.com/v1/projects/hedieaty-15d58/messages:send';

      final Map<String, dynamic> message = {
        'message': {
          'token': deviceToken,
          'notification': {
            'title': title,
            'body': body,
          },
          // 'data': {
          //   'tripId': tripId,
          // },
        }
      };

      final dioService = DioService();
      dioService.setBaseUrl(endpointFirebaseCloudMessaging);

      final response = await dioService.post(
        '',
        data: message,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $serverAccessTokenKey',
        },
      );

      if (response != null && response.statusCode == 200) {
        debugPrint('Notification sent successfully');
      } else {
        debugPrint('Failed to send notification: ${response?.statusCode ?? "Unknown error"}');
      }
    } catch (e) {
      debugPrint('Error sending notification: $e');
    }
  }
}
