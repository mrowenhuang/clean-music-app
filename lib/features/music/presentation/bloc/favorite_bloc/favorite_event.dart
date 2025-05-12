part of 'favorite_bloc.dart';

sealed class FavoriteEvent extends Equatable {
  const FavoriteEvent();

  @override
  List<Object> get props => [];
}

final class AddFavoriteEvent extends FavoriteEvent {
  final MusicEntities music;

  const AddFavoriteEvent({required this.music});
}

final class GetFavoriteEvent extends FavoriteEvent {}

final class DeleteFavoriteEvent extends FavoriteEvent {
  final MusicEntities music;

  const DeleteFavoriteEvent({required this.music});
}
