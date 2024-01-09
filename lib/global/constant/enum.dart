enum StorageKeys { token }

enum AlertStatus { success }

enum SnackbarType { success, warning, error }

enum ChatTypes { TEAM, GROUP }

enum MessageTypes {
  LINK,
  TEXT;

  String toJson() => name;
  static MessageTypes fromJson(String json) => values.byName(json);
}

enum AlertType { success, warning, error }
