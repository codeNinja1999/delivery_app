import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:fresh_fold_delivery/sources/route/route.dart';
import 'package:fresh_fold_delivery/sources/core/app_core.dart';
import 'package:fresh_fold_delivery/sources/resources/resources.dart';

class NotificationBadge extends StatelessWidget {
  const NotificationBadge({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Align(
      alignment: Alignment.centerRight,
      child: GestureDetector(
        onTap: () {
          Navigator.of(context).pushNamed(AppRoute.notification);
        },
        child: Container(
          height: 42,
          width: 42,
          padding: const EdgeInsets.all(AppSize.inset * 0.25),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: theme.colorScheme.tertiary,
          ),
          child: Stack(
            alignment: AlignmentDirectional.center,
            children: [
              SvgPicture.asset(AppSvg.badgeNotification),
              Positioned(
                left: 16,
                bottom: 20,
                child: Container(
                  decoration: BoxDecoration(
                    color: theme.colorScheme.primary,
                    shape: BoxShape.circle,
                  ),
                  height: 12,
                  width: 12,
                  child: Center(
                    child: Text(
                      "10",
                      textAlign: TextAlign.center,
                      style: theme.textTheme.bodySmall?.copyWith(
                        fontSize: 8,
                        fontWeight: FontWeight.bold,
                        color: theme.colorScheme.primary,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
