import 'package:equatable/equatable.dart';

enum SubmissionStatus { pure, succed, failed, waiting }

class Submission extends Equatable {
  final SubmissionStatus status;

  const Submission({required this.status});

  @override
  List<Object?> get props => [status];


  @override
  String toString() => 'Submission(status: $status)';
}
