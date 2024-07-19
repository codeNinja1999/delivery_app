part of 'faq_bloc.dart';

class FaqState extends Equatable {
  final FAQModel? faqModel;
  final FormStatus? status;
  FaqState({this.faqModel, status}) : status = (status != null) ? status : InitialStatus();

  FaqState copyWith({
    FAQModel? faqModel,
    FormStatus? status,
  }) {
    return FaqState(
      faqModel: faqModel ?? this.faqModel,
      status: status ?? this.status,
    );
  }

  @override
  List<Object?> get props => [faqModel, status];
}
