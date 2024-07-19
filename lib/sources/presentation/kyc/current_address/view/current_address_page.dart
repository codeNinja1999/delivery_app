import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fresh_fold_delivery/repository/repository.dart';

import '../../../../core/app_core.dart';
import '../../../widgets/widgets.dart';
import '../current_address.dart';

class CurrentAddressPage extends StatefulWidget {
  const CurrentAddressPage({super.key});

  @override
  State<CurrentAddressPage> createState() => _CurrentAddressPageState();
}

class _CurrentAddressPageState extends State<CurrentAddressPage> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: theme.colorScheme.surface,
      appBar: MyAppBar(title: LocaleKeys.kycVerification.value),
      body: BlocListener<CurrentAddressBloc, CurrentAddressState>(
        listenWhen: (previous, current) => previous.postalAddressList != current.postalAddressList,
        listener: (context, state) {
          if (state.postalAddressList != null) {
            _showAddressDropDown(context, state.postalAddressList ?? []);
          }
        },
        child: const CurrentAddressForm(),
      ),
    );
  }

  void _showAddressDropDown(BuildContext context, List<PostalAddress> postalAddressList) {
    final bloc = BlocProvider.of<CurrentAddressBloc>(context);

    showModalBottomSheet(
      context: context,
      builder: (_) {
        return Padding(
          padding: const EdgeInsets.only(top: AppSize.viewMargin),
          child: ListView.builder(
            shrinkWrap: true,
            physics: const AlwaysScrollableScrollPhysics(),
            padding: const EdgeInsets.all(AppSize.viewMargin),
            itemCount: postalAddressList.length,
            itemBuilder: (context, index) => InkWell(
              onTap: () {
                bloc.add(PostalAddressSelected(postalAddressList[index]));
                Navigator.pop(context);
              },
              child: Padding(
                padding: const EdgeInsets.only(bottom: AppSize.viewSpacing),
                child: Text(
                    "${postalAddressList[index].value}, ${postalAddressList[index].city}, ${postalAddressList[index].street}",
                    style: Theme.of(context).textTheme.bodyMedium),
              ),
            ),
          ),
        );
      },
    );
  }
}
