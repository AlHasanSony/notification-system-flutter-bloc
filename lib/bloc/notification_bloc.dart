import 'dart:async';
import 'package:flutter/material.dart';
import '../models/notification.dart';

class NotificationBloc {
  List<NotificationModel> _notifications = [];
  List<NotificationModel> get notifications => _notifications;

  final _notificationController = StreamController<List<NotificationModel>>.broadcast();
  Stream<List<NotificationModel>> get notificationStream => _notificationController.stream;

  NotificationBloc() {
    _loadInitialNotifications();
  }

  void dispose() {
    _notificationController.close();
  }

  void _loadInitialNotifications() {
    // Simulated initial loading of 10 notifications
    for (int i = 0; i < 10; i++) {
      _notifications.add(NotificationModel(id: i, message: 'Notification $i', isRead: false));
    }
    _notificationController.add(_notifications);
  }

  void loadMoreNotifications() {
    // Simulated loading more notifications
    for (int i = _notifications.length; i < _notifications.length + 10; i++) {
      _notifications.add(NotificationModel(id: i, message: 'Notification $i', isRead: false));
    }
    _notificationController.add(_notifications);
  }

  void markAsRead(NotificationModel notification) {
    notification.isRead = true;
    _notificationController.add(_notifications);
  }

  void deleteNotifications(List<NotificationModel> selectedNotifications) {
    _notifications.removeWhere((notification) => selectedNotifications.contains(notification));
    _notificationController.add(_notifications);
  }
}
