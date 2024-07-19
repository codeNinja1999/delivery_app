import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:fresh_fold_delivery/sources/core/app_core.dart';
import 'package:fresh_fold_delivery/sources/resources/resources.dart';
import 'package:fresh_fold_delivery/sources/presentation/widgets/widgets.dart';
import '../bloc/id_validate_bloc.dart';
import 'id_validate_form.dart';

class IdValidatePage extends StatefulWidget {
  const IdValidatePage({super.key});

  @override
  State<IdValidatePage> createState() => _IdValidatePageState();
}

class _IdValidatePageState extends State<IdValidatePage> {
  @override
  void initState() {
    super.initState();
    context.read<IdValidateBloc>().add(GetIdTypeCatalog());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: MyAppBar(backButtonAction: goBack),
      body: const IdValidateForm(),
    );
  }

  goBack() {
    showDialog(
      context: context,
      builder: (nContext) {
        return CustomDialog(
          svgImage: AppSvg.cancel,
          title: LocaleKeys.cancel.value,
          message: LocaleKeys.areYouSureYouWantToCancel.value,
          primaryButtonTitle: LocaleKeys.yesCancel.value,
          secondaryButtonTitle: LocaleKeys.noIWantToContinue.value,
          onPrimaryButtonPressed: () => Navigator.of(context).pop(),
        );
      },
    );
  }
}
