import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:nabh_messenger/models/submission_status/submission_status.dart';
import 'package:nabh_messenger/models/user/user.dart';
import 'package:nabh_messenger/repositories/user.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  UserRepository userRepository;
  ProfileBloc({required this.userRepository})
      : super(
          ProfileState(
            submissionStatus: SubmissionStatus.pure,
            user: User.fromJson(const {}),
          ),
        ) {
    on<UserDataTaken>(
      (event, emit) async {
        print('came4');
        emit(
          state.copyWith(
            submissionStatus: SubmissionStatus.waiting,
          ),
        );
        final user = await userRepository.tryGetUser();
        print('came6');
        try {
          print('came7');
          emit(
            state.copyWith(
              submissionStatus: SubmissionStatus.succed,
              user: user,
            ),
          );
          event.onSuccess();
        } catch (error) {
          print('came8');
          emit(
            state.copyWith(
              submissionStatus: SubmissionStatus.failed,
            ),
          );
          event.onFail(error.toString());
        }
      },
    );
    on<UserCreated>(
      (event, emit) async {
        emit(
          state.copyWith(
            submissionStatus: SubmissionStatus.waiting,
          ),
        );
        try {
          await userRepository.tryCreateUser(event.user);
          emit(
            state.copyWith(
              submissionStatus: SubmissionStatus.succed,
              user: event.user,
              
            ),
          );
          event.onSuccess();
        } catch (e) {
          emit(
            state.copyWith(
              submissionStatus: SubmissionStatus.failed,
            ),
          );
          event.onError(e.toString());
        }
      },
    );
  }
}
