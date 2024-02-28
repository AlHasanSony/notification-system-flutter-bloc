import 'package:flutter/material.dart';
import '../models/notification.dart';

class NotificationItem extends StatelessWidget {
  final NotificationModel notification;
  final VoidCallback onTap;
  final bool isSelected;

  const NotificationItem({
    Key? key,
    required this.notification,
    required this.onTap,
    required this.isSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: isSelected
          ? Checkbox(
        value: isSelected,
        onChanged: (_) {
          onTap();
        },
      )
          : notification.isRead
          ? Icon(Icons.mail)
          : Icon(Icons.mail_outline, color: Colors.red),
      title: Text(notification.message),
      onTap: () {
        onTap();
      },
    );
  }
}
