import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:easy_localization/easy_localization.dart';

import 'package:fresh_fold_delivery/sources/core/app_core.dart';
import 'package:fresh_fold_delivery/sources/presentation/widgets/widgets.dart';

import '../../../route/app_account_utility_route.dart';
import '../bloc/change_language_bloc.dart';
import '../model/language_model.dart';

class ChangeLanguagePage extends StatefulWidget {
  const ChangeLanguagePage({super.key});

  @override
  State<ChangeLanguagePage> createState() => _ChangeLanguagePageState();
}

class _ChangeLanguagePageState extends State<ChangeLanguagePage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final localeList = context.supportedLocales;
      final currentLocale = context.locale;
      context.read<ChangeLanguageBloc>().add(GetLocaleList(localeList, currentLocale));
      context.read<ChangeLanguageBloc>().add(SelectedLanguage(currentLocale));
    });
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Scaffold(
      backgroundColor: theme.colorScheme.surface,
      appBar: MyAppBar(
          title: LocaleKeys.language.value,
          backButtonAction: () {
            final navigator = Navigator.of(context);
            if (navigator.widget.initialRoute == AppAccountUtilityRoute.changeLanguage) {
              Navigator.of(context, rootNavigator: true).pop();
            } else {
              navigator.pop();
            }
          }),
      body: BlocBuilder<ChangeLanguageBloc, ChangeLanguageState>(
        buildWhen: (previous, current) => previous.languageModelList != current.languageModelList,
        builder: (context, state) {
          return ListView.separated(
            shrinkWrap: true,
            itemCount: state.languageModelList?.length ?? 0,
            padding: const EdgeInsets.all(AppSize.viewMargin),
            separatorBuilder: (context, index) => Divider(color: theme.dividerColor.withOpacity(0.1)),
            itemBuilder: (BuildContext context, int index) {
              LanguageModel? language = state.languageModelList?[index];
              return ListTile(
                contentPadding: EdgeInsets.zero,
                leading: Container(
                  height: AppSize.viewSpacing,
                  width: AppSize.viewSpacing,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Theme.of(context).colorScheme.tertiary,
                    ),
                  ),
                  child: SvgPicture.network(
                    language?.flag != null ? language!.flag : "${AppConstants.countryImageUrl}usa.svg",
                    placeholderBuilder: (context) => const CircularProgressIndicator(),
                  ),
                ),
                title: Text(
                  language?.name ?? "",
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (context.locale.languageCode == language?.languageCode)
                      Icon(
                        Icons.check,
                        size: 24,
                        color: theme.primaryColor,
                      ),
                  ],
                ),
                onTap: () async {
                  final selectedLocale = context.supportedLocales[index];
                  await context
                      .setLocale(selectedLocale)
                      .then((value) => context.read<ChangeLanguageBloc>().add(SelectedLanguage(selectedLocale)));
                  goBack(language?.name);
                },
              );
            },
          );
        },
      ),
    );
  }

  goBack(String? language) {
    Navigator.of(context, rootNavigator: true).pop();
  }
}
