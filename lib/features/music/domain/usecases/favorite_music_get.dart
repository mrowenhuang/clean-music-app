import 'package:clean_music_app/core/failure/server_failure.dart';
import 'package:clean_music_app/features/music/domain/entities/music_entities.dart';
import 'package:clean_music_app/features/music/domain/repositories/music_repositories.dart';
import 'package:dartz/dartz.dart';

class FavoriteMusicGet {
  final MusicRepositories _musicRepositories;

  FavoriteMusicGet(this._musicRepositories);

  Future<Either<ServerFailure,List<MusicEntities>>> call () async {
    return await _musicRepositories.getFavoriteMusic();
  }
}