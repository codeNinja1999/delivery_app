import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:fresh_fold_delivery/sources/core/app_core.dart';
import 'package:fresh_fold_delivery/sources/presentation/widgets/widgets.dart';
import '../bloc/currency_changer_bloc.dart';

class CurrencyChangerPage extends StatefulWidget {
  const CurrencyChangerPage({super.key});

  @override
  State<CurrencyChangerPage> createState() => _CurrencyChangerPageState();
}

class _CurrencyChangerPageState extends State<CurrencyChangerPage> {
  @override
  void initState() {
    super.initState();
    final bloc = context.read<CurrencyChangerBloc>();
    bloc.add(GetReceivingCountry());
    bloc.add(GetSelectedCurrencyCode());
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Scaffold(
      backgroundColor: theme.colorScheme.surface,
      appBar: MyAppBar(title: LocaleKeys.changeCurrencyTitle.value),
      body: BlocListener<CurrencyChangerBloc, CurrencyChangerState>(
        listenWhen: (previous, current) => previous.status != current.status,
        listener: (context, state) {
          final status = state.status;
          (status is InProgress) ? LoadingView.show() : LoadingView.hide();
          if (status is SubmissionFailure) {
            ErrorResolver.resolve(context, status);
          }
        },
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSize.viewMargin,
            vertical: AppSize.viewSpacing,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                LocaleKeys.mostPopular.value,
                style: theme.textTheme.titleMedium?.copyWith(
                  color: theme.colorScheme.primary,
                  letterSpacing: 2.2,
                ),
              ),
              const SizedBox(height: AppSize.viewMargin),
              BlocBuilder<CurrencyChangerBloc, CurrencyChangerState>(
                builder: (context, state) {
                  return ListView.separated(
                    shrinkWrap: true,
                    padding: EdgeInsets.zero,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: state.receivingCountryList?.length ?? 0,
                    separatorBuilder: (context, index) => Divider(color: theme.colorScheme.surface),
                    itemBuilder: (BuildContext context, int index) {
                      final receivingCountry = state.receivingCountryList?[index];
                      return ListTile(
                          contentPadding: EdgeInsets.zero,
                          leading: BorderImage(
                            imageUrl: "${AppConstants.countryImageUrl}${receivingCountry?.countryCode?.toLowerCase()}.svg",
                            size: AppSize.inset * 2,
                          ),
                          title: Text(
                            receivingCountry?.value ?? "",
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              if (state.selectedCurrencyCode == receivingCountry?.currencyCode)
                                Icon(
                                  Icons.check,
                                  size: 24,
                                  color: theme.primaryColor,
                                ),
                            ],
                          ),
                          onTap: () {
                            saveCurrencyCode(receivingCountry?.currencyCode ?? "");
                            Navigator.of(context).pop(receivingCountry);
                          });
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  saveCurrencyCode(String currencyCode) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setString('CURRENCY_CODE', currencyCode);
  }
}
