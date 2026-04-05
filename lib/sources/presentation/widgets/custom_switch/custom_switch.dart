import 'package:flutter/material.dart';

import 'package:fresh_fold_delivery/sources/core/app_core.dart';
import 'package:fresh_fold_delivery/sources/resources/resources.dart';

class CustomSwitch extends StatefulWidget {
  final bool value;
  final ValueChanged<bool> onChanged;

  const CustomSwitch({super.key, required this.value, required this.onChanged});

  @override
  // ignore: library_private_types_in_public_api
  _CustomSwitchState createState() => _CustomSwitchState();
}

class _CustomSwitchState extends State<CustomSwitch> with SingleTickerProviderStateMixin {
  Animation? _circleAnimation;
  AnimationController? _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(vsync: this, duration: const Duration(milliseconds: 60));
    _circleAnimation = AlignmentTween(
            begin: widget.value ? Alignment.centerRight : Alignment.centerLeft,
            end: widget.value ? Alignment.centerLeft : Alignment.centerRight)
        .animate(CurvedAnimation(parent: _animationController!, curve: Curves.linear));
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return AnimatedBuilder(
      animation: _animationController!,
      builder: (context, child) {
        return GestureDetector(
          onTap: () {
            // if (_animationController!.isCompleted) {
            //   _animationController!.reverse();
            // } else {
            //   _animationController!.forward();
            // }
            // widget.value == false ? widget.onChanged(true) : widget.onChanged(false);
          },
          child: Container(
            width: AppSize.spacedViewSpacing * 0.8,
            height: AppSize.checkBoxHeight,
            decoration: BoxDecoration(
              border: Border.all(
                color: _circleAnimation!.value == Alignment.centerLeft
                    ? AppColors.greyColor
                    : theme.colorScheme.primary.withOpacity(0.4),
              ),
              borderRadius: BorderRadius.circular(24.0),
              color: _circleAnimation!.value == Alignment.centerLeft
                  ? theme.colorScheme.shadow
                  : Theme.of(context).scaffoldBackgroundColor,
            ),
            child: Padding(
              padding: const EdgeInsets.only(top: 2.0, bottom: 2.0, right: 2.0, left: 2.0),
              child: Container(
                alignment: widget.value
                    ? ((Directionality.of(context) == TextDirection.rtl) ? Alignment.centerRight : Alignment.centerLeft)
                    : ((Directionality.of(context) == TextDirection.rtl) ? Alignment.centerLeft : Alignment.centerRight),
                child: Container(
                  width: AppSize.inset,
                  height: AppSize.inset,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: _circleAnimation!.value == Alignment.centerLeft
                        ? AppColors.greyColor
                        : theme.colorScheme.primary.withOpacity(0.3),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
