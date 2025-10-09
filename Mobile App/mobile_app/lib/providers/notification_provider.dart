import 'package:flutter/material.dart';

class NotificationModel {
  final String id;
  final String title;
  final String body;
  final String type;
  final DateTime timestamp;
  final bool isRead;

  NotificationModel({
    required this.id,
    required this.title,
    required this.body,
    required this.type,
    required this.timestamp,
    this.isRead = false,
  });
}

class NotificationProvider with ChangeNotifier {
  List<NotificationModel> _notifications = [];
  bool _isLoading = false;
  String? _error;
  String? _fcmToken;

  List<NotificationModel> get notifications => _notifications;
  List<NotificationModel> get unreadNotifications =>
      _notifications.where((n) => !n.isRead).toList();
  int get unreadCount => unreadNotifications.length;
  bool get isLoading => _isLoading;
  String? get error => _error;
  String? get fcmToken => _fcmToken;

  // Initialize FCM
  Future<void> initializeFCM() async {
    try {
      // TODO: Initialize Firebase Cloud Messaging
      // 1. Request permission
      // 2. Get FCM token
      // 3. Save token to Firestore
      // 4. Listen to foreground messages
      
      print('FCM Initialized (Placeholder)');
    } catch (e) {
      _error = e.toString();
      print('Error initializing FCM: $e');
    }
  }

  // Request notification permissions
  Future<bool> requestPermission() async {
    try {
      // TODO: Request notification permissions
      // For iOS: Request user permission
      // For Android: Auto-granted but need to handle
      
      return true;
    } catch (e) {
      _error = e.toString();
      return false;
    }
  }

  // Get FCM token
  Future<String?> getToken() async {
    try {
      // TODO: Get FCM token
      // _fcmToken = await FirebaseMessaging.instance.getToken();
      // return _fcmToken;
      
      return 'placeholder_fcm_token';
    } catch (e) {
      _error = e.toString();
      return null;
    }
  }

  // Add notification
  void addNotification(NotificationModel notification) {
    _notifications.insert(0, notification);
    notifyListeners();
  }

  // Mark notification as read
  void markAsRead(String notificationId) {
    var index = _notifications.indexWhere((n) => n.id == notificationId);
    if (index != -1) {
      // Create a new notification with isRead = true
      var notification = _notifications[index];
      _notifications[index] = NotificationModel(
        id: notification.id,
        title: notification.title,
        body: notification.body,
        type: notification.type,
        timestamp: notification.timestamp,
        isRead: true,
      );
      notifyListeners();
    }
  }

  // Mark all as read
  void markAllAsRead() {
    _notifications = _notifications
        .map((n) => NotificationModel(
              id: n.id,
              title: n.title,
              body: n.body,
              type: n.type,
              timestamp: n.timestamp,
              isRead: true,
            ))
        .toList();
    notifyListeners();
  }

  // Delete notification
  void deleteNotification(String notificationId) {
    _notifications.removeWhere((n) => n.id == notificationId);
    notifyListeners();
  }

  // Clear all notifications
  void clearAll() {
    _notifications.clear();
    notifyListeners();
  }

  // Send local notification (for testing)
  void sendLocalNotification(String title, String body, String type) {
    var notification = NotificationModel(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      title: title,
      body: body,
      type: type,
      timestamp: DateTime.now(),
    );
    addNotification(notification);
  }

  // Clear error
  void clearError() {
    _error = null;
    notifyListeners();
  }
}

