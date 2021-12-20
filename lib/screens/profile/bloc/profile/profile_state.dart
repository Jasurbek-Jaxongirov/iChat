part of 'profile_bloc.dart';

class ProfileState extends Equatable {
  final User user;
  final SubmissionStatus submissionStatus;
  const ProfileState({
    required this.user,
    required this.submissionStatus,
  });

  ProfileState copyWith({
    User? user,
    SubmissionStatus? submissionStatus,
  }) {
    return ProfileState(
      user: user ?? this.user,
      submissionStatus: submissionStatus ?? this.submissionStatus,
    );
  }

  @override
  List<Object> get props => [user, submissionStatus];

  @override
  String toString() => 'ProfileState(user: $user)';
}
