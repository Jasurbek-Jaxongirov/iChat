import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'post.g.dart';

@JsonSerializable()
class Post extends Equatable {
  @JsonKey(name: 'id', defaultValue: '')
  final String id;
  @JsonKey(name: 'title', defaultValue: '')
  final String title;
  @JsonKey(name: 'content', defaultValue: '')
  final String content;
  @JsonKey(name: 'image_urls', defaultValue: [])
  final List<String> imageUrls;
  @JsonKey(name: 'from', defaultValue: '')
  final String from;
  @JsonKey(name: 'date', defaultValue: '')
  final String date;
  @JsonKey(name: 'category')
  final Category category;
  const Post({
    required this.id,
    required this.title,
    required this.content,
    required this.imageUrls,
    required this.from,
    required this.date,
    required this.category,
  });

  factory Post.fromJson(Map<String, dynamic> json) => _$PostFromJson(json);
  Map<String, dynamic> toJson() => _$PostToJson(this);
  @override
  List<Object> get props {
    return [
      id,
      title,
      content,
      imageUrls,
      from,
      date,
      category,
    ];
  }

  @override
  String toString() {
    return 'Post(id: $id, title: $title, content: $content, imageUrls: $imageUrls, from: $from, date: $date, category: $category)';
  }
}

@JsonSerializable()
class Category extends Equatable{
  @JsonKey(name: 'all', defaultValue: true)
  final bool all;
  @JsonKey(name: 'male', defaultValue: false)
  final bool male;
  @JsonKey(name: 'female', defaultValue: false)
  final bool female;

  const Category({
    required this.all,
    required this.male,
    required this.female,
  });

  factory Category.fromJson(Map<String, dynamic> json) =>
      _$CategoryFromJson(json);
  Map<String, dynamic> toJson() => _$CategoryToJson(this);
  @override
  List<Object> get props {
    return [
      all,
      male,
      female,
    ];
  }

  @override
  String toString() => 'Category(all: $all, male: $male, female: $female)';
}
