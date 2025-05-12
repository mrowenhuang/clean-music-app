part of 'favorite_bloc.dart';

sealed class FavoriteState extends Equatable {
  const FavoriteState();

  @override
  List<Object> get props => [];
}

final class FavoriteInitial extends FavoriteState {}

final class LoadingFavoriteState extends FavoriteState {}

final class SuccessAddFavoriteState extends FavoriteState {
  final String message;

  const SuccessAddFavoriteState({required this.message});
}

final class FailedAddFavoriteState extends FavoriteState {
  final String failure;

  const FailedAddFavoriteState({required this.failure});
}

final class SuccessGetFavoriteState extends FavoriteState {
  final List<MusicEntities> music;

  const SuccessGetFavoriteState({required this.music});
}

final class FailedGetFavoriteState extends FavoriteState {
  final String failure;

  const FailedGetFavoriteState({required this.failure});
}

final class SuccessDeleteFavoriteState extends FavoriteState {
  final String message;

  const SuccessDeleteFavoriteState({required this.message});
}

final class FailedDeleteFavoriteState extends FavoriteState {
  final String failure;

  const FailedDeleteFavoriteState({required this.failure});
}
