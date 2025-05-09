import 'package:clean_music_app/core/failure/server_failure.dart';
import 'package:clean_music_app/features/music/domain/entities/music_entities.dart';
import 'package:dartz/dartz.dart';

abstract class MusicRepositories {
  Future<Either<ServerFailure,List<MusicEntities>>> initializeMusic();
}
