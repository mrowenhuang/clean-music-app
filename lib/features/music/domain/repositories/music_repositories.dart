import 'package:clean_music_app/core/failure/server_failure.dart';
import 'package:clean_music_app/features/music/domain/entities/music_entities.dart';
import 'package:dartz/dartz.dart';

abstract class MusicRepositories {
  Future<Either<ServerFailure, List<MusicEntities>>> initializeMusic();
  Future<Either<ServerFailure, Unit>> addAlwaysPlayMusic(MusicEntities music);
  Future<Either<ServerFailure, Unit>> deleteAlwaysPlayMusic(
    MusicEntities music,
  );
  Future<Either<ServerFailure, List<MusicEntities>>> getAlwaysPlayMusic();
  Future<Either<ServerFailure, Unit>> addFavoriteMusic(MusicEntities music);
  Future<Either<ServerFailure, Unit>> deleteFavoriteMusic(MusicEntities music);
  Future<Either<ServerFailure, List<MusicEntities>>> getFavoriteMusic();
}
