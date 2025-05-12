part of 'menu_cubit.dart';

sealed class MenuState extends Equatable {
  const MenuState();

  @override
  List<Object> get props => [];
}

final class MenuInitial extends MenuState {}

final class LoadingMenuState extends MenuState {}

final class MyMusicState extends MenuState {}

final class MyFavoriteState extends MenuState {}