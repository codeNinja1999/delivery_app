import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:fresh_fold_delivery/repository/repository.dart';
import 'package:fresh_fold_delivery/sources/core/app_core.dart';
import '../pages/receiving_country/bloc/receiving_country_bloc.dart';

part 'beneficiary_event.dart';
part 'beneficiary_state.dart';

class BeneficiaryBloc extends Bloc<BeneficiaryEvent, BeneficiaryState> {
  BeneficiaryBloc() : super(BeneficiaryState()) {
    on<SavePersonalDetail>(
      (event, emit) {
        emit(state.copyWith(personalDetail: event.userPersonalDetail));
      },
    );

    on<SaveContactDetail>(
      (event, emit) => emit(state.copyWith(contactDetail: event.userContactDetail)),
    );

    on<SaveReceivingCountry>(
      (event, emit) => emit(state.copyWith(receivingCountry: event.receivingCountry)),
    );
    // on<SaveFullName>((event, emit) =>
    //     emit(state.copyWith(fullName: event.fullName, relation: event.relation, phoneNumber: event.phoneNumber)));

    on<SavePaymentMode>(
      (event, emit) => emit(state.copyWith(
        paymentMode: event.paymentMode,
        paymentType: event.paymentType,
      )),
    );

    on<SaveIdentityDetails>(
      (event, emit) => emit(state.copyWith(receiverIdentificationInfo: event.receiverIdentityDetails)),
    );
    on<SaveBankDetail>((event, emit) {
      final newState = state.copyWith(bankDetail: event.userBankDetail);
      emit(newState);
    });

    // on<SaveReceiverDetails>((event, emit) {
    //   final newState = state.copyWith(receiver: event.receiver);
    //   emit(newState);
    // });

    on<AddInitialData>((event, emit) {
      final isEdit = (event.receiver != null) ? true : false;
      final fromSendMoney = (event.receiverData != null) ? true : false;

      emit(
        state.copyWith(
          isEdit: isEdit,
          detailedReceiver: event.receiver,
          receiver: Receiver(
            receiverType: event.receiver?.receiverType ??
                Catalog(id: event.receiver?.receiverType?.id ?? "", value: event.receiver?.receiverType?.value ?? ""),
            contactInfo: event.receiver?.contactInfo,
            personalInfo: event.receiver?.personalInfo,
            defaultPayoutInfo: ReceiverPayoutInfo(
              mode: event.receiver?.defaultPayoutInfo?.mode,
              bank: event.receiver?.defaultPayoutInfo?.bank,
              branch: event.receiver?.defaultPayoutInfo?.branch,
              payoutPartner: event.receiver?.defaultPayoutInfo?.payoutPartner,
              currency: event.receiver?.defaultPayoutInfo?.currency,
              headOffice: event.receiver?.defaultPayoutInfo?.headOffice,
              accountType: event.receiver?.defaultPayoutInfo?.accountType,
              country: Catalog(
                id: event.receiver?.defaultPayoutInfo?.receivingCountry?.id ?? "",
                value: event.receiver?.defaultPayoutInfo?.receivingCountry?.value ?? "",
              ),
              accountNumber: event.receiver?.defaultPayoutInfo?.accountNumber,
            ),
            identificationInfo: event.receiver?.identificationInfo,
          ),
          fromSendMoney: fromSendMoney,
          initialData: event.receiverData,
          receivingCountry: (isEdit)
              ? event.receiver?.defaultPayoutInfo?.receivingCountry
              : event.receiverData?.receiverResult?.payoutInfo?.receivingCountry,
          paymentMode:
              (isEdit) ? event.receiver?.defaultPayoutInfo?.mode : event.receiverData?.receiverResult?.payoutInfo?.mode,
          paymentType: PaymentType.fromPaymentTypeCode(
            (isEdit)
                ? event.receiver?.defaultPayoutInfo?.mode?.remittanceMethodType ?? ""
                : event.receiverData?.receiverResult?.payoutInfo?.mode?.paymentType ?? "",
          ),
        ),
      );
    });

    // on<GetReceiverDetails>((event, emit) {
    //   final isEdit = (receiver != null) ? true : false;
    //   emit(state.copyWith(isEdit: isEdit, detailedReceiver: receiver,status: Success()));
    // });
  }

  @override
  Future<void> close() {
    // dispose
    return super.close();
  }
}
