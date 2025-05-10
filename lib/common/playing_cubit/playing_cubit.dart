import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:clean_music_app/features/music/domain/entities/music_entities.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/services.dart';
import 'package:just_audio/just_audio.dart';
import 'package:just_audio_background/just_audio_background.dart';
import 'package:path_provider/path_provider.dart';

part 'playing_state.dart';

class PlayingCubit extends Cubit<PlayingState> {
  final AudioPlayer _audioPlayer;

  PlayingCubit(this._audioPlayer) : super(PlayingInitial());

  Future<Uri> getArtUriFromAsset(String assetPath) async {
    final byteData = await rootBundle.load(assetPath);
    final file = File('${(await getTemporaryDirectory()).path}/temp_art.jpg');
    await file.writeAsBytes(byteData.buffer.asUint8List());
    return Uri.file(file.path);
  }

  Future<void> playingMusic(List<MusicEntities> music, int index) async {
    emit(LoadingPlayingMusicState());
    final artUri = await getArtUriFromAsset('assets/images/banner.png');
    final playlist = ConcatenatingAudioSource(
      children:
          music
              .map(
                (e) => AudioSource.uri(
                  Uri.parse(e.path.toString()),
                  tag: MediaItem(
                    id: e.id.toString(),
                    title: e.title.toString(),
                    artist: e.artist,
                    artUri: artUri,
                  ),
                ),
              )
              .toList(),
    );

    await _audioPlayer.setAudioSource(
      playlist,
      initialIndex: index,
      initialPosition: Duration.zero,
      preload: true,
    );
    _audioPlayer.currentIndexStream.listen((currentIndex) {
      if (currentIndex != null) {
        emit(LoadingPlayingMusicState());
        emit(SuccessPlayingMusicState(music: music, index: currentIndex));
      }
    });
    emit(SuccessPlayingMusicState(music: music, index: index));
    await _audioPlayer.play();
  }

  Future<void> toNext() async {
    await _audioPlayer.seekToNext();
  }

  Future<void> toPrev() async {
    await _audioPlayer.seekToPrevious();
  }
}
