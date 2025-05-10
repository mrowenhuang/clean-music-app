part of 'playing_cubit.dart';

sealed class PlayingState extends Equatable {
  const PlayingState();

  @override
  List<Object> get props => [];
}

final class PlayingInitial extends PlayingState {}

final class LoadingPlayingMusicState extends PlayingState {}

final class SuccessPlayingMusicState extends PlayingState {
  final List<MusicEntities> music;
  final int index;

  const SuccessPlayingMusicState({required this.music,required this.index});
}

final class FailedPlayingMusicState extends PlayingState {}
