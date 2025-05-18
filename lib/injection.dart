import 'package:clean_music_app/common/cubit/theme_cubit.dart';
import 'package:clean_music_app/common/menu_cubit/menu_cubit.dart';
import 'package:clean_music_app/common/playing_cubit/playing_cubit.dart';
import 'package:clean_music_app/common/playing_feature_cubit/playing_feature_cubit.dart';
import 'package:clean_music_app/features/music/data/models/music_model.dart';
import 'package:clean_music_app/features/music/data/repositories/music_respositories_impl.dart';
import 'package:clean_music_app/features/music/data/datasources/local/local_datasource.dart';
import 'package:clean_music_app/features/music/domain/repositories/music_repositories.dart';
import 'package:clean_music_app/features/music/domain/usecases/always_play_music_add.dart';
import 'package:clean_music_app/features/music/domain/usecases/always_play_music_delete.dart';
import 'package:clean_music_app/features/music/domain/usecases/always_play_music_get.dart';
import 'package:clean_music_app/features/music/domain/usecases/favorite_music_add.dart';
import 'package:clean_music_app/features/music/domain/usecases/favorite_music_delete.dart';
import 'package:clean_music_app/features/music/domain/usecases/favorite_music_get.dart';
import 'package:clean_music_app/features/music/domain/usecases/music_initialize.dart';
import 'package:clean_music_app/features/music/presentation/bloc/always_play_music_bloc/always_play_bloc.dart';
import 'package:clean_music_app/features/music/presentation/bloc/favorite_bloc/favorite_bloc.dart';
import 'package:clean_music_app/features/music/presentation/bloc/music_bloc/music_bloc.dart';
import 'package:clean_music_app/features/music/presentation/bloc/search_bloc/search_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:just_audio/just_audio.dart';
import 'package:on_audio_query/on_audio_query.dart';

final sl = GetIt.instance;

Future<void> initializeDependecies() async {
  Hive.registerAdapter(MusicModelAdapter());
  var alwaysPlayMusicBox = await Hive.openBox<Object>("always_play_music_box");
  var favoriteMusicBox = await Hive.openBox<Object>("favorite_music_box");
  sl.registerLazySingleton(() => alwaysPlayMusicBox, instanceName: 'always');
  sl.registerLazySingleton(() => favoriteMusicBox, instanceName: 'favorite');
  sl.registerLazySingleton(() => OnAudioQuery());
  sl.registerLazySingleton(() => AudioPlayer());

  // ^ bloc & cubit

  sl.registerFactory(() => PlayingCubit(sl()));
  sl.registerFactory(() => MenuCubit());
  sl.registerFactory(() => ThemeCubit());
  sl.registerFactory(() => PlayingFeatureCubit(sl()));
  sl.registerFactory(() => MusicBloc(sl()));
  sl.registerFactory(() => AlwaysPlayBloc(sl(), sl(), sl()));
  sl.registerFactory(() => SearchBloc(sl()));
  sl.registerFactory(() => FavoriteBloc(sl(), sl(), sl()));

  // ^ usecase

  sl.registerLazySingleton(() => MusicInitialize(sl()));
  sl.registerLazySingleton(() => AlwaysPlayMusicAdd(sl()));
  sl.registerLazySingleton(() => AlwaysPlayMusicDelete(sl()));
  sl.registerLazySingleton(() => AlwaysPlayMusicGet(sl()));
  sl.registerLazySingleton(() => FavoriteMusicAdd(sl()));
  sl.registerLazySingleton(() => FavoriteMusicGet(sl()));
  sl.registerLazySingleton(() => FavoriteMusicDelete(sl()));

  // ^ datasoruces

  sl.registerLazySingleton<LocalDatasource>(
    () => LocalDatasourceImpl(
      sl(),
      sl(instanceName: 'always'),
      sl(instanceName: 'favorite'),
    ),
  );

  // ^ repositories

  sl.registerLazySingleton<MusicRepositories>(
    () => MusicRespositoriesImpl(
      sl(),
      sl(instanceName: 'always'),
      sl(instanceName: 'favorite'),
    ),
  );
}
