import 'package:flutter/material.dart';

import 'package:fresh_fold_delivery/sources/core/app_core.dart';

class SliderIndicator extends StatelessWidget {
  final bool isOn;
  const SliderIndicator({super.key, required this.isOn});

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(seconds: 1),
      child: Container(
        decoration: BoxDecoration(
          color: isOn ? Theme.of(context).primaryColor : Colors.grey,
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(AppSize.cornerRadiusSmall),
        ),
        margin: const EdgeInsets.symmetric(horizontal: AppSize.inset * 0.38),
        height: 7,
        width: isOn ? 7 : 7,
      ),
    );
  }
}
