import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:fresh_fold_delivery/sources/core/app_core.dart';
import 'package:fresh_fold_delivery/sources/presentation/widgets/widgets.dart';
import '../bloc/beneficiary_list_bloc.dart';
import 'beneficiary_list_view.dart';

class BeneficiaryListPage extends StatefulWidget {
  const BeneficiaryListPage({super.key});

  @override
  State<BeneficiaryListPage> createState() => _BeneficiaryState();
}

class _BeneficiaryState extends State<BeneficiaryListPage> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final TextEditingController controller = TextEditingController();

    return Scaffold(
      backgroundColor: theme.colorScheme.surface,
      resizeToAvoidBottomInset: true,
      appBar: PreferredSize(
        preferredSize: const Size(double.infinity, 65),
        child: SafeArea(
          minimum: const EdgeInsets.only(right: AppSize.viewMargin * 0.5),
          child: AnimationSearchBar(
            isBackButtonVisible: true,
            backIcon: Icons.arrow_back_rounded,
            textStyle: theme.textTheme.bodyLarge,
            centerTitleStyle: theme.textTheme.titleMedium?.copyWith(fontSize: 18),
            centerTitle: LocaleKeys.beneficiaryTitle.value,
            hintText: LocaleKeys.search.value,
            onChanged: (text) {
              context.read<BeneficiaryListBloc>().add(SearchTextChanged(text));
            },
            searchTextEditingController: controller,
            horizontalPadding: AppSize.viewMargin * 0.5,
            searchFieldDecoration: BoxDecoration(
              color: Colors.black.withOpacity(.01),
              border: Border.all(color: Colors.black.withOpacity(.1), width: 0.5),
              borderRadius: BorderRadius.circular(AppSize.cornerRadiusMedium),
            ),
          ),
        ),
      ),
      body: const BeneficiaryListView(),
    );
  }
}
