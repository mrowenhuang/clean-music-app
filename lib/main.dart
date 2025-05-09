import 'package:clean_music_app/common/playing_cubit/playing_cubit.dart';
import 'package:clean_music_app/core/config/app_theme.dart';
import 'package:clean_music_app/features/music/presentation/bloc/music_bloc/music_bloc.dart';
import 'package:clean_music_app/features/music/presentation/pages/home_pages.dart';
import 'package:clean_music_app/injection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:just_audio_background/just_audio_background.dart';

void main() async {
  runApp(const MyApp());
  await initializeDependecies();
  await JustAudioBackground.init(
    androidNotificationChannelId: 'com.ryanheise.bg_demo.channel.audio',
    androidNotificationChannelName: 'Audio playback',
    androidNotificationOngoing: true,
  );
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
        BlocProvider(create: (context) => sl<PlayingCubit>()),
      ],
      child: MaterialApp(
        title: 'MyMusic',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.appTheme(context),
        home: const HomePages(),
      ),
    );
  }
}
