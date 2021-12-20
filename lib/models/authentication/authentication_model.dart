import 'package:equatable/equatable.dart';

enum AuthenticationStatus {
  unknown,
  authenticated,
  unauthenticated,
}

class AuthenticationModel extends Equatable{
  final AuthenticationStatus status;

  const AuthenticationModel({
    required this.status,
  });

  @override
  String toString() => 'AuthenticationModel(status: $status)';

  @override
  List<Object?> get props => [status];

}
