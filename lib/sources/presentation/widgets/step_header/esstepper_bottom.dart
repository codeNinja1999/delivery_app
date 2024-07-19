import 'package:flutter/material.dart';

import 'package:fresh_fold_delivery/sources/core/app_core.dart';

// new custom progress indicator
class StepProgressView extends StatelessWidget {
  final List<String> _titles;
  final int _curStep;
  final Color _activeColor;
  final Color _inactiveColor = HexColor("#E6EEF3");
  final double lineWidth = 1.0;
//grey E6EEF3
  StepProgressView({super.key, required int curStep, titles, required Color color})
      : _titles = const ["Amount", "Beneficiary", "Payment"],
        _curStep = curStep,
        _activeColor = color;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
        padding: const EdgeInsets.symmetric(horizontal: AppSize.inset),
        child: Column(
          children: <Widget>[
            Row(
              children: _iconViews(theme),
            ),
            const SizedBox(
              height: 8,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: _titleViews(),
            ),
          ],
        ));
  }

  List<Widget> _iconViews(ThemeData theme) {
    var list = <Widget>[];
    _titles.asMap().forEach((i, icon) {
      // var circleColor = (i == 0 || _curStep > i + 1) ? _activeColor : _inactiveColor;
      var lineColor = _curStep > i + 1 ? _activeColor : _inactiveColor;
      // var iconColor = (i == 0 || _curStep > i + 1) ? _activeColor : _inactiveColor;

      Widget getInnerElementOfStepper(ThemeData theme, i) {
        if (i + 1 < _curStep) {
          return Container(
            width: 24.0,
            height: 24.0,
            decoration: BoxDecoration(
              color: theme.colorScheme.primary,
              // color: (i == 0 && _curStep > i + 1 && _curStep == 2) ? Colors.grey : Colors.blue,
              borderRadius: const BorderRadius.all(Radius.circular(22.0)),
            ),
            child: const Icon(
              Icons.check,
              color: Colors.white,
              size: 16.0,
            ),
          );
        } else if (i + 1 == _curStep) {
          return Center(
            child: Icon(
              Icons.circle,
              color: theme.colorScheme.primary,
              size: 12.0,
            ),
          );
        } else {
          return Container();
        }
      }

      list.add(Container(
        width: 24.0,
        height: 24.0,
        margin: const EdgeInsets.only(
          left: AppSize.cornerRadiusSmall * 2,
          right: AppSize.cornerRadiusSmall * 2,
        ),
        decoration: BoxDecoration(
          color: HexColor("#E6EEF3"),
          borderRadius: const BorderRadius.all(Radius.circular(22.0)),
        ),
        child: getInnerElementOfStepper(theme, i),
      ));

      //line between icons
      if (i != _titles.length - 1) {
        list.add(Expanded(
            child: Container(
          height: lineWidth,
          color: lineColor,
        )));
      }
    });

    return list;
  }

  List<Widget> _titleViews() {
    var list = <Widget>[];
    _titles.asMap().forEach((i, text) {
      list.add(Text(text, style: TextStyle(color: HexColor("#000000"))));
    });
    return list;
  }
}
