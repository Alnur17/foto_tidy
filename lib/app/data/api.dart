class Api {
  /// base url
  static const baseUrl = "http://74.118.168.203:5014/api/v1";

  ///auth api
  static const register = "$baseUrl/users/register"; //done
  static const login = "$baseUrl/auth/login"; //done
  static const forgotPassword = "$baseUrl/auth/forget-password"; //done
  static const otpVerify = "$baseUrl/otp/verify-otp"; //done
  static const reSendOtp = "$baseUrl/otp/resend-otp"; //done
  static const resetPassword = "$baseUrl/auth/reset-password"; //done
  static const changePassword = "$baseUrl/auth/change-password"; //done


  ///profile
  static const profile = "$baseUrl/users/my-profile"; //done
  static const editProfile = "$baseUrl/users/update-my-profile"; //done
  static const allTags = "$baseUrl/tags"; //done
  static const addTags = "$baseUrl/tags"; //done
  static editTag(String tagId) => "$baseUrl/tags/$tagId"; //done
  static deleteTag(String tagId) => "$baseUrl/tags/$tagId"; //
  static const settings = "$baseUrl/contents"; //done
  static const subscriptionPackages = "$baseUrl/packages"; //done
  static const buySubscription = "$baseUrl/subscriptions"; //done
  static const createPayment = "$baseUrl/payments/checkout"; //done

  ///Gallery and Home
  static const myGallery = "$baseUrl/upload-photos/my-photos"; //done
  static getPhotoByTagId(String tagId) => "$baseUrl/upload-photos/tags/$tagId"; //done

}
