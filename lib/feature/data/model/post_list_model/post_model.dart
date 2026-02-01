import 'package:json_annotation/json_annotation.dart';

part 'post_model.g.dart';

@JsonSerializable()
class PostModel {
  final int id;
  final int userId;
  final String title;
  final String body;

  PostModel({
    required this.id,
    required this.userId,
    required this.title,
    required this.body,
  });

  factory PostModel.fromJson(Map<String, dynamic> json) =>
      _$PostModelFromJson(json);

  Map<String, dynamic> toJson() => _$PostModelToJson(this);
}



//✔️ Step 2: Command dobara run karo
//dart run build_runner build --delete-conflicting-outputs
//
//
//Ya old Flutter comando:
//
//flutter pub run build_runner build --delete-conflicting-outputs