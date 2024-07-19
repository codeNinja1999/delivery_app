import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../di/injector.dart';
import '../receipt.dart';

class ReceiptRouter {
  static Route<dynamic> onGenerateRoute(RouteSettings settings, BuildContext context) {
    switch (settings.name) {
      case ReceiptRoute.depositMethod:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => sl<DepositBankBloc>(),
            child: const DepositBankPage(),
          ),
        );
      case ReceiptRoute.uploadReceipt:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => sl<UploadReceiptBloc>(),
            child: const UploadReceiptPage(),
          ),
        );

      case ReceiptRoute.confirmReceipt:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => sl<ConfirmReceiptBloc>(),
            child: const ConfirmReceiptPage(),
          ),
        );

      default:
        return MaterialPageRoute(
          builder: (_) => Container(),
        );
    }
  }
}
