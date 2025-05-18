import 'package:clean_music_app/common/menu_cubit/menu_cubit.dart';
import 'package:clean_music_app/features/music/presentation/bloc/favorite_bloc/favorite_bloc.dart';
import 'package:clean_music_app/features/music/presentation/bloc/music_bloc/music_bloc.dart';
import 'package:clean_music_app/features/music/presentation/widgets/small%20component/music_box.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Widget musicViewArea(BuildContext context) {

  return BlocBuilder<MenuCubit, bool>(
    builder: (context, value) {
      if (value) {
        // ^ my music bloc
        return BlocBuilder<MusicBloc, MusicState>(
          bloc: context.read<MusicBloc>(),
          builder: (context, state) {
            if (state is LoadingInitializeMusicState) {
              return SliverFillRemaining(
                child: Center(child: CupertinoActivityIndicator()),
              );
            } else if (state is SuccessInitializeMusicState) {
              return SliverList(
                delegate: SliverChildBuilderDelegate((context, index) {
                  final data = state.music[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 5,
                    ),
                    child: musicBox(context, state.music, index, data, () {
                      context.read<FavoriteBloc>().add(
                        AddFavoriteEvent(music: data),
                      );
                      Navigator.pop(context);
                    }, 'Make Favorite'),
                  );
                }, childCount: state.music.length),
              );
            } else if (state is FailedInitializeMusicState) {
              return SliverFillRemaining(
                child: Center(child: Text("Something went wrong")),
              );
            } else {
              return SliverToBoxAdapter(child: SizedBox());
            }
          },
        );
      } else {
        // ^ my favorite bloc
        return BlocConsumer<FavoriteBloc, FavoriteState>(
          listener: (context, state) {
            if (state is SuccessAddFavoriteState) {
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(SnackBar(content: Text(state.message)));
            } else if (state is SuccessDeleteFavoriteState) {
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(SnackBar(content: Text(state.message)));
            } else if (state is FailedAddFavoriteState) {
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(SnackBar(content: Text(state.failure)));
            } else if (state is FailedDeleteFavoriteState) {
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(SnackBar(content: Text(state.failure)));
            }
          },
          bloc: context.read<FavoriteBloc>(),
          builder: (context, state) {
            if (state is LoadingFavoriteState) {
              return SliverFillRemaining(
                child: Center(child: CupertinoActivityIndicator()),
              );
            } else if (state is SuccessGetFavoriteState) {
              return SliverList(
                delegate: SliverChildBuilderDelegate((context, index) {
                  final data = state.music[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 5,
                    ),
                    child: musicBox(context, state.music, index, data, () {
                      context.read<FavoriteBloc>().add(
                        DeleteFavoriteEvent(music: data),
                      );
                      Navigator.pop(context);
                    }, "Remove From Favorite"),
                  );
                }, childCount: state.music.length),
              );
            } else if (state is FailedGetFavoriteState) {
              return SliverFillRemaining(
                child: Center(child: Text("Something went wrong")),
              );
            } else {
              return SliverToBoxAdapter(child: SizedBox());
            }
          },
        );
      }
    },
  );
}
