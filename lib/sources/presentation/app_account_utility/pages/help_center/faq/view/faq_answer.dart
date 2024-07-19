// import 'package:flutter/material.dart';

// import '../../../../../../core/app_core.dart';
// import '../../../../../widgets/widgets.dart';
// import '../../help_center.dart';

// class FaqAnswerPage extends StatelessWidget {
//   const FaqAnswerPage({super.key, required this.answerModel});
//   final AnswerModel answerModel;

//   @override
//   Widget build(BuildContext context) {
//     final theme = Theme.of(context);
//     return Scaffold(
//       backgroundColor: theme.colorScheme.surface,
//       appBar: MyAppBar(
//         title: "FAQs",
//         backButtonAction: () => Navigator.of(context, rootNavigator: true).pop(),
//       ),
//       body: SingleChildScrollView(
//         padding: const EdgeInsets.symmetric(
//           horizontal: AppSize.inset,
//           vertical: AppSize.viewMargin,
//         ),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.stretch,
//           children: [
//             Text(
//               answerModel.question,
//               style: theme.textTheme.titleMedium?.copyWith(fontSize: 18, color: theme.colorScheme.primary),
//             ),
//             const SizedBox(height: AppSize.inset),
//             Text(
//               answerModel.answer,
//               style: theme.textTheme.titleMedium?.copyWith(
//                 fontSize: 18,
//                 fontWeight: FontWeight.w400,
//               ),
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }
