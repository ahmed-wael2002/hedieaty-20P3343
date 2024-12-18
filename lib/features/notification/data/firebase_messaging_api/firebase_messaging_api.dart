import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

Future<void> handleBackgroundMessage(RemoteMessage message) async {
  print('Message received: ${message.notification?.title}');
  print('Message body: ${message.notification?.body}');
}

late AndroidNotificationChannel channel;
bool isFlutterLocalNotificationsInitialized = false;
late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

class FirebaseAPI {
  final _firebaseMessaging = FirebaseMessaging.instance;

  handleMessage(RemoteMessage? message) {
    if (message == null) return;
    print('Message received: ${message.notification?.title}');
  }

  void initLocalNotification() {
    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    const AndroidInitializationSettings initializationSettingsAndroid =
    AndroidInitializationSettings('@mipmap/ic_launcher');
    const InitializationSettings initializationSettings =
        InitializationSettings(android: initializationSettingsAndroid);
    flutterLocalNotificationsPlugin.initialize(
        initializationSettings,
      onDidReceiveNotificationResponse: (NotificationResponse notificationResponse) {
        print('notification response: ${notificationResponse.payload}');
      }
    );
  }

  Future<void> setupFlutterNotifications() async {
    if (isFlutterLocalNotificationsInitialized) {
      return;
    }
    channel = const AndroidNotificationChannel(
      'high_importance_channel', // id
      'High Importance Notifications', // title
      description:
          'This channel is used for important notifications.', // description
      importance: Importance.high,
    );

    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

    /// Create an Android Notification Channel.
    ///
    /// We use this channel in the `AndroidManifest.xml` file to override the
    /// default FCM channel to enable heads up notifications.
    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);

    /// Update the iOS foreground notification presentation options to allow
    /// heads up notifications.
    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );
    isFlutterLocalNotificationsInitialized = true;
  }

  initPushNotification() {
    _firebaseMessaging
        .getInitialMessage()
        .then((message) => handleMessage(message));
    FirebaseMessaging.onMessageOpenedApp
        .listen((message) => handleMessage(message));
    FirebaseMessaging.onBackgroundMessage(
        (message) => handleBackgroundMessage(message));
    FirebaseMessaging.onMessage.listen(showFlutterNotification);
  }

  void showFlutterNotification(RemoteMessage message) {
    RemoteNotification? notification = message.notification;
    AndroidNotification? android = message.notification?.android;
    if (notification != null && android != null && !kIsWeb) {
      flutterLocalNotificationsPlugin.show(
        notification.hashCode,
        notification.title,
        notification.body,
        payload: jsonEncode(message.toMap()),
        NotificationDetails(
          android: AndroidNotificationDetails(
            channel.id,
            channel.name,
            channelDescription: channel.description,
            // TODO add a proper drawable resource to android, for now using
            //      one that already exists in example app.
            icon: '@mipmap/ic_launcher',
          ),
        ),
      );
    }
  }

  initNotification() async {
    await _firebaseMessaging.requestPermission();
    final fcmToken = await _firebaseMessaging.getToken();
    print('FCM Token: $fcmToken');
    await setupFlutterNotifications();
    initLocalNotification();
    initPushNotification();
  }
}
