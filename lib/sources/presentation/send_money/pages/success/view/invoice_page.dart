import 'package:flutter/material.dart';

import '../../../../../core/app_core.dart';
import '../../../../../resources/resources.dart';
import '../../../../widgets/widgets.dart';
import '../model/list_model.dart';

class InvoicePage extends StatelessWidget {
  const InvoicePage({super.key});

  @override
  Widget build(BuildContext context) {
    final listItem = [
      ListViewModel(key: "Date", value: "2024/01/23"),
      ListViewModel(key: "Recipient", value: "Rita Pradhan"),
      ListViewModel(
        key: "Receiving Amt",
        value: "Rs. 5000,00.00",
        valueTextStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.green),
      ),
      ListViewModel(
        key: "Transfer Amt",
        value: "\$1000.00",
        dataTextStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w700),
        valueTextStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w700),
      ),
    ];

    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: const MyAppBar(title: "Invoice"),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(
          vertical: AppSize.viewMargin,
          horizontal: AppSize.inset,
        ),
        child: Container(
          padding: const EdgeInsets.all(AppSize.inset),
          decoration: BoxDecoration(
            border: Border.all(color: theme.disabledColor),
            borderRadius: BorderRadius.circular(AppSize.cornerRadiusMedium),
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Image.asset(
                    AppImages.logo,
                    width: 60,
                    height: 50,
                  ),
                  Column(
                    children: [
                      Text("Transaction ID", style: theme.textTheme.bodySmall?.copyWith(fontSize: 10)),
                      Text(
                        "INV/112542115",
                        style: theme.textTheme.bodySmall?.copyWith(fontWeight: FontWeight.w400),
                      )
                    ],
                  )
                ],
              ),
              const SizedBox(height: AppSize.inset),
              CircleAvatar(
                backgroundColor: theme.disabledColor,
                radius: 30,
              ),
              const SizedBox(height: AppSize.inset),
              Text(
                "Payment Success",
                style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: AppSize.inset),
              Text(
                "Your payment transaction has been completed.",
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(fontWeight: FontWeight.w400),
              ),
              const SizedBox(height: AppSize.inset),
              Text(
                "\$1000.00",
                textAlign: TextAlign.center,
                style: Theme.of(context)
                    .textTheme
                    .titleLarge
                    ?.copyWith(fontWeight: FontWeight.w700, fontSize: AppSize.viewMargin),
              ),
              const SizedBox(height: AppSize.viewMargin),
              ListItemView(listItem: listItem),
              const SizedBox(height: AppSize.viewMargin),
              CustomButton(
                title: "Download PDF",
                onPressed: () {},
                buttonType: ButtonType.round,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ListItemView extends StatelessWidget {
  const ListItemView({super.key, required this.listItem});

  final List<ListViewModel> listItem;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppSize.inset),
        color: theme.colorScheme.primary.withOpacity(0.1),
      ),
      child: ListView.separated(
        itemCount: listItem.length,
        shrinkWrap: true,
        padding: const EdgeInsets.all(AppSize.inset),
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          return ListModel(
            data: listItem[index].key,
            value: listItem[index].value,
            copyText: listItem[index].copyText ?? false,
            dataTextStyle: listItem[index].dataTextStyle,
            valueTextStyle: listItem[index].valueTextStyle,
          );
        },
        separatorBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: AppSize.cornerRadiusMedium),
            child: Divider(color: theme.disabledColor),
          );
        },
      ),
    );
  }
}

class ListViewModel {
  final String key;
  final String value;
  final bool? copyText;
  final TextStyle? valueTextStyle;
  final TextStyle? dataTextStyle;
  ListViewModel({
    required this.key,
    required this.value,
    this.copyText,
    this.dataTextStyle,
    this.valueTextStyle,
  });
}
