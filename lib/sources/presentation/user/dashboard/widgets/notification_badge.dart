import 'package:flutter/material.dart';

import '../../route/user_route.dart';

class NotificationBadge extends StatelessWidget {
  const NotificationBadge({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pushNamed(UserRoute.notification);
      },
      child: Container(
        height: 40,
        width: 40,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: theme.colorScheme.primary,
        ),
        child: Icon(
          Icons.notifications,
          color: Theme.of(context).scaffoldBackgroundColor,
        ),
      ),
    );
  }
}
