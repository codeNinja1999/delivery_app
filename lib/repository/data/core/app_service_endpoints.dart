class AppServiceEndpoints {
  static const login = "auth/login";
  static const logout = "auth/logout";
  static const resendOtp = "auth/resend-otp";
  static const generateRegisterOtp = "auth/register";
  static const verifyRegisterOtp = "auth/verify-otp";
  static const resetPassword = "auth/reset-password";
  static const changeUserPassword = "auth/me/change-password";
  static const register = "auth/me/complete-profile-registration";
  static const generateForgotPasswordOtp = "auth/forgot-password-otp";
  static const verifyForgotPassword = "auth/verify-forgot-password-otp";
  static const getDetails = "auth/me";

  static const location = "locations";
  static const fetchService = "laundry/services";

  static const userUpdate = "admin/user";
  static const verifyPendingOrder = "admin/dashboard/pending-confirmations/:id/verify";
  static const getAllPendingOrder = "admin/dashboard/pending-confirmations";
  static const fetchLocation = "admin/dashboard/locations";
  static const registerOperator = "admin/operator";
  static const createLocation = "admin/location/create";
  static const updateLocation = "admin/location/";
  static const deleteLocation = "admin/location/";
  static const fetchServiceType = "admin/dashboard/services";
  static const updateService = "admin/service/";
  static const deleteService = "admin/service/";
  static const createService = "admin/service/create";
  static const getAllUser = "admin/dashboard/users";
  static const getAllOperator = "admin/dashboard/operators";
  static const getAnalyticsData = "admin/dashboard/analytics";

  static const updateUserProfile = "user/me/update-profile";
  static const createPickupRequest = "user/order/create";
  static const getAllOrder = "user/order/all";
  static const getOneTransaction = "user/order/:id";

  static const getAllPickup = "operator/order/pick-ups";
  static const getOnePickup = "operator/order/pick-ups/:id";
  static const getOrderHistory = "operator/order/history";
  static const verifyPickupOrder = "operator/order/pick-ups/:id/verify";
  static const acceptPickup = "operator/order/pick-ups/:id/accept";
  static const acceptDeliveries = "operator/order/deliveries/:id/accept";
  static const completeDeliveries = "operator/order/deliveries/:id/complete";
  static const getAllDeliveries = "operator/order/deliveries";
  static const getOneDeliveries = "operator/order/deliveries/:id";
}
