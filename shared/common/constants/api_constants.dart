class ApiConstants {
  static String baseApiUrl = '/api/';

  // auth
  static String login = 'api-token-auth/';

  // customers
  static String customerBaseUrl = 'customers';
  static String customers = '$customerBaseUrl/';
  static String customerChatSocket = 'chat-server/customer';
  static String getMessages = 'get-messages/';
  static String allChatServer = 'all-chat-server/';

  // license plates
  static String licensePlateBaseUrl = 'license-plates';
  static String licensePlates = '$licensePlateBaseUrl/';

  // staffs
  static String staffBaseUrl = 'staff';
  static String staff = '$staffBaseUrl/';

  // address
  static String provinces = 'provinces/';
  static String districts = 'districts/';
  static String subdistricts = 'subdistricts/';
}
