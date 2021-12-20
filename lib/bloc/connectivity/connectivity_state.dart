part of 'connectivity_bloc.dart';

class ConnectivityState extends Equatable {
  final ConnectivityResult connection;

  const ConnectivityState({required this.connection});

  ConnectivityState copyWith({
    ConnectivityResult? connection,
  }) {
    return ConnectivityState(
      connection: connection ?? this.connection,
    );
  }

  @override
  List<Object?> get props => [connection];

  @override
  String toString() => 'ConnectivityState(connection: $connection)';
}
