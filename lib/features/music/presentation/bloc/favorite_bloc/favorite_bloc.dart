import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:clean_music_app/features/music/domain/entities/music_entities.dart';
import 'package:clean_music_app/features/music/domain/repositories/music_repositories.dart';
import 'package:clean_music_app/features/music/domain/usecases/favorite_music_add.dart';
import 'package:clean_music_app/features/music/domain/usecases/favorite_music_delete.dart';
import 'package:clean_music_app/features/music/domain/usecases/favorite_music_get.dart';
import 'package:equatable/equatable.dart';

part 'favorite_event.dart';
part 'favorite_state.dart';

class FavoriteBloc extends Bloc<FavoriteEvent, FavoriteState> {
  final FavoriteMusicAdd _favoriteMusicAdd;
  final FavoriteMusicDelete _favoriteMusicDelete;
  final FavoriteMusicGet _favoriteMusicGet;

  FavoriteBloc(
    this._favoriteMusicAdd,
    this._favoriteMusicDelete,
    this._favoriteMusicGet,
  ) : super(FavoriteInitial()) {
    on<GetFavoriteEvent>(getFavoriteEvent);
    on<AddFavoriteEvent>(addFavoriteEvent);
    on<DeleteFavoriteEvent>(deleteFavoriteEvent);
  }

  FutureOr<void> getFavoriteEvent(
    GetFavoriteEvent event,
    Emitter<FavoriteState> emit,
  ) async {
    emit(LoadingFavoriteState());
    final response = await _favoriteMusicGet.call();

    response.fold(
      (failure) {
        emit(FailedGetFavoriteState(failure: failure.message));
      },
      (response) {
        emit(SuccessGetFavoriteState(music: response));
      },
    );
  }

  FutureOr<void> addFavoriteEvent(
    AddFavoriteEvent event,
    Emitter<FavoriteState> emit,
  ) async {
    emit(LoadingFavoriteState());
    final response = await _favoriteMusicAdd.call(event.music);

    await response.fold(
      (failure) async {
        emit(FailedAddFavoriteState(failure: failure.message));
        final getMusic = await _favoriteMusicGet.call();

        getMusic.fold(
          (failure) {
            emit(FailedGetFavoriteState(failure: failure.message));
          },
          (response) {
            emit(SuccessGetFavoriteState(music: response));
          },
        );
      },
      (response) async {
        emit(SuccessAddFavoriteState(message: "Success Add"));
        final getMusic = await _favoriteMusicGet.call();

        getMusic.fold(
          (failure) {
            emit(FailedGetFavoriteState(failure: failure.message));
          },
          (response) {
            emit(SuccessGetFavoriteState(music: response));
          },
        );
      },
    );
  }

  FutureOr<void> deleteFavoriteEvent(
    DeleteFavoriteEvent event,
    Emitter<FavoriteState> emit,
  ) async {
    final response = await _favoriteMusicDelete.call(event.music);

    await response.fold(
      (failure) async {
        emit(FailedDeleteFavoriteState(failure: failure.message));

        final getMusic = await _favoriteMusicGet.call();

        getMusic.fold(
          (failure) {
            emit(FailedGetFavoriteState(failure: failure.message));
          },
          (response) {
            emit(SuccessGetFavoriteState(music: response));
          },
        );
      },
      (response) async {
        emit(SuccessDeleteFavoriteState(message: 'Success Remove'));

        final getMusic = await _favoriteMusicGet.call();

        getMusic.fold(
          (failure) {
            emit(FailedGetFavoriteState(failure: failure.message));
          },
          (response) {
            emit(SuccessGetFavoriteState(music: response));
          },
        );
      },
    );
  }
}
