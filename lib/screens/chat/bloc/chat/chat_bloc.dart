import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:nabh_messenger/models/submission_status/submission_status.dart';
import 'package:nabh_messenger/models/user/user.dart';
import 'package:nabh_messenger/repositories/chat.dart';

part 'chat_event.dart';
part 'chat_state.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  final ChatRepository chatRepository;
  ChatBloc({
    required this.chatRepository,
  }) : super(
          const ChatState(
            submissionStatus: SubmissionStatus.pure,
            users: [],
          ),
        ) {
    on<ChattedUsersFetched>(
      (event, emit) async {
        emit(
          state.copyWith(
            submissionStatus: SubmissionStatus.waiting,
          ),
        );
        try {
          final users = await chatRepository.fetchUsers();
          emit(
            state.copyWith(
              submissionStatus: SubmissionStatus.succed,
              users: users,
            ),
          );
          event.onSuccess();
        } catch (error) {
          print(error);
          emit(
            state.copyWith(
              submissionStatus: SubmissionStatus.failed,
            ),
          );
          event.onError();
        }
      },
    );
  }
}
