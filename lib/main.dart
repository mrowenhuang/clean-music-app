import 'package:clean_music_app/common/menu_cubit/menu_cubit.dart';
import 'package:clean_music_app/common/playing_cubit/playing_cubit.dart';
import 'package:clean_music_app/common/playing_feature_cubit/playing_feature_cubit.dart';
import 'package:clean_music_app/core/config/app_theme.dart';
import 'package:clean_music_app/features/music/presentation/bloc/always_play_music_bloc/always_play_bloc.dart';
import 'package:clean_music_app/features/music/presentation/bloc/favorite_bloc/favorite_bloc.dart';
import 'package:clean_music_app/features/music/presentation/bloc/music_bloc/music_bloc.dart';
import 'package:clean_music_app/features/music/presentation/bloc/search_bloc/search_bloc.dart';
import 'package:clean_music_app/features/music/presentation/pages/home_pages.dart';
import 'package:clean_music_app/injection.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:just_audio_background/just_audio_background.dart';

void main() async {
  await Hive.initFlutter();
  await initializeDependecies();
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  await JustAudioBackground.init(
    androidNotificationChannelId: 'com.ryanheise.bg_demo.channel.audio',
    androidNotificationChannelName: 'Audio playback',
    androidNotificationOngoing: true,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => sl<MusicBloc>()..add(InitailizeMusicEvent()),
        ),
        BlocProvider(
          create:
              (context) => sl<AlwaysPlayBloc>()..add(GetAlwaysPlayMusicEvent()),
        ),
        BlocProvider(
          create: (context) => sl<FavoriteBloc>()..add(GetFavoriteEvent()),
        ),
        BlocProvider(create: (context) => sl<SearchBloc>()),
        BlocProvider(create: (context) => sl<PlayingCubit>()),
        BlocProvider(create: (context) => sl<MenuCubit>()),
        BlocProvider(create: (context) => sl<PlayingFeatureCubit>()),
      ],
      child: MaterialApp(
        title: 'My Music',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.appTheme(context),
        home: const HomePages(),
      ),
    );
  }
}
