// import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';

// import '../../../core/app_core.dart';
// import '../widgets.dart';

// class CurrencyChangerPage extends StatefulWidget {
//   const CurrencyChangerPage({super.key});

//   @override
//   State<CurrencyChangerPage> createState() => _CurrencyChangerPageState();
// }

// class _CurrencyChangerPageState extends State<CurrencyChangerPage> {
//   List<Currency> currencyList = [
//     Currency(1, "npl.svg", LocaleKeys.nepal.value, 'NPR', false),
//     Currency(2, "usa.svg", LocaleKeys.english.value, 'USD', false),
//     Currency(3, "gbr.svg", "Great Britain", 'GBP', false),
//     Currency(4, "brn.svg", "Brunei", 'BND', false),
//   ];

//   @override
//   Widget build(BuildContext context) {
//     final ThemeData theme = Theme.of(context);
//     return Scaffold(
//       backgroundColor: Theme.of(context).scaffoldBackgroundColor,
//       appBar: const MyAppBar(title: "Change Currency"),
//       body: SingleChildScrollView(
//         padding: const EdgeInsets.symmetric(
//           horizontal: AppSize.inset,
//           vertical: AppSize.viewSpacing,
//         ),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.stretch,
//           children: [
//             Text(
//               "MOST POPULAR",
//               style: theme.textTheme.titleMedium?.copyWith(
//                 color: theme.colorScheme.primary,
//                 letterSpacing: 2.2,
//               ),
//             ),
//             const SizedBox(height: AppSize.viewMargin),
//             ListView.separated(
//               shrinkWrap: true,
//               padding: EdgeInsets.zero,
//               itemCount: currencyList.length,
//               separatorBuilder: (context, index) => Divider(
//                 color: theme.disabledColor.withOpacity(0.2),
//               ),
//               itemBuilder: (BuildContext context, int index) {
//                 Currency currency = currencyList[index];
//                 return ListTile(
//                   contentPadding: EdgeInsets.zero,
//                   leading: ClipRRect(
//                     borderRadius: BorderRadius.circular(100),
//                     child: SvgPicture.network(
//                       "${AppConstants.countryImageUrl}${currency.flag}",
//                       height: 30,
//                       width: 30,
//                     ),
//                   ),
//                   title: Text(
//                     currency.name,
//                     style: Theme.of(context).textTheme.bodyLarge,
//                   ),
//                   trailing: (currency.selectCurrency)
//                       ? Icon(
//                           Icons.check,
//                           size: 24,
//                           color: theme.colorScheme.primary,
//                         )
//                       : null,
//                   onTap: () => Navigator.of(context).pop(currency),
//                 );
//               },
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
