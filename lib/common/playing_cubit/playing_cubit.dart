import 'package:bloc/bloc.dart';
import 'package:clean_music_app/features/music/domain/entities/music_entities.dart';
import 'package:equatable/equatable.dart';
import 'package:just_audio/just_audio.dart';
import 'package:just_audio_background/just_audio_background.dart';

part 'playing_state.dart';

class PlayingCubit extends Cubit<PlayingState> {
  final AudioPlayer _audioPlayer;

  PlayingCubit(this._audioPlayer) : super(PlayingInitial());

  Future<void> playMusic(List<MusicEntities> music, int index) async {
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

    await _audioPlayer.play();
  }
}
