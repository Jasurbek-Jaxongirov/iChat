import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:nabh_messenger/models/submission_status/submission_status.dart';
import 'package:nabh_messenger/repositories/auth.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final _authenticationRepository = AuthenticationRepository();
  LoginBloc()
      : super(
          const LoginState(
            status: SubmissionStatus.pure,
            userEmail: '',
            userId: '',
            password: '',
          ),
        ) {
    on<UserSignInValidated>(
      (event, emit) {
        try {
          if (event.email.isEmpty) {
            throw Exception('Mail manzili bo`sh bo`lishi mumkin emas!');
          }
          if (event.password.isEmpty) {
            throw Exception('Parol bo`sh bo`lishi mumkin emas!');
          }
          emit(
            state.copyWith(
              status: SubmissionStatus.succed,
            ),
          );
          event.onSuccess();
        } catch (error) {
          emit(
            state.copyWith(
              status: SubmissionStatus.failed,
            ),
          );
          event.onError(error.toString());
        }
      },
    );
    on<UserLoggedIn>(
      (event, emit) async {
        emit(
          state.copyWith(
            status: SubmissionStatus.waiting,
          ),
        );
        try {
          final response = await _authenticationRepository.loginUser(event);
          if (response == null) {
            throw Exception('Bunday foydalanuvchi topilmadi!');
          } else {
            emit(
              state.copyWith(
                status: SubmissionStatus.succed,
                userEmail: response.email,
                userId: response.uid,
              ),
            );
            event.onSuccess();
          }
        } catch (e) {
          emit(
            state.copyWith(
              status: SubmissionStatus.failed,
            ),
          );
          event.onError(e.toString());
        }
      },
    );
    on<UserSignUpValidated>(
      (event, emit) {
        try {
          if (event.name.isEmpty) {
            throw 'Ism bo`sh bo`lishi mumkin emas!';
          } else if (event.name.length < 3) {
            throw 'Ism 3 ta harfdan kam bo`lishi mumkin emas!';
          }
          if (event.username.isEmpty) {}
          if (event.email.isEmpty) {
            throw 'Mail manzili bo`sh bo`lishi mumkin emas!';
          }
          if (event.bio.isEmpty) {}
          if (event.phoneNumber.isEmpty) {}
          if (event.password.isEmpty) {
            throw 'Parol bo`sh bo`lishi mumkin emas!';
          }
          if (event.isMale == null) {
            throw 'Jins belgilanmasligi mumkin emas!';
          }
          emit(
            state.copyWith(
              status: SubmissionStatus.succed,
              userEmail: event.email,
              password: event.password,
            ),
          );
          event.onSuccess();
        } catch (error) {
          emit(
            state.copyWith(
              status: SubmissionStatus.failed,
            ),
          );
          event.onError(error.toString());
        }
      },
    );
    on<UserSignedUp>(
      (event, emit) async {
        emit(
          state.copyWith(
            status: SubmissionStatus.waiting,
          ),
        );
        try {
          final response = await _authenticationRepository.signupUser(event);
          if (response == null) {
            throw 'Foydalanuvchi ro`yxatdan o`tkazilishida muammoga duch kelindi. Iltimos, qayta urinib ko`ring!';
          } else {
            emit(
              state.copyWith(
                status: SubmissionStatus.succed,
                userEmail: event.email,
                password: event.password,
                userId: response.uid,
              ),
            );
            event.onSuccess(response.uid);
          }
        } catch (e) {
          emit(
            state.copyWith(
              status: SubmissionStatus.failed,
            ),
          );
          event.onError(e.toString());
        }
      },
    );
  }
}
