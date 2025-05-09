part of 'playing_cubit.dart';

sealed class PlayingState extends Equatable {
  const PlayingState();

  @override
  List<Object> get props => [];
}

final class PlayingInitial extends PlayingState {}

final class LoadingPlayMusicState extends PlayingState {}

final class SuccessPlayingMusicState extends PlayingState {}

final class FailedPlayingMusicState extends PlayingState  {}
