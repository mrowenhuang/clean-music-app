import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:just_audio/just_audio.dart';

part 'playing_feature_state.dart';

class PlayingFeatureCubit extends Cubit<PlayingFeatureState> {
  final AudioPlayer _audioPlayer;

  PlayingFeatureCubit(this._audioPlayer) : super(PlayingFeatureInitial());

  Future<void> pauseMusic() async {
    emit(LoadingSetMusicFeatureState());
    emit(SuccessSetMusicFeatureState());
    await _audioPlayer.pause();
  }

  Future<void> playMusic() async {
    emit(LoadingSetMusicFeatureState());
    emit(SuccessSetMusicFeatureState());
    await _audioPlayer.play();
  }
}
