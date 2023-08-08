class Config {
  /// Pre-defined configurations for the app.

  // This constructor prevents instantiation and extension as this class meant be.
  Config._();
  // TODO: optional config in json format?
  static const appTitle = 'BEEZNESS';
  static const baseUrl = 'http://ourhoneybee.eu';
  // static const authUrl = 'http://192.168.68.107:5321';
  static const authUrl = 'http://194.195.244.141';
  static const loginPath = '$authUrl/login';
  static const logoutPath = '$authUrl/logout';
  static const attendancePath = '$authUrl/auto_attendance';
  static const serversPath = '$baseUrl/serverList.json';
  static const selectDataAjaxPath = '$authUrl/select_data_ajax';
  static const addExpensePath = '$authUrl/add_expense';
  static String getUserAccountPath(String? url) => '$url/get_users_by_query';
  static String? getUserImagePath(String? path) =>
      path == null ? null : '$authUrl/$path';
  static String getDesignation(int userType) => {
        'N/A',
        'Admin',
        'General User',
        'Supplier',
        'Client',
        'Management User',
        'Group Owner',
        'Entity User',
        'Applicant',
      }.elementAt(userType);
}
