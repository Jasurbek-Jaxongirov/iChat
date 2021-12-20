import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:connectivity/connectivity.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'connectivity_event.dart';
part 'connectivity_state.dart';

class ConnectivityBloc extends Bloc<ConnectivityEvent, ConnectivityState> {
  ConnectivityBloc()
      : super(
          const ConnectivityState(connection: ConnectivityResult.none),
        ) {
    _connectivitySubscription = _connectivity.onConnectivityChanged.listen(
      (result) => add(
        ConnectivityStatusChanged(result),
      ),
    );
    on<ConnectivityStatusChanged>(
      (event, emit) {
        emit(
          state.copyWith(
            connection: event.result,
          ),
        );
      },
    );
    on<CheckConnection>(
      (event, emit) async {
        ConnectivityResult connectivityResult =
            await _connectivity.checkConnectivity();
        emit(
          state.copyWith(
            connection: connectivityResult,
          ),
        );
      },
    );
  }

  final Connectivity _connectivity = Connectivity();
  late StreamSubscription<ConnectivityResult> _connectivitySubscription;

  @override
  Future<void> close() {
    _connectivitySubscription.cancel();
    return super.close();
  }
}
