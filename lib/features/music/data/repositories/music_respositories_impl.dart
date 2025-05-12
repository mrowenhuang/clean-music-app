import 'package:clean_music_app/core/failure/server_failure.dart';
import 'package:clean_music_app/features/music/data/datasources/local/local_datasource.dart';
import 'package:clean_music_app/features/music/data/models/music_model.dart';
import 'package:clean_music_app/features/music/domain/entities/music_entities.dart';
import 'package:clean_music_app/features/music/domain/repositories/music_repositories.dart';
import 'package:dartz/dartz.dart';
import 'package:hive_flutter/hive_flutter.dart';

class MusicRespositoriesImpl extends MusicRepositories {
  final LocalDatasource _localDatasource;
  final Box<Object> _alwaysBox;
  final Box<MusicModel> _favBox;
  List<MusicModel> alwaysData = [];

  MusicRespositoriesImpl(this._localDatasource, this._alwaysBox, this._favBox);

  @override
  Future<Either<ServerFailure, List<MusicEntities>>> initializeMusic() async {
    try {
      final data = await _localDatasource.getLocalMusic();

      var results = data.map((e) => MusicModel.fromSongModel(e)).toList();

      return right(results);
    } catch (e) {
      return left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<ServerFailure, Unit>> addAlwaysPlayMusic(
    MusicEntities music,
  ) async {
    try {
      final alreadyExists = alwaysData.any((element) => element.id == music.id);

      if (!alreadyExists) {
        if (alwaysData.length < 3) {
          alwaysData.add(MusicModel.fromEntity(music));
          await _alwaysBox.put('always_play', alwaysData);
          return right(unit);
        } else {
          return left(ServerFailure(message: "Only can store three music"));
        }
      } else {
        return left(ServerFailure(message: "Music already exists"));
      }
    } catch (e) {
      return left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<ServerFailure, List<MusicEntities>>>
  getAlwaysPlayMusic() async {
    try {
      final response = await _localDatasource.getAlwaysPlayMusic();

      alwaysData = response;

      return right(response);
    } catch (e) {
      return left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<ServerFailure, Unit>> deleteAlwaysPlayMusic(
    MusicEntities music,
  ) async {
    try {
      alwaysData.removeWhere((element) => element.id == music.id);
      await _alwaysBox.put('always_play', alwaysData);
      return right(unit);
    } catch (e) {
      return left(ServerFailure(message: e.toString()));
    }
  }
}
