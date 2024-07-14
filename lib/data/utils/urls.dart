class Urls {
  Urls._();

  static const String _baseUrl = 'https://task.teamrabbil.com/api/v1';
  static String registration = '$_baseUrl/registration';
  static String login = '$_baseUrl/login';
  static String createTask = '$_baseUrl/createTask';
  static String taskStatusCount = '$_baseUrl/taskStatusCount';
  static String newTasks = '$_baseUrl/listTaskByStatus/new';
  static String pendingTasks = '$_baseUrl/listTaskByStatus/inProgress';
  static String cancelledTasks = '$_baseUrl/listTaskByStatus/cancelled';
  static String completedTasks = '$_baseUrl/listTaskByStatus/completed';
  static String deleteTasks(String id) => '$_baseUrl/deleteTask/$id';
  static String updateTasks(String id, String status) => '$_baseUrl/updateTaskStatus/$id/$status';
}