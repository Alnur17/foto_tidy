class Api {
  /// base url
  //static const baseUrl = "http://206.162.244.133:5006/api/v1";
  static const baseUrl = "http://206.162.244.133:5014/api/v1";

  ///auth api
  static const register = "$baseUrl/users/register"; //
  static const login = "$baseUrl/auth/login"; //
  static const forgotPassword = "$baseUrl/auth/forget-password"; //
  static const otpVerify = "$baseUrl/otp/verify-otp"; //
  static const reSendOtp = "$baseUrl/otp/resend-otp"; //
  static const resetPassword = "$baseUrl/auth/reset-password"; //
  static const changePassword = "$baseUrl/auth/change-password"; //


  ///profile
  static const profile = "$baseUrl/users/my-profile"; //

}
