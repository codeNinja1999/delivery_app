import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../di/injector.dart';
import '../current_address/current_address.dart';
import '../document_back/document_back.dart';
import '../document_front/document_front.dart';
import '../document_information/document_information.dart';
import '../document_thickness/document.thickness.dart';
import '../id_selection/id_selection.dart';
import '../instruction/instruction.dart';
import '../personal_information/personal_information.dart';
import '../selfie/selfie.dart';
import 'kyc_verification_route.dart';

class KycVerificationRouter {
  static Route<dynamic> onGenerateRoute(RouteSettings settings, BuildContext context) {
    switch (settings.name) {
      case KycVerificationRoute.instruction:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (_) => sl<VerificationInstructionBloc>(),
            child: const VerificationInstructionPage(),
          ),
        );

      case KycVerificationRoute.idSelection:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (_) => sl<IdSelectionBloc>(),
            child: const IdSelectionPage(),
          ),
        );

      case KycVerificationRoute.documentInformation:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (_) => sl<DocumentInformationBloc>(),
            child: const DocumentInformationPage(),
          ),
        );

      case KycVerificationRoute.documentFront:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (_) => sl<DocumentFrontBloc>(),
            child: const DocumentFrontPage(),
          ),
        );

      case KycVerificationRoute.confirmFrontDocument:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (_) => sl<DocumentFrontBloc>(),
            child: const ConfirmFrontDocumentPage(),
          ),
        );

      case KycVerificationRoute.confirmThicknessDocument:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (_) => sl<DocumentThicknessBloc>(),
            child: const ConfirmThicknessDocumentPage(),
          ),
        );

      case KycVerificationRoute.documentThickness:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (_) => sl<DocumentThicknessBloc>(),
            child: const DocumentThicknessPage(),
          ),
        );

      case KycVerificationRoute.documentBack:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (_) => sl<DocumentBackBloc>(),
            child: const DocumentBackPage(),
          ),
        );

      case KycVerificationRoute.confirmBackDocument:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (_) => sl<DocumentBackBloc>(),
            child: const ConfirmBackDocumentPage(),
          ),
        );

      case KycVerificationRoute.confirmSelfiePage:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => sl<SelfiePageBloc>(),
            child: const ConfirmSelfiePage(),
          ),
        );

      case KycVerificationRoute.personalInformation:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (_) => sl<PersonalInformationBloc>(),
            child: const PersonalInformationPage(),
          ),
        );

      case KycVerificationRoute.currentAddress:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (_) => sl<CurrentAddressBloc>(),
            child: const CurrentAddressPage(),
          ),
        );

      case KycVerificationRoute.selfiePage:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => sl<SelfiePageBloc>(),
            child: const SelfiePage(),
          ),
        );

      default:
        return MaterialPageRoute(
          builder: (_) => Container(color: Colors.red),
        );
    }
  }
}
