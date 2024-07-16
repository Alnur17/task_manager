class Urls {
  Urls._();

  static const String _baseUrl = 'https://task.teamrabbil.com/api/v1';
  static String registration = '$_baseUrl/registration';
  static String login = '$_baseUrl/login';
  static String createTask = '$_baseUrl/createTask';
  static String taskStatusCount = '$_baseUrl/taskStatusCount';
  static String tasks(String taskName) => '$_baseUrl/listTaskByStatus/$taskName';
  static String pendingTasks = '$_baseUrl/listTaskByStatus/InProgress';
  static String cancelledTasks = '$_baseUrl/listTaskByStatus/Cancelled';
  static String completedTasks = '$_baseUrl/listTaskByStatus/Completed';
  static String profileUpdate = '$_baseUrl/profileUpdate';
  static String deleteTasks(String id) => '$_baseUrl/deleteTask/$id';
  static String updateTasks(String id, String status) => '$_baseUrl/updateTaskStatus/$id/$status';
  static String sentOtpToEmail(String email) => '$_baseUrl/RecoverVerifyEmail/$email';
  static String verifyOtp(String email, String otp) => '$_baseUrl/RecoverVerifyOTP/$email/$otp';
  static String resetPassword = '$_baseUrl/RecoverResetPass';
}