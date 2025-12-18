class Api {
  /// base url
  static const baseUrl = "http://138.68.242.180:5001/api/v1";
  //static const baseUrl = "http://74.118.168.203:5014/api/v1";
  //static const baseUrl = "https://48c15380570c.ngrok-free.app/api/v1";

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
  static deleteTag(String tagId) => "$baseUrl/tags/$tagId"; //done
  static transferPhotoFormTag(String formTagId) => "$baseUrl/tags/transfer-photos/$formTagId"; //done
  static const settings = "$baseUrl/contents"; //done
  static const favorite = "$baseUrl/favorite/my-favorite"; //done
  static const addFavorite = "$baseUrl/favorite"; //done
  static removeFavorite(String photoId) => "$baseUrl/favorite/photo/$photoId"; //done

  ///Subscription and payments
  static const mySubscription = "$baseUrl/subscriptions/my-subscriptions"; //done
  static const subscriptionPackages = "$baseUrl/packages"; //done
  static const buySubscription = "$baseUrl/subscriptions"; //done
  static const createPayment = "$baseUrl/payments/checkout"; //done
  static const freeTrial = "$baseUrl/users/enabled-free-tier"; //

  /// Upload Photos
  static const uploadFromCameraPhotos = "$baseUrl/uploads/single"; //done
  static const uploadSinglePhotos = "$baseUrl/upload-photos"; //done
  static const uploadPhotos = "$baseUrl/uploads/multiple"; //done
  static const uploadBadgePhotos = "$baseUrl/upload-photos/batch-upload"; //done
  static deletePhoto(String photoId) => "$baseUrl/upload-photos/$photoId"; //

  ///Gallery and Home
  static const myGallery = "$baseUrl/upload-photos/my-photos"; //done
  static getPhotoByTagId(String tagId) => "$baseUrl/upload-photos/tags/$tagId"; //done
  static const setGalleryLock = "$baseUrl/gallery-lock/add-key"; //done
  static const unlockGallery = "$baseUrl/gallery-lock/access-journal"; //done
  static const changeGalleryLock = "$baseUrl/gallery-lock/change-key"; //done
  static const deleteGalleryLock = "$baseUrl/gallery-lock/delete-key"; //done
  static const notification = "$baseUrl/notification"; //done

}
