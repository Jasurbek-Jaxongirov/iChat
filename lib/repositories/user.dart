import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:nabh_messenger/models/user/user.dart' as users;
import 'package:nabh_messenger/screens/auth/bloc/login/login_bloc.dart';

class UserRepository {
  Future<users.User> tryGetUser() async {
    users.User user = users.User.fromJson(const {});
    try {
      if (FirebaseAuth.instance.currentUser != null) {
        final response = await FirebaseFirestore.instance
            .collection('users')
            .doc(
              FirebaseAuth.instance.currentUser!.uid,
            )
            .get();
        if (response.data() == null) {
          throw Exception('Bunday foydalanuvchi topilmadi!');
        }
        user = users.User.fromJson(response.data() as Map<String, dynamic>);
      }
      return user;
    } catch (error) {
      rethrow;
    }
  }

  Future<void> tryCreateUser(users.User newUser) async {
    try {
      await FirebaseFirestore.instance.collection('users').doc(newUser.id).set(
            newUser.toJson(),
          );
    } catch (e) {
      rethrow;
    }
  }
}
