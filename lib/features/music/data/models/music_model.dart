import 'dart:convert';

import 'package:clean_music_app/features/music/domain/entities/music_entities.dart';
import 'package:hive/hive.dart';
import 'package:on_audio_query/on_audio_query.dart';

part 'music_model.g.dart';

@HiveType(typeId: 0)
// ignore: must_be_immutable
class MusicModel extends MusicEntities {
  @override
  @HiveField(0)
  final String? id;
  @override
  @HiveField(1)
  final String? title;
  @override
  @HiveField(2)
  final String? artist;
  @override
  @HiveField(3)
  final String? path;
  @override
  @HiveField(4)
  final bool? playing;

  MusicModel({this.id, this.artist, this.title, this.path, this.playing})
    : super(id: id, artist: artist, path: path, playing: playing, title: title);

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'artist': artist,
      'path': path,
      'playing': playing,
    };
  }

  factory MusicModel.fromMap(Map<String, dynamic> map) {
    return MusicModel(
      id: map['id'] != null ? map['id'] as String : null,
      title: map['title'] != null ? map['title'] as String : null,
      artist: map['artist'] != null ? map['artist'] as String : null,
      path: map['path'] != null ? map['path'] as String : null,
      playing: map['playing'] != null ? map['playing'] as bool : null,
    );
  }

  factory MusicModel.fromSongModel(SongModel song) {
    return MusicModel(
      id: song.id.toString(),
      title: song.title,
      artist: song.artist,
      path: song.data,
      playing: null,
    );
  }

  factory MusicModel.fromEntity(MusicEntities entity) {
    return MusicModel(
      id: entity.id,
      title: entity.title,
      artist: entity.artist,
      path: entity.path,
      playing: entity.playing,
    );
  }

  String toJson() => json.encode(toMap());

  factory MusicModel.fromJson(String source) =>
      MusicModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
