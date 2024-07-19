import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:fresh_fold_delivery/sources/route/route.dart';
import 'package:fresh_fold_delivery/sources/core/app_core.dart';
import 'package:fresh_fold_delivery/repository/data/core/core.dart';
import '../bloc/splash_bloc.dart';
import 'maintenance_view.dart';
import 'new_update_view.dart';
import 'retry_view.dart';
import 'splash_loading_view.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    context.read<SplashBloc>().add(GenerateKey());
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async {
    switch (state) {
      case AppLifecycleState.resumed:
        if (ModalRoute.of(context)?.isCurrent ?? false) {
          final status = context.read<SplashBloc>().state.status;
          if (status is! InProgress) {
            context.read<SplashBloc>().add(GenerateKey());
          }
        }
        break;
      default:
        break;
    }
  }

  @override
  void dispose() {
    super.dispose();
    WidgetsBinding.instance.removeObserver(this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: BlocConsumer<SplashBloc, SplashState>(
        listener: (context, state) {
          if (state.status is Success) {
            Navigator.pushNamed(context, AppRoute.login);
          } else if (state.status is InitialLaunchSuccess) {
            Navigator.pushNamed(context, AppRoute.starting);
          }
        },
        builder: (context, state) {
          final status = state.status;
          if (status is UpdateAvailable) {
            return const NewUpdateView();
          } else if (status is AppUnderMaintenance) {
            return MaintenanceView(message: status.message);
          } else if (status is SubmissionFailure) {
            return BasicRetryView(message: status.error.exceptionMessage);
          } else {
            return const SplashLoadingView();
          }
        },
      ),
    );
  }
}
