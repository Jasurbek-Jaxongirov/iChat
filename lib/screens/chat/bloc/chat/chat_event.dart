part of 'chat_bloc.dart';

abstract class ChatEvent extends Equatable {
  const ChatEvent();

  @override
  List<Object> get props => [];
}

class ChattedUsersFetched extends ChatEvent {
  final Function() onSuccess;
  final Function() onError;

  const ChattedUsersFetched({
    required this.onSuccess,
    required this.onError,
  });
  @override
  List<Object> get props => [onSuccess, onError];
  @override
  String toString() =>
      'GetChattedUsers(onSuccess: $onSuccess, onError: $onError)';
}
