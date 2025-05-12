import 'package:clean_music_app/core/failure/server_failure.dart';
import 'package:clean_music_app/features/music/domain/entities/music_entities.dart';
import 'package:clean_music_app/features/music/domain/repositories/music_repositories.dart';
import 'package:dartz/dartz.dart';

class AlwaysPlayMusicAdd {
  final MusicRepositories _musicRepositories;

  AlwaysPlayMusicAdd(this._musicRepositories);
  
  Future<Either<ServerFailure,Unit>> call (MusicEntities music) async {
    return await _musicRepositories.addAlwaysPlayMusic(music);
  }
}
