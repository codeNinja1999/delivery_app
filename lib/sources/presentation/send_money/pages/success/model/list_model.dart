import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/app_core.dart';
import '../bloc/send_money_success_bloc.dart';

class ListModel extends StatelessWidget {
  const ListModel({
    super.key,
    required this.data,
    this.copyText = false,
    required this.value,
    this.valueTextStyle,
    this.dataTextStyle,
  });
  final String data;
  final bool copyText;
  final String value;
  final TextStyle? valueTextStyle;
  final TextStyle? dataTextStyle;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          data,
          style: (dataTextStyle != null) ? dataTextStyle : theme.textTheme.bodyMedium,
        ),
        (copyText)
            ? BlocBuilder<SendMoneySuccessBloc, SendMoneySuccessState>(
                builder: (context, state) {
                  return Row(
                    children: [
                      (state.copyText)
                          ? Padding(
                              padding: const EdgeInsets.only(right: AppSize.cornerRadiusMedium),
                              child: Text(
                                LocaleKeys.copied.value,
                                style: theme.textTheme.titleMedium?.copyWith(
                                  color: theme.colorScheme.primary,
                                ),
                              ),
                            )
                          : Container(),
                      InkWell(
                        onTap: () {
                          Clipboard.setData(ClipboardData(text: value));
                          context.read<SendMoneySuccessBloc>().add(CopyTextChanged());
                        },
                        overlayColor: WidgetStateProperty.all(theme.colorScheme.shadow),
                        child: Row(
                          children: [
                            Text(value, style: theme.textTheme.titleSmall),
                            const SizedBox(width: AppSize.cornerRadiusMedium),
                            const Icon(Icons.copy),
                          ],
                        ),
                      ),
                    ],
                  );
                },
              )
            : Text(value, style: (valueTextStyle != null) ? valueTextStyle : theme.textTheme.titleSmall),
      ],
    );
  }
}
