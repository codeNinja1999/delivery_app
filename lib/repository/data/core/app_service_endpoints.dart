class AppServiceEndpoints {
  static const generateKey = "common/session-id";
  static const generateRegisterOtp = "auth/register";
  static const verifyRegisterOtp = "auth/verify-otp";
  static const register = "auth/me/complete-profile-registration";
  static const generateForgotPasswordOtp = "auth/forgot-password-otp";
  static const verifyForgotPassword = "auth/verify-forgot-password-otp";
  static const resetPassword = "auth/reset-password";
  static const verifyPendingOrder = "admin/dashboard/pending-confirmations/:id/verify";
  static const userUpdate = "admin/user";
  static const createOperator = "admin/operator";
  static const createLocation = "admin/location/create";
  static const updateLocation = "admin/location/3";
  static const updateService = "admin/service/3";
  static const createService = "admin/service/create";
  static const resendOtp =  "auth/resend-otp";
  static const updateUserProfile = "user/me/update-profile";
  static const login = "auth/login";
  static const logout = "auth/logout";

}
