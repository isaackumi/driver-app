class Endpoints {
  static const String BASE_URL = "https://food-server-verison.herokuapp.com/food-server/api/v1";

  static loginUrl() {
    return "$BASE_URL/login";
  }

  static emailVerificationUrl() {
    return "$BASE_URL/verification/mobile";
  }

  static changePasswordUrl() {
    return "$BASE_URL/change";
  }



  static resetPasswordUrl() {
    return "$BASE_URL/reset/mobile";
  }

  static getOrdersUrl(String id) {
    return "$BASE_URL/user/orders/$id";
  }



  static getMenu(String id) {
    return "$BASE_URL/products/$id";
  }


  static getRestaurantsUrl() {
    return "$BASE_URL/restaurants";
  }


  static makeOrders() {
    return "$BASE_URL/orders";
  }

  static sendFCMUrl(String id) {
    return "$BASE_URL/fcm/token/$id";
  }



}
