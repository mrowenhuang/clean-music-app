import 'package:clean_music_app/common/playing_cubit/playing_cubit.dart';
import 'package:clean_music_app/features/music/data/repositories/music_respositories_impl.dart';
import 'package:clean_music_app/features/music/data/datasources/local/local_datasource.dart';
import 'package:clean_music_app/features/music/domain/repositories/music_repositories.dart';
import 'package:clean_music_app/features/music/domain/usecases/music_initialize.dart';
import 'package:clean_music_app/features/music/presentation/bloc/music_bloc/music_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:just_audio/just_audio.dart';
import 'package:on_audio_query/on_audio_query.dart';

final sl = GetIt.instance;

Future<void> initializeDependecies() async {
  
  sl.registerLazySingleton(() => OnAudioQuery());
  sl.registerLazySingleton(() => AudioPlayer(),);

  // ^ bloc & cubit

  sl.registerFactory(() => PlayingCubit(sl()));
  sl.registerFactory(() => MusicBloc(sl()));

  // ^ usecase

  sl.registerLazySingleton(() => MusicInitialize(sl()));

  // ^ datasoruces
  
  sl.registerLazySingleton<LocalDatasource>(() => LocalDatasourceImpl(sl()));

  // ^ repositories

  sl.registerLazySingleton<MusicRepositories>(
    () => MusicRespositoriesImpl(sl()),
  );
}
