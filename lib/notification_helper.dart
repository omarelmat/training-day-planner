import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationHelper {
  // Create instance
  static final FlutterLocalNotificationsPlugin _notifications = 
      FlutterLocalNotificationsPlugin();

  // Initialize notifications
  static Future<void> initialize() async {
    // Android settings
    const AndroidInitializationSettings androidSettings = 
        AndroidInitializationSettings('@mipmap/ic_launcher');
    
    // Combined settings
    const InitializationSettings settings = 
        InitializationSettings(android: androidSettings);
    
    // Initialize
    await _notifications.initialize(settings);
  }

  // Show a simple notification
  static Future<void> showNotification({
    required String title,
    required String body,
  }) async {
    // Android notification details
    const AndroidNotificationDetails androidDetails = 
        AndroidNotificationDetails(
      'task_channel',  // channel id
      'Task Notifications',  // channel name
      channelDescription: 'Notifications for completed tasks',
      importance: Importance.high,
      priority: Priority.high,
    );
    
    // Combined details
    const NotificationDetails notificationDetails = 
        NotificationDetails(android: androidDetails);
    
    // Show the notification
    await _notifications.show(
      0,  // notification id
      title,
      body,
      notificationDetails,
    );
  }
}