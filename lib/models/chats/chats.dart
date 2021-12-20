import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:nabh_messenger/models/chats/message.dart';

part 'chats.g.dart';

@JsonSerializable()
class ChatsResponse extends Equatable {
  @JsonKey(name: 'chats', defaultValue: [])
  final List<Chat> chats;

  const ChatsResponse({
    required this.chats,
  });

  factory ChatsResponse.fromJson(Map<String, dynamic> json) =>
      _$ChatsResponseFromJson(json);
  Map<String, dynamic> toJson() => _$ChatsResponseToJson(this);

  @override
  String toString() => 'ChatsResponse(chats: $chats)';

  @override
  List<Object?> get props => [chats];
}

@JsonSerializable()
class Chat extends Equatable {
  @JsonKey(name: 'id',defaultValue: '')
  final String id;
  @JsonKey(name: 'from',defaultValue: '')
  final String from;
  @JsonKey(name:'to', defaultValue:'')
  final String to;
  @JsonKey(name: 'created_at',defaultValue: '')
  final String createdAt;
  @JsonKey(name: 'messages',defaultValue: [])
  final List<Message> messages;

  const Chat({
    required this.id,
    required this.from,
    required this.to,
    required this.createdAt,
    required this.messages,
  });

  factory Chat.fromJson(Map<String, dynamic> json) =>
      _$ChatFromJson(json);
  Map<String, dynamic> toJson() => _$ChatToJson(this);
  @override
  String toString() {
    return 'Chat(id: $id, from: $from, to: $to, createdAt: $createdAt, messages: $messages)';
  }

  @override
  List<Object?> get props => [id, from, to, createdAt, messages];
}
