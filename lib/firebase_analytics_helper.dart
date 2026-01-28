import 'package:firebase_analytics/firebase_analytics.dart';

class FirebaseAnalyticsHelper {
  static final FirebaseAnalytics _analytics = FirebaseAnalytics.instance;

  // Track screen views 
  static Future<void> logScreenView(String screenName) async {
    await _analytics.logScreenView(
      screenName: screenName,
      screenClass: 'TaskScreen',
    );
    print('[Firebase Analytics] Screen View: $screenName');
  }

  // Track events 
  static Future<void> logEvent(String name, {Map<String, dynamic>? parameters}) async {
    await _analytics.logEvent(
      name: name,
      parameters: parameters,
    );
    print('[Firebase Analytics] Event: $name');
  }

  // Track task creation
  static Future<void> logTaskCreated(String title, double duration, String category) async {
    await logEvent('task_created', parameters: {
      'title': title,
      'duration': duration,
      'category': category,
    });
  }

  // Track task deletion
  static Future<void> logTaskDeleted(String title, double duration) async {
    await logEvent('task_deleted', parameters: {
      'title': title,
      'duration': duration,
    });
  }

  // Track camera usage 
  static Future<void> logCameraUsed() async {
    await logEvent('camera_used');
  }
}