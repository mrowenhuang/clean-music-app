part of 'music_bloc.dart';

abstract class MusicState extends Equatable {
  const MusicState();  

  @override
  List<Object> get props => [];
}
class MusicInitial extends MusicState {}


final class LoadingInitializeMusicState extends MusicState{}

final class SuccessInitializeMusicState extends MusicState {
  final List<MusicEntities> music;

  const SuccessInitializeMusicState({required this.music});
}

final class FailedInitializeMusicState extends MusicState {
  final String failure;

  const FailedInitializeMusicState({required this.failure});
}