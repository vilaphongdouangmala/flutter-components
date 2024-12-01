enum ChatMessageType { text, image, video, file }

extension ChatMessageTypeExtension on ChatMessageType {
  int get value {
    switch (this) {
      case ChatMessageType.text:
        return 0;
      case ChatMessageType.image:
        return 1;
      case ChatMessageType.video:
        return 2;
      case ChatMessageType.file:
        return 3;
    }
  }

  static ChatMessageType fromValue(int value) {
    switch (value) {
      case 0:
        return ChatMessageType.text;
      case 1:
        return ChatMessageType.image;
      case 2:
        return ChatMessageType.video;
      case 3:
        return ChatMessageType.file;
      default:
        throw Exception('Invalid ChatMessageType value');
    }
  }
}
