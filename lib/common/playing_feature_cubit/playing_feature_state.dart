part of 'playing_feature_cubit.dart';

sealed class PlayingFeatureState extends Equatable {
  const PlayingFeatureState();

  @override
  List<Object> get props => [];
}

final class PlayingFeatureInitial extends PlayingFeatureState {}

final class LoadingSetMusicFeatureState extends PlayingFeatureState{}

final class SuccessSetMusicFeatureState extends PlayingFeatureState{}

final class FailedSetMusicFeatureState extends PlayingFeatureState {}