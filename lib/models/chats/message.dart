import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'message.g.dart';

@JsonSerializable()
class Message extends Equatable {
  @JsonKey(name: 'from', defaultValue: '')
  final String from;
  @JsonKey(name: 'to', defaultValue: '')
  final String to;
  @JsonKey(name: 'id', defaultValue: 0)
  final int id;
  @JsonKey(name: 'message', defaultValue: '')
  final String message;
  @JsonKey(name: 'created_at',defaultValue: '')
  final String createdAt;

  const Message({
    required this.from,
    required this.to,
    required this.id,
    required this.message,
    required this.createdAt,
  });

  factory Message.fromJson(Map<String, dynamic> json) =>
      _$MessageFromJson(json);
  Map<String, dynamic> toJson() => _$MessageToJson(this);
  @override
  List<Object> get props {
    return [
      from,
      to,
      id,
      message,
      createdAt,
    ];
  }

  @override
  String toString() {
    return 'Message(from: $from, to: $to, id: $id, message: $message, createdAt: $createdAt)';
  }
}
