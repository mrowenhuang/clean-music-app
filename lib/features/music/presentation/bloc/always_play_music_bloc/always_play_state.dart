part of 'always_play_bloc.dart';

sealed class AlwaysPlayState extends Equatable {
  const AlwaysPlayState();

  @override
  List<Object> get props => [];
}

final class AlwaysPlayInitial extends AlwaysPlayState {}

final class LoadingAlwaysPlayState extends AlwaysPlayState {}

final class SuccessGetAlwaysPlayState extends AlwaysPlayState {
  final List<MusicEntities> music;

  const SuccessGetAlwaysPlayState({required this.music});
}

final class SuccessAddAlwaysPlayState extends AlwaysPlayState {
  final String message;

  const SuccessAddAlwaysPlayState({required this.message});
}

final class SuccessDeleteAlwaysPlayState extends AlwaysPlayState {
  final String message;

  const SuccessDeleteAlwaysPlayState({required this.message});
}

final class FailedDeleteAlwaysPlayState extends AlwaysPlayState {
  final String failure;

  const FailedDeleteAlwaysPlayState({required this.failure});
}

final class FailedGetAlwaysPlayState extends AlwaysPlayState {
  final String failure;

  const FailedGetAlwaysPlayState({required this.failure});
}

final class FailedAddAlwaysPlayState extends AlwaysPlayState {
  final String failure;

  const FailedAddAlwaysPlayState({required this.failure});
}
