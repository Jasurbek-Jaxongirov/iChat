part of 'connectivity_bloc.dart';

@immutable
abstract class ConnectivityEvent extends Equatable {}

class ConnectivityStatusChanged extends ConnectivityEvent {
  final ConnectivityResult result;

  ConnectivityStatusChanged(this.result);

  @override
  List<Object?> get props => [result];
}

class CheckConnection extends ConnectivityEvent {
  @override
  List<Object?> get props => [];
}
