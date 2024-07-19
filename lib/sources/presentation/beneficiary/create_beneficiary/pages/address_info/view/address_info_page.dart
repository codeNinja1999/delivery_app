import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:fresh_fold_delivery/sources/presentation/widgets/widgets.dart';
import '../../../bloc/beneficiary_bloc.dart';
import '../bloc/address_info_bloc.dart';
import 'address_info_view.dart';

class AddressInfoPage extends StatefulWidget {
  const AddressInfoPage({super.key});

  @override
  State<AddressInfoPage> createState() => _AddressInfoPageState();
}

class _AddressInfoPageState extends State<AddressInfoPage> {
  @override
  void initState() {
    super.initState();
    setContactInfo();
  }

  setContactInfo() {
    final mainState = context.read<BeneficiaryBloc>().state;
    final bloc = context.read<AddressInfoBloc>();
    if (mainState.isEdit || mainState.fromSendMoney) {
      bloc.add(
        GetReceiver(
          isEdit: mainState.isEdit,
          detailedReceiver: mainState.detailedReceiver,
          fromSendMoney: mainState.fromSendMoney,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: const MyAppBar(title: "Beneficiary"),
      body: const AddressInfoView(),
    );
  }
}
