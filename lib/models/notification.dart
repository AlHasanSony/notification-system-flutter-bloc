class NotificationModel {
  final int id;
  final String message;
  bool isRead;

  NotificationModel({
    required this.id,
    required this.message,
    required this.isRead,
  });
}
