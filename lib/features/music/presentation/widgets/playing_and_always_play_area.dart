import 'dart:math';

import 'package:clean_music_app/common/playing_cubit/playing_cubit.dart';
import 'package:clean_music_app/common/playing_feature_cubit/playing_feature_cubit.dart';
import 'package:clean_music_app/core/config/app_color.dart';
import 'package:clean_music_app/features/music/presentation/bloc/always_play_music_bloc/always_play_bloc.dart';
import 'package:clean_music_app/injection.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:just_audio/just_audio.dart';
import 'package:marquee/marquee.dart';

Widget playingAndAlwaysPlayArea(BuildContext context) {
  final size = MediaQuery.of(context).size;

  return SliverToBoxAdapter(
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          BlocBuilder<PlayingCubit, PlayingState>(
            bloc: context.read<PlayingCubit>(),
            builder: (context, state) {
              final width = max((size.width / 2) - 20, 150.0);
              if (state is SuccessPlayingMusicState) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Music Playing', style: TextStyle(fontSize: 18)),
                    SizedBox(height: 20),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 15),
                      height: 220,
                      width: width,
                      decoration: BoxDecoration(
                        color:
                            Theme.of(context).brightness == Brightness.dark
                                ? AppColor.dark
                                : AppColor.secondary,
                        borderRadius: BorderRadius.circular(15),
                        boxShadow: [
                          BoxShadow(
                            blurRadius: 4,
                            color: Colors.black45,
                            offset: Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            height: 80,
                            width: 80,
                            decoration: BoxDecoration(
                              color: AppColor.black,
                              borderRadius: BorderRadius.circular(15),
                              boxShadow: [
                                BoxShadow(
                                  blurRadius: 4,
                                  color: Colors.black45,
                                  offset: Offset(0, 4),
                                ),
                              ],
                            ),
                            child: Icon(
                              Icons.music_note,
                              color: AppColor.white,
                              size: 40,
                            ),
                          ),
                          SizedBox(height: 10),
                          SizedBox(
                            width: 200,
                            height: 20,
                            child: Marquee(
                              text: state.music[state.index].title.toString(),
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color:
                                    Theme.of(context).brightness ==
                                            Brightness.dark
                                        ? AppColor.white
                                        : AppColor.black,
                                fontSize: 12,
                              ),
                              scrollAxis: Axis.horizontal,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              blankSpace: 60.0,
                              velocity: 30.0,
                              startPadding: 10.0,
                              accelerationCurve: Curves.linear,
                              decelerationCurve: Curves.easeOut,
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              IconButton(
                                onPressed: () {
                                  context.read<PlayingCubit>().toPrev();
                                },
                                icon: Icon(Icons.skip_previous_rounded),
                              ),
                              BlocBuilder<
                                PlayingFeatureCubit,
                                PlayingFeatureState
                              >(
                                bloc: context.read<PlayingFeatureCubit>(),
                                builder: (context, _) {
                                  final isPlaying = sl<AudioPlayer>().playing;
                                  return IconButton(
                                    onPressed: () {
                                      isPlaying
                                          ? context
                                              .read<PlayingFeatureCubit>()
                                              .pauseMusic()
                                          : context
                                              .read<PlayingFeatureCubit>()
                                              .playMusic();
                                    },
                                    icon: Icon(
                                      isPlaying
                                          ? Icons.pause_rounded
                                          : Icons.play_arrow_rounded,
                                    ),
                                  );
                                },
                              ),
                              IconButton(
                                onPressed: () {
                                  context.read<PlayingCubit>().toNext();
                                },
                                icon: Icon(Icons.skip_next_rounded),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              }

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Music Playing', style: TextStyle(fontSize: 18)),
                  SizedBox(height: 20),
                  Container(
                    height: 220,
                    width: width,
                    decoration: BoxDecoration(
                      color:
                          Theme.of(context).brightness == Brightness.dark
                              ? AppColor.dark
                              : AppColor.secondary,
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: [
                        BoxShadow(
                          blurRadius: 4,
                          color: Colors.black45,
                          offset: Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          height: 80,
                          width: 80,
                          decoration: BoxDecoration(
                            color: AppColor.black,
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Icon(
                            Icons.music_note,
                            color: AppColor.white,
                            size: 40,
                          ),
                        ),
                        SizedBox(height: 10),
                        Text("No music playing"),
                      ],
                    ),
                  ),
                ],
              );
            },
          ),
          SizedBox(width: 20),
          Column(
            children: [
              Text('Always Play', style: TextStyle(fontSize: 18)),
              SizedBox(height: 20),
              SizedBox(
                height: 220,
                width: size.width / 2 - 40,
                child: BlocConsumer<AlwaysPlayBloc, AlwaysPlayState>(
                  listener: (context, state) {
                    if (state is SuccessAddAlwaysPlayState) {
                      ScaffoldMessenger.of(
                        context,
                      ).showSnackBar(SnackBar(content: Text(state.message)));
                    } else if (state is SuccessDeleteAlwaysPlayState) {
                      ScaffoldMessenger.of(
                        context,
                      ).showSnackBar(SnackBar(content: Text(state.message)));
                    } else if (state is FailedAddAlwaysPlayState) {
                      ScaffoldMessenger.of(
                        context,
                      ).showSnackBar(SnackBar(content: Text(state.failure)));
                    } else if (state is FailedDeleteAlwaysPlayState) {
                      ScaffoldMessenger.of(
                        context,
                      ).showSnackBar(SnackBar(content: Text(state.failure)));
                    }
                  },
                  bloc: context.read<AlwaysPlayBloc>(),
                  builder: (context, state) {
                    if (state is LoadingAlwaysPlayState) {
                      return Center(child: CupertinoActivityIndicator());
                    } else if (state is SuccessGetAlwaysPlayState) {
                      if (state.music.isEmpty) {
                        return Text("No Music");
                      } else {
                        return ListView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: state.music.length,
                          itemBuilder: (context, index) {
                            final data = state.music[index];
                            return Padding(
                              padding: const EdgeInsets.only(
                                right: 5,
                                left: 5,
                                bottom: 10,
                              ),
                              child: Material(
                                elevation: 5,
                                borderRadius: BorderRadius.circular(10),
                                child: GestureDetector(
                                  onTap: () async {
                                    await context
                                        .read<PlayingCubit>()
                                        .playingMusic(state.music, index);
                                  },
                                  onLongPress: () {
                                    context.read<AlwaysPlayBloc>().add(
                                      DeleteAlwaysPlayMusicEvent(music: data),
                                    );
                                  },
                                  child: ListTile(
                                    tileColor:
                                        Theme.of(context).brightness ==
                                                Brightness.dark
                                            ? AppColor.dark
                                            : AppColor.secondary,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    title: Text(
                                      data.title.toString(),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    trailing: Text(
                                      (index + 1).toString(),
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        );
                      }
                    } else if (state is FailedGetAlwaysPlayState) {
                      return Center(child: Text(state.failure));
                    }
                    return SizedBox();
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    ),
  );
}
