// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) => User(
      id: json['id'] as String? ?? '',
      name: json['name'] as String? ?? '',
      username: json['username'] as String? ?? '',
      bio: json['bio'] as String? ?? '',
      isMale: json['is_male'] as bool? ?? true,
      mahrams: (json['mahrams'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          [],
      phoneNumber: json['phone_number'] as String? ?? '',
      mail: json['mail'] as String? ?? '',
      imageUrl: json['image_url'] as String? ?? '',
      posts: (json['posts'] as List<dynamic>?)
              ?.map((e) => Post.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      joinedAt: json['joined_at'] as String? ?? '',
    );

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'mail': instance.mail,
      'username': instance.username,
      'bio': instance.bio,
      'is_male': instance.isMale,
      'mahrams': instance.mahrams,
      'phone_number': instance.phoneNumber,
      'image_url': instance.imageUrl,
      'posts': instance.posts,
      'joined_at': instance.joinedAt,
    };
