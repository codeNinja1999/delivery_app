import 'package:flutter/material.dart';

import 'package:fresh_fold_delivery/sources/resources/resources.dart';
import 'package:fresh_fold_delivery/sources/presentation/widgets/widgets.dart';

class ExistMobileNumberAlertBox extends StatelessWidget {
  const ExistMobileNumberAlertBox({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomDialog(
      imageString: AppImages.logo,
      title: '',
      message: '',
      primaryButtonTitle: '',
      onPrimaryButtonPressed: () {},
    );
  }
}
