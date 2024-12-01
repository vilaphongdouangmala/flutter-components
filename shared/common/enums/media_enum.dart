import 'package:monthol_mobile/shared/common/enums/chat_enums.dart';

enum MediaPlayerType {
  image,
  video,
}

extension MediaPlayerTypeExtension on MediaPlayerType {
  String get name {
    switch (this) {
      case MediaPlayerType.image:
        return 'Image';
      case MediaPlayerType.video:
        return 'Video';
    }
  }

  static MediaPlayerType fromChatMessageType(ChatMessageType chatMessageType) {
    switch (chatMessageType) {
      case ChatMessageType.image:
        return MediaPlayerType.image;
      case ChatMessageType.video:
        return MediaPlayerType.video;
      default:
        throw Exception('Invalid ChatMessageType');
    }
  }
}
