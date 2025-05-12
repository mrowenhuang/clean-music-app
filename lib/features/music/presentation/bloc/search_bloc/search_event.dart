part of 'search_bloc.dart';

sealed class SearchEvent extends Equatable {
  const SearchEvent();

  @override
  List<Object> get props => [];
}

final class GetSearchMusicEvent extends SearchEvent {
  final String data;

  const GetSearchMusicEvent({required this.data});
}

class ResetSearchMusicEvent extends SearchEvent {}