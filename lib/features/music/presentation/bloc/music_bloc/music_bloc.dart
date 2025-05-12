import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:clean_music_app/features/music/domain/entities/music_entities.dart';
import 'package:clean_music_app/features/music/domain/usecases/music_initialize.dart';
import 'package:equatable/equatable.dart';

part 'music_event.dart';
part 'music_state.dart';

class MusicBloc extends Bloc<MusicEvent, MusicState> {
  final MusicInitialize _musicInitialize;

  MusicBloc(this._musicInitialize) : super(MusicInitial()) {
    on<InitailizeMusicEvent>(initailizeMusicEvent);
  }

  FutureOr<void> initailizeMusicEvent(
    InitailizeMusicEvent event,
    Emitter<MusicState> emit,
  ) async {
    final response = await _musicInitialize.call();

    response.fold(
      (failure) {
        emit(FailedInitializeMusicState(failure: failure.message));
      },
      (response) {
        emit(SuccessInitializeMusicState(music: response));
      },
    );
  }

 
}
