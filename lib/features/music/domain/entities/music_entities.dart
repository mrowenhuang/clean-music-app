// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:equatable/equatable.dart';

// ignore: must_be_immutable
class MusicEntities extends Equatable {
  String? id;
  String? title;
  String? artist;
  String? path;
  bool? playing;
  MusicEntities({this.id, this.title, this.artist, this.path, this.playing});

  @override
  List<Object?> get props {
    return [id, title, artist, path, playing];
  }


}
