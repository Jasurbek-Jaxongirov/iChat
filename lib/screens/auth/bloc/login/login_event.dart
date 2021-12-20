part of 'login_bloc.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object> get props => [];
}

class UserLoggedIn extends LoginEvent {
  final String email;
  final String password;
  final Function() onSuccess;
  final Function(String message) onError;

  const UserLoggedIn({
    required this.email,
    required this.password,
    required this.onSuccess,
    required this.onError,
  });

  @override
  List<Object> get props => [email, password, onSuccess, onError];
  @override
  String toString() {
    return 'UserLoggedIn(email: $email, password: $password, onSuccess: $onSuccess, onError: $onError)';
  }
}

class UserSignedUp extends LoginEvent {
  final String email;
  final String password;
  final Function(String id) onSuccess;
  final Function(String message) onError;

  const UserSignedUp({
    required this.email,
    required this.password,
    required this.onSuccess,
    required this.onError,
  });
  @override
  List<Object> get props => [email, password, onSuccess, onError];
  @override
  String toString() {
    return 'UserSignedUp(email: $email, password: $password, onSuccess: $onSuccess, onError: $onError)';
  }
}

class UserUpdated extends LoginEvent {}

class UserSignInValidated extends LoginEvent {
  final String email;
  final String password;
  final Function() onSuccess;
  final Function(String message) onError;

  const UserSignInValidated({
    required this.email,
    required this.password,
    required this.onSuccess,
    required this.onError,
  });

  @override
  List<Object> get props => [email, password, onSuccess, onError];

  @override
  String toString() {
    return 'UserSignInValidated(email: $email, password: $password, onSuccess: $onSuccess, onError: $onError)';
  }
}

class UserSignUpValidated extends LoginEvent {
  final String name;
  final String username;
  final String email;
  final String bio;
  final String phoneNumber;
  final bool? isMale;
  final String password;
  final Function() onSuccess;
  final Function(String message) onError;

  const UserSignUpValidated({
    required this.name,
    required this.username,
    required this.email,
    required this.bio,
    required this.phoneNumber,
    required this.isMale,
    required this.password,
    required this.onSuccess,
    required this.onError,
  });

  @override
  String toString() {
    return 'UserSignUpValidated(name: $name, username: $username, email: $email, bio: $bio, phoneNumber: $phoneNumber, isMale: $isMale, password: $password, onSuccess: $onSuccess, onError: $onError)';
  }
}
