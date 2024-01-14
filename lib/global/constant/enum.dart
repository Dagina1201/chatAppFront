enum StorageKeys { token }

enum AlertStatus { success }

enum SnackbarType { success, warning, error }

enum ChatTypes { TEAM, GROUP, ALL }
enum UserTypes { USER, ADMIN, TEACHER, SYSTEM }

enum MessageTypes {
  LINK,
  TEXT;

  String toJson() => name;
  static MessageTypes fromJson(String json) => values.byName(json);
}

enum AlertType { success, warning, error }
