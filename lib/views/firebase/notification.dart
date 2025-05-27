/*
  firebase 消息推送
 */
import 'dart:convert' as convert;
import 'dart:convert';
import 'dart:io';
import 'package:dsfulfill_admin_app/common/http_client.dart';
import 'package:dsfulfill_admin_app/firebase_options.dart';
import 'package:dsfulfill_admin_app/storage/common_storage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await setupFlutterNotifications();
  showFlutterNotification(message);
  print('Handling a background message ${message.messageId}');
}

/// Create a [AndroidNotificationChannel] for heads up notifications
late AndroidNotificationChannel channel;

bool isFlutterLocalNotificationsInitialized = false;

Future<void> setupFlutterNotifications() async {
  if (isFlutterLocalNotificationsInitialized) {
    return;
  }
  channel = const AndroidNotificationChannel(
    'high_importance_channel',
    'High Importance Notifications',
    description: 'This channel is used for important notifications.',
    importance: Importance.high,
  );

  flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  /// Create an Android Notification Channel.
  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);

  /// Update the iOS foreground notification presentation options to allow
  /// heads up notifications.
  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );
  isFlutterLocalNotificationsInitialized = true;
}

void showFlutterNotification(RemoteMessage message) {
  RemoteNotification? notification = message.notification;
  AndroidNotification? android = message.notification?.android;
  if (notification != null && android != null) {
    flutterLocalNotificationsPlugin.show(
      notification.hashCode,
      notification.title,
      notification.body,
      NotificationDetails(
        android: AndroidNotificationDetails(
          channel.id,
          channel.name,
          channelDescription: channel.description,
          icon: '@mipmap/ic_launcher',
        ),
      ),
    );
  }
}

/// Initialize the [FlutterLocalNotificationsPlugin] package.
late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

class Notifications {
  static final FirebaseMessaging messaging = FirebaseMessaging.instance;
  static late BuildContext context;
  static String? _token;
  static int _messageCount = 0;

  static initialized(BuildContext ctx) async {
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
    context = ctx;
    await setupFlutterNotifications();
    await getToken();
    registerMessage();
  }

  // 获取 FCM Token
  static Future<void> getToken() async {
    try {
      print('开始获取 FCM Token...');

      // 确保先请求权限
      NotificationSettings settings = await messaging.requestPermission(
        alert: true,
        announcement: false,
        badge: true,
        carPlay: false,
        criticalAlert: false,
        provisional: false,
        sound: true,
      );

      if (settings.authorizationStatus != AuthorizationStatus.authorized) {
        print('用户未授权通知，无法获取 FCM Token');
        return;
      }

      // 正确获取 FCM Token
      String? fcmToken = await messaging.getToken();
      _token = fcmToken;

      if (fcmToken != null && fcmToken.isNotEmpty) {
        print('=== FCM Token 获取成功 ===');
        print('完整 FCM Token: $fcmToken');
        print('Token 长度: ${fcmToken.length}');
        print('Token 前20字符: ${fcmToken.substring(0, 20)}...');

        // 保存 token
        CommonStorage.setDeviceToken(fcmToken);
        print('FCM Token 已保存到本地存储');
      } else {
        print('❌ FCM Token 获取失败: token 为空');
      }

      // iOS 获取 APNS Token (仅供参考)
      // if (Platform.isIOS) {
      //   try {
      //     String? apnsToken = await messaging.getAPNSToken();
      //     if (apnsToken != null) {
      //       print('=== APNS Token (仅供参考) ===');
      //       print('APNS Token: $apnsToken');
      //     } else {
      //       print('APNS Token: 不可用 (模拟器上正常)');
      //     }
      //   } catch (e) {
      //     print('APNS Token 获取失败: $e (模拟器上正常)');
      //   }
      // }
    } catch (e) {
      print('❌ FCM Token 获取异常: $e');
      print('错误类型: ${e.runtimeType}');
    }
  }

  static String constructFCMPayload(String? token) {
    _messageCount++;
    return jsonEncode({
      'token': token,
      'data': {
        'via': 'FlutterFire Cloud Messaging!!!',
        'count': _messageCount.toString(),
      },
      'notification': {
        'title': 'Hello FlutterFire!',
        'body': 'This notification (#$_messageCount) was created via FCM!',
      },
    });
  }

  static Future<void> sendPushMessage() async {
    if (_token == null) {
      print('Unable to send FCM message, no token exists.');
      return;
    }

    try {
      await ApiConfig.instance.post(
        'https://api.rnfirebase.io/messaging/send',
        data: constructFCMPayload(_token),
      );
      print('FCM request for device sent!');
    } catch (e) {
      print(e);
    }
  }

  // 消息通知
  static void registerMessage() async {
    // Foregroud state message
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print('Got a message whilst in the foreground!');
      print('Message data: ${message.data}');

      if (message.notification != null) {
        print('Message also contained a notification: ${message.notification}');
        showFlutterNotification(message);
      }
    });

    // Background state message
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print('A new onMessageOpenedApp event was published!');
      onMessage(message.data);
    });

    // Terminated state message
    RemoteMessage? initialMessage = await messaging.getInitialMessage();
    if (initialMessage != null) {
      print('App opened from terminated state via notification');
      onMessage(initialMessage.data);
    }
  }

  // 处理消息
  // value: ['order_id']
  static void onMessage(Map<String, dynamic>? data) {
    if (data == null) return;
    print('Processing message data: $data');
  }
}
