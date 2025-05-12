import 'package:clean_music_app/core/failure/server_failure.dart';
import 'package:clean_music_app/features/music/data/models/music_model.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:permission_handler/permission_handler.dart';

abstract class LocalDatasource {
  Future<List<SongModel>> getLocalMusic();
  Future<List<MusicModel>> getAlwaysPlayMusic();
}

class LocalDatasourceImpl implements LocalDatasource {
  final OnAudioQuery _audioQuery;
  final Box<Object> _alwaysBox;
  final Box<MusicModel> _favBox;

  LocalDatasourceImpl(this._audioQuery, this._alwaysBox, this._favBox);

  @override
  Future<List<SongModel>> getLocalMusic() async {
    try {
      if (await Permission.audio.isGranted ||
          await Permission.storage.isGranted) {
        List<SongModel> data = await _audioQuery.querySongs();
        return data;
      } else if (await Permission.storage.isDenied ||
          await Permission.audio.isDenied) {
        Permission.audio.request();
        Permission.storage.request();
        List<SongModel> data = await _audioQuery.querySongs();
        return data;
      } else {
        throw ServerFailure(message: "Something was wrong");
      }
    } catch (e) {
      throw ServerFailure(message: e.toString());
    }
  }

  @override
  Future<List<MusicModel>> getAlwaysPlayMusic() async {
    try {
      final raw = _alwaysBox.get('always_play');
      if (raw != null && raw is List) {
        return raw
            .cast<MusicModel>(); 
      } else {
        return [];
      }
    } catch (e) {
      print("Error reading Hive: $e");
      throw ServerFailure(message: e.toString());
    }
  }
}
