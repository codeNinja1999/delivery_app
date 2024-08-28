import 'dart:convert';

import 'package:fresh_fold_delivery/repository/data/otp/repository/mapping/send_otp_response_model_mapping.dart';
import 'package:fresh_fold_delivery/repository/data/user/data_store/data_store.dart';
import 'package:network/network.dart';
import 'package:either_dart/either.dart';

import 'package:fresh_fold_delivery/repository/data/core/core.dart';
import 'package:fresh_fold_delivery/repository/data/otp/repository/mapping/mapping.dart';
import '../../../domain/otp/entities/generate_otp.dart';
import '../../../domain/otp/entities/verify_otp.dart';
import '../../../domain/otp/repository/otp_repository.dart';
import '../model/forgot_password_send_otp/forgot_password_send_otp_response_model.dart';
import '../model/forgot_password_verify_otp/forgot_password_verify_otp_response_model.dart';
import '../model/resend_otp/resend_otp_response_model.dart';
import '../model/send_otp/send_otp_response_model.dart';
import '../model/verify_otp/verify_otp_response_model.dart';

class OtpRepositoryImpl implements OTPRepository {
  OtpRepositoryImpl({required this.networkClient,required  this.userNetworkClient}) : userCredentialStorage = UserCredentialDataStore();

  NetworkClient networkClient;
  NetworkClient userNetworkClient;
  
  UserCredentialDataStore userCredentialStorage;

  @override
  Future<Either<Exception, String>> generateRegisterOTP(GenerateOTP data) async {
    final requestData = data.toRegisterRequestData();
    final postBody = jsonEncode(requestData.toJson());
    try {
      final response = await networkClient.post(AppServiceEndpoints.generateRegisterOtp, body: postBody);
      final responseJson = json.decode(response.asString);
      final responseModel = SendOtpResponseModel.fromJson(responseJson);
      final credential = responseModel.toDomain();
      await userCredentialStorage.saveCredential(credential);

      return const Right("");
    } on Exception catch (error) {
      return Left(error);
    }
  }

  @override
  Future<Either<Exception, String>> verifyRegisterOTP(VerifyOTP verifyInfo) async {
    final requestData = verifyInfo.toRegisterRequestData();
    final postBody = jsonEncode(requestData.toJson());

    try {
      final response = await userNetworkClient.patch(AppServiceEndpoints.verifyRegisterOtp, body: postBody);
      final responseJson = json.decode(response.asString);
      final _ = VerifyOtpResponseModel.fromJson(responseJson);
      return const Right("");
    } on Exception catch (error) {
      return Left(error);
    }
  }

  @override
  Future<Either<Exception, String>> generateForgotPasswordOTP(GenerateOTP data) async {
    final requestData = data.toForgotPasswordGenerateOtp();
    final postBody = jsonEncode(requestData.toJson());
    try {
      final response = await networkClient.post(AppServiceEndpoints.generateForgotPasswordOtp, body: postBody);
      final responseJson = json.decode(response.asString);
      final _ = ForgotPasswordOtpResponseModel.fromJson(responseJson);
      return const Right("");
    } on Exception catch (error) {
      return Left(error);
    }
  }

  @override
  Future<Either<Exception, String>> verifyForgotPasswordOTP(VerifyOTP verifyInfo) async {
    final requestData = verifyInfo.toForgotPasswordVerifyOtp();
    final postBody = jsonEncode(requestData.toJson());

    try {
      final response = await networkClient.patch(AppServiceEndpoints.verifyForgotPassword, body: postBody);
      final responseJson = json.decode(response.asString);
      final _ = ForgotPasswordVerifyOtpResponseModel.fromJson(responseJson);
      return const Right("");
    } on Exception catch (error) {
      return Left(error);
    }
  }

  @override
  Future<Either<Exception, String>> resendOTP(GenerateOTP data) async {
    final requestData = data.toResendOtp();
    final postBody = jsonEncode(requestData.toJson());
    try {
      final response = await networkClient.post(AppServiceEndpoints.resendOtp, body: postBody);
      final responseJson = json.decode(response.asString);
      final _ = ResendOtpResponseModel.fromJson(responseJson);
      return const Right("Success");
    } on Exception catch (error) {
      return Left(error);
    }
  }
}
