part of 'chat_bloc.dart';

class ChatState extends Equatable {
  final SubmissionStatus submissionStatus;
  final List<User> users;

  const ChatState({
    required this.submissionStatus,
    required this.users,
  });

  @override
  List<Object> get props => [submissionStatus, users];

  ChatState copyWith({
    SubmissionStatus? submissionStatus,
    List<User>? users,
  }) {
    return ChatState(
      submissionStatus: submissionStatus ?? this.submissionStatus,
      users: users ?? this.users,
    );
  }

  @override
  String toString() => 'ChatState(submissionStatus: $submissionStatus, users: $users)';
}
