import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:nabh_messenger/data/singletons/storage.dart';
import 'package:nabh_messenger/models/authentication/authentication_model.dart';
import 'package:nabh_messenger/models/user/user.dart' as user;
import 'package:nabh_messenger/screens/auth/bloc/login/login_bloc.dart';

class AuthenticationRepository {
  final _controller = StreamController<AuthenticationStatus>();
  var auth = FirebaseAuth.instance;
  Stream<AuthenticationStatus> get status async* {
    await StorageRepository.getInstance();
    await Future.delayed(const Duration(milliseconds: 1500));
    yield AuthenticationStatus.unauthenticated;
    // ignore: avoid_print
    print(StorageRepository.getString('token'));
    yield* _controller.stream;
  }

  Future<User?> loginUser(UserLoggedIn event) async {
    try {
      var result = await auth.signInWithEmailAndPassword(
        email: event.email,
        password: event.password,
      );
      return result.user;
    } catch (error) {
      rethrow;
    }
  }

  Future<User?> signupUser(UserSignedUp event) async {
    try {
      var result = await auth.createUserWithEmailAndPassword(
        email: event.email,
        password: event.password,
      );

      if (result.user == null) {
        throw 'Foydalanuvchi ro`yxatdan o`tkazilmadi. Iltimos, qayta urinib ko`ring!';
      }
      return result.user;
    } catch (error) {
      rethrow;
    }
  }
}
