import 'dart:math';

import 'package:clean_music_app/common/navigator/app_navigator.dart';
import 'package:clean_music_app/common/playing_cubit/playing_cubit.dart';
import 'package:clean_music_app/common/playing_feature_cubit/playing_feature_cubit.dart';
import 'package:clean_music_app/core/config/app_color.dart';
import 'package:clean_music_app/features/music/presentation/bloc/always_play_music_bloc/always_play_bloc.dart';
import 'package:clean_music_app/features/music/presentation/bloc/music_bloc/music_bloc.dart';
import 'package:clean_music_app/features/music/presentation/pages/search_pages.dart';
import 'package:clean_music_app/injection.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:just_audio/just_audio.dart';
import 'package:marquee/marquee.dart';

class HomePages extends StatelessWidget {
  const HomePages({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () async {
                          AppNavigator.push(context, SearchPages());
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 20),
                          height: 50,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(15),
                            boxShadow: [
                              BoxShadow(
                                blurRadius: 4,
                                color: Colors.black45,
                                offset: Offset(0, 4),
                              ),
                            ],
                          ),
                          alignment: Alignment.centerLeft,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Search',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.black87,
                                ),
                              ),
                              Icon(Icons.search),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 10),
                    RotatedBox(
                      quarterTurns: -1,
                      child: CupertinoSwitch(
                        value: false,
                        onChanged: (value) {},
                        inactiveTrackColor: AppColor.secondary,
                        thumbIcon: WidgetStatePropertyAll(Icon(Icons.sunny)),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Music Playing Section
            SliverToBoxAdapter(
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
                              Text(
                                'Music Playing',
                                style: TextStyle(fontSize: 18),
                              ),
                              SizedBox(height: 20),
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: 15),
                                height: 220,
                                width: width,
                                decoration: BoxDecoration(
                                  color: AppColor.secondary,
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
                                        text:
                                            state.music[state.index].title
                                                .toString(),
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black,
                                          fontSize: 12,
                                        ),
                                        scrollAxis: Axis.horizontal,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        blankSpace: 60.0,
                                        velocity: 30.0,
                                        startPadding: 10.0,
                                        accelerationCurve: Curves.linear,
                                        decelerationCurve: Curves.easeOut,
                                      ),
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        IconButton(
                                          onPressed: () {
                                            context
                                                .read<PlayingCubit>()
                                                .toPrev();
                                          },
                                          icon: Icon(
                                            Icons.skip_previous_rounded,
                                          ),
                                        ),
                                        BlocBuilder<
                                          PlayingFeatureCubit,
                                          PlayingFeatureState
                                        >(
                                          bloc:
                                              context
                                                  .read<PlayingFeatureCubit>(),
                                          builder: (context, _) {
                                            final isPlaying =
                                                sl<AudioPlayer>().playing;
                                            return IconButton(
                                              onPressed: () {
                                                isPlaying
                                                    ? context
                                                        .read<
                                                          PlayingFeatureCubit
                                                        >()
                                                        .pauseMusic()
                                                    : context
                                                        .read<
                                                          PlayingFeatureCubit
                                                        >()
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
                                            context
                                                .read<PlayingCubit>()
                                                .toNext();
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
                            Text(
                              'Music Playing',
                              style: TextStyle(fontSize: 18),
                            ),
                            SizedBox(height: 20),
                            Container(
                              height: 220,
                              width: width,
                              decoration: BoxDecoration(
                                color: AppColor.secondary,
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
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text(state.message)),
                                );
                              } else if (state
                                  is SuccessDeleteAlwaysPlayState) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text(state.message)),
                                );
                              } else if (state is FailedAddAlwaysPlayState) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text(state.failure)),
                                );
                              } else if (state is FailedDeleteAlwaysPlayState) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text(state.failure)),
                                );
                              }
                            },
                            bloc: context.read<AlwaysPlayBloc>(),
                            builder: (context, state) {
                              if (state is LoadingAlwaysPlayState) {
                                return Center(
                                  child: CupertinoActivityIndicator(),
                                );
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
                                          borderRadius: BorderRadius.circular(
                                            10,
                                          ),
                                          child: GestureDetector(
                                            onTap: () {
                                              context
                                                  .read<PlayingCubit>()
                                                  .playingMusic(
                                                    state.music,
                                                    index,
                                                  );
                                            },
                                            onLongPress: () {
                                              context
                                                  .read<AlwaysPlayBloc>()
                                                  .add(
                                                    DeleteAlwaysPlayMusicEvent(
                                                      music: data,
                                                    ),
                                                  );
                                            },
                                            child: ListTile(
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10),
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
            ),

            // Favorite Button
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Align(
                  alignment: Alignment.topRight,
                  child: ElevatedButton.icon(
                    onPressed: () {},
                    label: Text('Favorite', style: TextStyle(fontSize: 18)),
                    icon: Icon(Icons.screen_rotation_alt_rounded),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ),
              ),
            ),

            // My Music Title
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  children: [
                    Text('My Music', style: TextStyle(fontSize: 18)),
                    Icon(Icons.screen_rotation_alt_rounded),
                  ],
                ),
              ),
            ),
            SliverToBoxAdapter(child: SizedBox(height: 10)),

            // Music List (Sliver)
            BlocBuilder<MusicBloc, MusicState>(
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
                        child: GestureDetector(
                          onTap: () {
                            context.read<PlayingCubit>().playingMusic(
                              state.music,
                              index,
                            );
                          },
                          child: Container(
                            height: 80,
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: AppColor.secondary,
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [
                                BoxShadow(
                                  blurRadius: 4,
                                  color: Colors.black45,
                                  offset: Offset(0, 4),
                                ),
                              ],
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Container(
                                      height: 40,
                                      width: 40,
                                      decoration: BoxDecoration(
                                        color: AppColor.black,
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                      child: Icon(
                                        Icons.music_note,
                                        color: AppColor.white,
                                      ),
                                    ),
                                    SizedBox(width: 15),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        SizedBox(
                                          width: size.width / 2,
                                          child: Text(
                                            data.title.toString(),
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          width: size.width / 2,
                                          child: Text(
                                            data.artist.toString(),
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(fontSize: 11),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                IconButton(
                                  onPressed: () {
                                    showModalBottomSheet(
                                      context: context,
                                      enableDrag: true,
                                      showDragHandle: true,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(20),
                                          topRight: Radius.circular(20),
                                        ),
                                      ),
                                      useSafeArea: true,

                                      builder: (context) {
                                        return Container(
                                          height: 200,
                                          padding: EdgeInsets.symmetric(
                                            horizontal: 20,
                                          ),
                                          child: Column(
                                            children: [
                                              Text(
                                                "Menu",
                                                style: TextStyle(fontSize: 18),
                                              ),
                                              ElevatedButton(
                                                style: ElevatedButton.styleFrom(
                                                  backgroundColor:
                                                      AppColor.secondary,
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                          10,
                                                        ),
                                                  ),
                                                  fixedSize: Size(
                                                    size.width,
                                                    50,
                                                  ),
                                                ),
                                                onPressed: () {
                                                  context
                                                      .read<AlwaysPlayBloc>()
                                                      .add(
                                                        AddAlwaysPlayMusicEvent(
                                                          music: data,
                                                        ),
                                                      );

                                                  Navigator.pop(context);
                                                },
                                                child: Text(
                                                  "Add To Always Play",
                                                  style: TextStyle(
                                                    color: AppColor.black,
                                                  ),
                                                ),
                                              ),
                                              SizedBox(height: 15),
                                              ElevatedButton(
                                                style: ElevatedButton.styleFrom(
                                                  backgroundColor:
                                                      AppColor.secondary,
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                          10,
                                                        ),
                                                  ),
                                                  fixedSize: Size(
                                                    size.width,
                                                    50,
                                                  ),
                                                ),
                                                onPressed: () {},
                                                child: Text(
                                                  "Make Favorite",
                                                  style: TextStyle(
                                                    color: AppColor.black,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        );
                                        // return Container();
                                      },
                                    );
                                  },
                                  icon: Icon(Icons.more_vert_rounded),
                                ),
                              ],
                            ),
                          ),
                        ),
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
            ),
          ],
        ),
      ),
    );
  }
}
