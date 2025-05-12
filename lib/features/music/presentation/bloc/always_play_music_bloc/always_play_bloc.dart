import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:clean_music_app/features/music/domain/entities/music_entities.dart';
import 'package:clean_music_app/features/music/domain/usecases/always_play_music_add.dart';
import 'package:clean_music_app/features/music/domain/usecases/always_play_music_delete.dart';
import 'package:clean_music_app/features/music/domain/usecases/always_play_music_get.dart';
import 'package:equatable/equatable.dart';

part 'always_play_event.dart';
part 'always_play_state.dart';

class AlwaysPlayBloc extends Bloc<AlwaysPlayEvent, AlwaysPlayState> {
  final AlwaysPlayMusicAdd _alwaysPlayMusicAdd;
  final AlwaysPlayMusicGet _alwaysPlayMusicGet;
  final AlwaysPlayMusicDelete _alwaysPlayMusicDelete;

  AlwaysPlayBloc(
    this._alwaysPlayMusicAdd,
    this._alwaysPlayMusicGet,
    this._alwaysPlayMusicDelete,
  ) : super(AlwaysPlayInitial()) {
    on<AddAlwaysPlayMusicEvent>(addAlwaysPlayMusicEvent);
    on<GetAlwaysPlayMusicEvent>(getAlwaysPlayMusicEvent);
    on<DeleteAlwaysPlayMusicEvent>(deleteAlwaysPlayMusicEvent);
  }

  FutureOr<void> addAlwaysPlayMusicEvent(
    AddAlwaysPlayMusicEvent event,
    Emitter<AlwaysPlayState> emit,
  ) async {
    final response = await _alwaysPlayMusicAdd.call(event.music);

    await response.fold(
      (failure) async {
        emit(FailedAddAlwaysPlayState(failure: failure.message));
        final getMusic = await _alwaysPlayMusicGet.call();
        emit(LoadingAlwaysPlayState());
        getMusic.fold(
          (failure) {
            emit(FailedGetAlwaysPlayState(failure: failure.message));
          },
          (response) {
            emit(SuccessGetAlwaysPlayState(music: response));
          },
        );
      },
      (response) async {
        emit(
          SuccessAddAlwaysPlayState(message: 'Success Adding To Always Play'),
        );
        final getMusic = await _alwaysPlayMusicGet.call();
        emit(LoadingAlwaysPlayState());
        getMusic.fold(
          (failure) {
            emit(FailedGetAlwaysPlayState(failure: failure.message));
          },
          (response) {
            emit(SuccessGetAlwaysPlayState(music: response));
          },
        );
      },
    );
  }

  FutureOr<void> getAlwaysPlayMusicEvent(
    GetAlwaysPlayMusicEvent event,
    Emitter<AlwaysPlayState> emit,
  ) async {
    final response = await _alwaysPlayMusicGet.call();

    response.fold(
      (failure) {
        emit(FailedGetAlwaysPlayState(failure: failure.message));
      },
      (response) {
        emit(SuccessGetAlwaysPlayState(music: response));
      },
    );
  }

  FutureOr<void> deleteAlwaysPlayMusicEvent(
    DeleteAlwaysPlayMusicEvent event,
    Emitter<AlwaysPlayState> emit,
  ) async {
    final response = await _alwaysPlayMusicDelete.call(event.music);

    await response.fold(
      (failure) async {
        emit(FailedDeleteAlwaysPlayState(failure: failure.message));
        final getMusic = await _alwaysPlayMusicGet.call();
        emit(LoadingAlwaysPlayState());
        getMusic.fold(
          (failure) {
            emit(FailedGetAlwaysPlayState(failure: failure.message));
          },
          (response) {
            emit(SuccessGetAlwaysPlayState(music: response));
          },
        );
      },
      (response) async {
        emit(
          SuccessDeleteAlwaysPlayState(
            message: 'Success Adding To Always Play',
          ),
        );
        final getMusic = await _alwaysPlayMusicGet.call();
        emit(LoadingAlwaysPlayState());
        getMusic.fold(
          (failure) {
            emit(FailedGetAlwaysPlayState(failure: failure.message));
          },
          (response) {
            emit(SuccessGetAlwaysPlayState(music: response));
          },
        );
      },
    );
  }
}
