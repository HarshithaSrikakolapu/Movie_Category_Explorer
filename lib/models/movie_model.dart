import 'package:json_annotation/json_annotation.dart';

part 'movie_model.g.dart';

@JsonSerializable()
class MovieModel {

  @JsonKey(name: 'Title')
  final String title;

  @JsonKey(name: 'Year')
  final String year;

  @JsonKey(name: 'Poster')
  final String poster;

  @JsonKey(name: 'imdbID')
  final String imdbId;

  @JsonKey(name: 'Type')
  final String type;

  MovieModel({

    required this.title,

    required this.year,

    required this.poster,

    required this.imdbId,

    required this.type,
  });

  factory MovieModel.fromJson(
      Map<String, dynamic> json) =>
      _$MovieModelFromJson(json);

  Map<String, dynamic> toJson() =>
      _$MovieModelToJson(this);
}