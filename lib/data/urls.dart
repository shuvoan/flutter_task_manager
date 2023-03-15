class Urls{
  static String baseUrls='https://task.teamrabbil.com/api/v1';
  static String loginUrl='$baseUrls/login';
  static String registrationUrl='$baseUrls/registration';
  static String createNewTaskURl='$baseUrls/createTask';
  static String newTaskURl='$baseUrls/listTaskByStatus/New';
  static String completedTaskURl='$baseUrls/listTaskByStatus/Completed';
  static String cancelledTaskURl='$baseUrls/listTaskByStatus/Cancelled';
  static String progressTaskURl='$baseUrls/listTaskByStatus/Progress';

  static String changeTaskStatues(String taskId, String state) =>
      '$baseUrls/updateTaskStatus/$taskId/$state';
}