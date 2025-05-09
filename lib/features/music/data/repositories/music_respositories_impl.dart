import 'package:clean_music_app/core/failure/server_failure.dart';
import 'package:clean_music_app/features/music/data/datasources/local/local_datasource.dart';
import 'package:clean_music_app/features/music/data/models/music_model.dart';
import 'package:clean_music_app/features/music/domain/entities/music_entities.dart';
import 'package:clean_music_app/features/music/domain/repositories/music_repositories.dart';
import 'package:dartz/dartz.dart';

class MusicRespositoriesImpl extends MusicRepositories {
  final LocalDatasource _localDatasource;

  MusicRespositoriesImpl(this._localDatasource);

  @override
  Future<Either<ServerFailure,List<MusicEntities>>> initializeMusic() async {
    try {
      final data = await _localDatasource.getLocalMusic();

      var results = data.map((e) => MusicModel.fromSongModel(e),).toList();

      return right(results);

    } catch (e) {
      return left(ServerFailure(message: e.toString()));
    }
  }
}
