import 'package:flutter/material.dart';
import 'package:googleapis_auth/auth_io.dart' as auth;
// import 'package:googleapis/servicecontrol/v1.dart' as servicecontrol;

import '../../../../common/network/dio_service.dart';

class PushNotificationService {

  static Future<String> getAccessToken() async {
    final serviceAccountJson = {
      "type": "service_account",
      "project_id": "hedieaty-15d58",
      "private_key_id": "ae1b72b61058b40f72baf9f8f84d27c68b841a9f",
      "private_key": "-----BEGIN PRIVATE KEY-----\nMIIEvQIBADANBgkqhkiG9w0BAQEFAASCBKcwggSjAgEAAoIBAQDFL5K3oWdwWa9q\nXsi5myg6mbbnNRPzWVDFYZWT6mpsoxCsUMPWvMhkE6tlABtzH8piM7mOtk6bP0h6\nPR0e+Xedb2LXnqhqCeRJuAgW1r389Rbd9yHwuKlvjF1/doeQaRWrlX2pvEzzYkfL\nINK7qHYFO56jEbH8YbniRv1USZ1xSxh9KvAFPo67THqK6mesQzvR/AG2UT5pUF0M\nzOEt9X/diX43PIkAb6IFixh/PQimUCpEoNKwUcOlbTDx+AWHdO+nCf0+zyuXu/0M\nZutbliih+DLaYogLDuckn+JD144uDCwtHDgRpcLE6ti1t+DDxF2pv0C1EsMMfYh3\nqz9JlmFhAgMBAAECggEAEikfzjzJAStDAVaqDi1QxuQWv3P/TeRpQ+LvoUT8n0Ix\nDDj2CHl9MhMwfM4sbDpx0jPCwJBgbGKNyZnsuPt8SkPF3gD1ShFC9SbEMlvkLJkW\nc/cv9fLNj07L4t9NfGRJRCYxzo4SpXNlFFUfqeJJvsQ8B8QrjDu97Ud6saaEBlKD\nhW9fJAipVooiqa9BdKMLvgqduXQMfM7Aw7GYkcJpixDBXAYq2ogs77CrkWEsP5Iv\n/V7T4u1V3H48ovWRg+Qt4WKCq7xN/h2cFyoOIwnKJPbKvGEaU9PjSfpIvjihZrLc\nCC7PaRf1L/IXcbLqOjUvxZ++gL3CiBbtpfb1/HZxjwKBgQDstNCeFlAO06MatpCS\nCLq/+d93kCpN0CS2loklgUWMZPnbPsUfRkpGxnqGrOLcRp6LInggZQvWm427SBoe\nCr/BakTFcwnPJkUqKoSSFis8l9uNCBEyu0+Jj2WqfmUnQ4yyut+F2gHZhWiagf8u\n3OHlOHidE+9sCpjUU6rMhXCO0wKBgQDVQhyvyMs68h0AEZ2VS2UUD3QelkR6izte\noSd4gL58YGCXVmwv73L/sxbTyeFytaEbkgbH29HSNPs/Tq3Kybz/nmAlSg5u3uou\nrX1VeKN6+RGg/fAPGZO+QY+FpCDhFcpbeKPAVQrQaTOXyow2DzxV9dl3nSyMgljG\nAEF6U9H2ewKBgD+obQZm58blAdNYT88GS/r/HysPeWEN3iHAoEeW2XZlXZCp8+dy\nRt172U3IxwYIc/DlJztHEYT4togsXuG/cEx64N3dD0FHgIhTgO2sypn0GRZ3mfBz\n0XMkPmo4rcl+cCNNAHoF5EN0jmonFdKrkpDLvBw6VURQIUPQ8HkqVdgDAoGAHWjm\np99bF5/4G+BSCRrCr8eJzgYPH48/+sbiuJ2Yp3JrH7PNa7br9xNtnHuE2druguza\nfol0IDcqRwrEsOitZdsji0DxSJz5UsKePEFM2lKq+bbLemmelGhaMKX32tK0e3Th\nsE6KFT/M26wVNgdX3Mrw2KwWTrJTJ8s1PHd+xy0CgYEAnnhRqAQffq/c4oIc2eoV\nj9KNJt0sYlLQmVotqq3GPsnYWr3eWn3IkJxzZD9+z/n8On6PtfuMsChPPVfk+q5v\n5MKn97AEzRkiUwmG+TgaIok2FFmsXGktr1eofxM4qLcv8LNaH0QZefvKbMR30Tkh\n7/v0n0n/pFdd3BHgLPwHz8A=\n-----END PRIVATE KEY-----\n",
      "client_email": "hedeiaty@hedieaty-15d58.iam.gserviceaccount.com",
      "client_id": "101174998604733780298",
      "auth_uri": "https://accounts.google.com/o/oauth2/auth",
      "token_uri": "https://oauth2.googleapis.com/token",
      "auth_provider_x509_cert_url": "https://www.googleapis.com/oauth2/v1/certs",
      "client_x509_cert_url": "https://www.googleapis.com/robot/v1/metadata/x509/hedeiaty%40hedieaty-15d58.iam.gserviceaccount.com",
      "universe_domain": "googleapis.com"
    };

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
