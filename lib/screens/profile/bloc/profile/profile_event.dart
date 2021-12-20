part of 'profile_bloc.dart';

abstract class ProfileEvent extends Equatable {
  const ProfileEvent();

  @override
  List<Object> get props => [];
}

class UserDataTaken extends ProfileEvent {
  final Function() onSuccess;
  final Function(String errorMessage) onFail;

  const UserDataTaken({
    required this.onSuccess,
    required this.onFail,
  });
  @override
  List<Object> get props => [
        onSuccess,
        onFail,
      ];
  @override
  String toString() => 'UserDataTaken(onSuccess: $onSuccess, onFail: $onFail)';
}

class UserCreated extends ProfileEvent {
  final Function() onSuccess;
  final Function(String message) onError;
  final String email;
  final String password;
  final User user;
  const UserCreated({
    required this.onSuccess,
    required this.onError,
    required this.email,
    required this.password,
    required this.user, 
  });

  @override
  List<Object> get props => [email, password, onSuccess, onError];
  @override
  String toString() {
    return 'UserCreated(onSuccess: $onSuccess, onError: $onError, email: $email, password: $password)';
  }
}
