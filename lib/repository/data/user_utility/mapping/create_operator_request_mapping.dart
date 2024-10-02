import '../../../domain/user/entities/user_info/user.dart';
import '../model/operator/create_operator_request_model.dart';

extension CreateOperatorRequestMapping on OperatorUser {
  CreateOperatorRequestModel toCreateOperator() {
    return CreateOperatorRequestModel(
      fullName: personalInfo?.fullName,
      phoneNumber: personalInfo?.phoneNumber,
      address: contactInfo?.address,
      emailAddress: personalInfo?.email,
      password: password,
      confirmPassword: confirmPassword,
    );
  }
}
