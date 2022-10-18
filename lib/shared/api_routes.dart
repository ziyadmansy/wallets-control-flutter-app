///////////////////// Base URL /////////////////////
const String baseUrl = 'https://wallet.dotapps.net/api/v1';

class ApiRoutes {
  // Auth
  static const String register = '$baseUrl/registration';
  static const String login = '$baseUrl/login';
  static const String logout = '$baseUrl/logout';

  static const String profile = '$baseUrl/profile';
  static const String walletsBrands = '$baseUrl/wallet-brand';
  static const String plans = '$baseUrl/plans';
  static const String smsStore = '$baseUrl/message/store';
  static const String callLogs = '$baseUrl/call-log';
  static const String addWallet = '$baseUrl/wallets/store';
  static String deleteWallet(int id) => '$baseUrl/wallets/delete/$id';
}
