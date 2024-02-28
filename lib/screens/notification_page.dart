import 'package:flutter/material.dart';
import '../bloc/notification_bloc.dart';
import '../models/notification.dart';
import '../widgets/notification_item.dart';

class NotificationPage extends StatefulWidget {
  @override
  _NotificationPageState createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  final _notificationBloc = NotificationBloc();
  bool _isEditMode = false;
  List<NotificationModel> _selectedNotifications = [];

  @override
  void dispose() {
    _notificationBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notifications'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        actions: [
          IconButton(
            icon: Icon(_isEditMode ? Icons.check : Icons.edit),
            onPressed: () {
              setState(() {
                _isEditMode = !_isEditMode;
                _selectedNotifications.clear();
              });
            },
          ),
        ],
      ),
      body: StreamBuilder<List<NotificationModel>>(
        stream: _notificationBloc.notificationStream,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final notification = snapshot.data![index];
                return NotificationItem(
                  notification: notification,
                  onTap: () {
                    if (_isEditMode) {
                      setState(() {
                        if (_selectedNotifications.contains(notification)) {
                          _selectedNotifications.remove(notification);
                        } else {
                          _selectedNotifications.add(notification);
                        }
                      });
                    } else {
                      // Handle normal tap action here
                    }
                  },
                  isSelected: _isEditMode && _selectedNotifications.contains(notification),
                );
              },
            );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
      bottomNavigationBar: _isEditMode
          ? BottomAppBar(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Checkbox(
              value: _selectedNotifications.length == _notificationBloc.notifications.length,
              onChanged: (value) {
                setState(() {
                  if (value!) {
                    _selectedNotifications.addAll(_notificationBloc.notifications);
                  } else {
                    _selectedNotifications.clear();
                  }
                });
              },
            ),
            ElevatedButton(
              onPressed: () {
                _notificationBloc.deleteNotifications(_selectedNotifications);
                setState(() {
                  _selectedNotifications.clear();
                });
              },
              child: Text('Delete'),
            ),
            ElevatedButton(
              onPressed: () {
                _selectedNotifications.forEach((notification) {
                  _notificationBloc.markAsRead(notification);
                });
                setState(() {
                  _selectedNotifications.clear();
                });
              },
              child: Text('Mark as Read'),
            ),
          ],
        ),
      )
          : null,
    );
  }
}
