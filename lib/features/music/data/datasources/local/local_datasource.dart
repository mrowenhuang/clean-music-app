import 'package:clean_music_app/core/failure/server_failure.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:permission_handler/permission_handler.dart';

abstract class LocalDatasource {
  Future<List<SongModel>> getLocalMusic();
}

class LocalDatasourceImpl implements LocalDatasource {
  final OnAudioQuery _audioQuery;

  LocalDatasourceImpl(this._audioQuery);

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
}
