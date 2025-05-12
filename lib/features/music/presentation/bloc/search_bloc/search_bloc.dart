import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:clean_music_app/features/music/domain/entities/music_entities.dart';
import 'package:clean_music_app/features/music/domain/usecases/music_initialize.dart';
import 'package:equatable/equatable.dart';

part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final MusicInitialize _musicInitialize;

  SearchBloc(this._musicInitialize) : super(SearchInitial()) {
    
    on<GetSearchMusicEvent>(getSearchMusicEvent);
    on<ResetSearchMusicEvent>(resetSearchMusicEvent);
  }

  FutureOr<void> getSearchMusicEvent(
    GetSearchMusicEvent event,
    Emitter<SearchState> emit,
  ) async {
    emit(LoadingSearchMusicState());

    final response = await _musicInitialize.call();

    response.fold(
      (failure) {
        emit(FailedGetSearchMusicState(failure: failure.message));
      },
      (response) {
        final List<MusicEntities> result =
            response.where((element) {
              return element.title.toString().toLowerCase().contains(
                    event.data.toString().toLowerCase(),
                  ) ||
                  element.artist.toString().toLowerCase().contains(
                    event.data.toString().toLowerCase(),
                  );
            }).toList();

        emit(SuccessGetSearchMusicState(music: result));
      },
    );
  }

  FutureOr<void> resetSearchMusicEvent(
    ResetSearchMusicEvent event,
    Emitter<SearchState> emit,
  ) {
    emit(SearchInitial());
  }
}
