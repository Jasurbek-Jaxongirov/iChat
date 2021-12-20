import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import 'package:nabh_messenger/models/post/post.dart';

part 'user.g.dart';

@JsonSerializable()
class User extends Equatable {
  @JsonKey(name: 'id', defaultValue: '')
  final String id;
  @JsonKey(name: 'name', defaultValue: '')
  final String name;
  @JsonKey(name: 'mail', defaultValue: '')
  final String mail;
  @JsonKey(name: 'username', defaultValue: '')
  final String username;
  @JsonKey(name: 'bio', defaultValue: '')
  final String bio;
  @JsonKey(name: 'is_male', defaultValue: true)
  final bool isMale;
  @JsonKey(name: 'mahrams', defaultValue: [])
  final List<String> mahrams;
  @JsonKey(name: 'phone_number', defaultValue: '')
  final String phoneNumber;
  @JsonKey(name: 'image_url', defaultValue: '')
  final String imageUrl;
  @JsonKey(name: 'posts', defaultValue: [])
  final List<Post> posts;
  @JsonKey(name: 'joined_at', defaultValue: '')
  final String joinedAt;
  const User({
    required this.id,
    required this.name,
    required this.username,
    required this.bio,
    required this.isMale,
    required this.mahrams,
    required this.phoneNumber,
    required this.mail,
    required this.imageUrl,
    required this.posts,
    required this.joinedAt,
  });

  factory User.fromJson(Map<String, dynamic> data) => _$UserFromJson(data);
  Map<String, dynamic> toJson() => _$UserToJson(this);

  @override
  List<Object?> get props =>
      [id, name, username, bio, isMale, mahrams, phoneNumber, posts, joinedAt];

  @override
  String toString() {
    return 'User(id: $id, name: $name, mail: $mail, username: $username, bio: $bio, isMale: $isMale, mahrams: $mahrams, phoneNumber: $phoneNumber, imageUrl: $imageUrl, posts: $posts, joinedAt: $joinedAt)';
  }
}
