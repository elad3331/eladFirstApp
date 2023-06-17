class MessageStore {
  static final MessageStore _instance = MessageStore._internal();

  factory MessageStore() {
    return _instance;
  }

  MessageStore._internal();

  Map<String, List<String>> clientMessages = {};
}
