import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:nabh_messenger/models/user/user.dart' as users;

class ChatRepository {
  Future<List<users.User>> fetchUsers() async {
    final response = await FirebaseFirestore.instance.collection('users').get();
    try {
      return [
        ...response.docs
            .map(
              (e) => users.User.fromJson(
                e.data(),
              ),
            )
            .toList(),
      ];
    } catch (error) {
      rethrow;
    }
  }
}
