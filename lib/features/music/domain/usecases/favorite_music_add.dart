import 'package:clean_music_app/core/failure/server_failure.dart';
import 'package:clean_music_app/features/music/domain/entities/music_entities.dart';
import 'package:clean_music_app/features/music/domain/repositories/music_repositories.dart';
import 'package:dartz/dartz.dart';

class FavoriteMusicAdd {
  final MusicRepositories _musicRepositories;

  FavoriteMusicAdd(this._musicRepositories);

  Future<Either<ServerFailure,Unit>> call (MusicEntities music) async {
    return await _musicRepositories.addFavoriteMusic(music);
  }
}
