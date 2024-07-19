import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../core/app_core.dart';
import '../../../../../widgets/widgets.dart';
import '../../help_center.dart';

class FaqsPage extends StatefulWidget {
  const FaqsPage({super.key});

  @override
  State<FaqsPage> createState() => _FaqsPageState();
}

class _FaqsPageState extends State<FaqsPage> {
  @override
  void initState() {
    super.initState();
    context.read<FaqBloc>().add(FetchJSON());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: MyAppBar(
        title: "FAQs",
        backButtonAction: () => Navigator.of(context, rootNavigator: true).pop(),
      ),
      body: const FaqBody(),
    );
  }
}

class FaqBody extends StatelessWidget {
  const FaqBody({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(vertical: AppSize.viewSpacing, horizontal: AppSize.viewMargin),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            "Have any question?",
            style: Theme.of(context).textTheme.titleLarge?.copyWith(fontSize: AppSize.inset * 2),
          ),
          const SizedBox(height: AppSize.inset),
          Text(
            "Here are the list of some of the mostly asked questions. Please reach out to us if you do not find your query here.",
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w400),
          ),
          // const FaqSearchInput(),
          const SizedBox(height: AppSize.viewSpacing),

          BlocBuilder<FaqBloc, FaqState>(
            buildWhen: (previous, current) => previous.faqModel != current.faqModel,
            builder: (context, state) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  FaqListItemView(
                    theme: theme,
                    title: state.faqModel?.paymentAndFees?.first.title ?? "",
                    count: state.faqModel?.paymentAndFees?.length ?? 0,
                    item: state.faqModel?.paymentAndFees,
                  ),
                  const SizedBox(height: AppSize.viewSpacing),
                  FaqListItemView(
                    theme: theme,
                    title: state.faqModel?.appTutorials?.first.title ?? "",
                    count: state.faqModel?.appTutorials?.length ?? 0,
                    item: state.faqModel?.appTutorials,
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}

class FaqListItemView extends StatelessWidget {
  const FaqListItemView({
    super.key,
    required this.theme,
    required this.title,
    required this.count,
    this.item,
  });

  final ThemeData theme;
  final String title;
  final int count;
  final List<FAQItem>? item;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          title,
          style: theme.textTheme.titleLarge?.copyWith(color: theme.colorScheme.primary),
        ),
        const SizedBox(height: AppSize.viewSpacing),
        ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: count,
          separatorBuilder: (context, index) => Padding(
            padding: const EdgeInsets.only(top: AppSize.cornerRadiusMedium),
            child: Divider(color: theme.dividerColor),
          ),
          padding: EdgeInsets.zero,
          itemBuilder: (context, index) {
            final faq = item?[index];
            return Theme(
                data: ThemeData(highlightColor: theme.colorScheme.shadow, splashColor: theme.colorScheme.shadow),
                child: ExpansionTile(
                  title: Text(
                    faq?.question ?? "",
                    style: theme.textTheme.bodyLarge,
                  ),
                  tilePadding: EdgeInsets.zero,
                  shape: const OutlineInputBorder(borderSide: BorderSide.none),
                  children: [
                    Text(faq?.answer ?? ""),
                  ],
                ));
          },
        ),
      ],
    );
  }
}
