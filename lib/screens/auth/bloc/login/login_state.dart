part of 'login_bloc.dart';

class LoginState extends Equatable {
  final String userId;
  final String userEmail;
  final String password;
  final SubmissionStatus status;
  const LoginState({
    required this.userId,
    required this.userEmail,
    required this.status,
    required this.password,
  });

  @override
  List<Object> get props => [userId, userEmail, status];

  LoginState copyWith({
    String? userId,
    String? userEmail,
    String? password,
    SubmissionStatus? status,
  }) {
    return LoginState(
      userId: userId ?? this.userId,
      userEmail: userEmail ?? this.userEmail,
      password: password ?? this.password,
      status: status ?? this.status,
    );
  }

  @override
  String toString() =>
      'LoginState(userId: $userId, userEmail: $userEmail, status: $status)';
}
