part of 'always_play_bloc.dart';

sealed class AlwaysPlayEvent extends Equatable {
  const AlwaysPlayEvent();

  @override
  List<Object> get props => [];
}

final class AddAlwaysPlayMusicEvent extends AlwaysPlayEvent {
  final MusicEntities music;

  const AddAlwaysPlayMusicEvent({required this.music});
}

final class DeleteAlwaysPlayMusicEvent extends AlwaysPlayEvent {
  final MusicEntities music;

  const DeleteAlwaysPlayMusicEvent({required this.music});
}

final class GetAlwaysPlayMusicEvent extends AlwaysPlayEvent {}
