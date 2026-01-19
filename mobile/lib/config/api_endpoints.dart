class ApiEndpoints {
  static const otpRequest = "/auth/otp/request";
  static const otpVerify = "/auth/otp/verify";
  static const ridesCreate = "/rides";
  static const ridesEstimate = "/pricing/estimate";
  static const deliveriesRequest = "/deliveries/request";
  static const paymentsCharge = "/payments/charge";
  static const paymentsIntent = "/payments/intent";
  static const usersMe = "/users/me";

  static String rideById(String rideId) => "/rides/$rideId";
  static String rideCancel(String rideId) => "/rides/$rideId/cancel";
}
