import 'package:clean_music_app/common/playing_cubit/playing_cubit.dart';
import 'package:clean_music_app/core/config/app_color.dart';
import 'package:clean_music_app/features/music/presentation/bloc/music_bloc/music_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:permission_handler/permission_handler.dart';

class HomePages extends StatelessWidget {
  const HomePages({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
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
                SizedBox(height: 40),
                Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Music Playing', style: TextStyle(fontSize: 18)),
                        SizedBox(height: 20),
                        Container(
                          height: 220,
                          width: 180,
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
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 20),
                Align(
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
                Row(
                  children: [
                    Text('My Music', style: TextStyle(fontSize: 18)),
                    Icon(Icons.screen_rotation_alt_rounded),
                  ],
                ),
                SizedBox(height: 10),
                BlocBuilder<MusicBloc, MusicState>(
                  bloc: context.read<MusicBloc>(),
                  builder: (context, state) {
                    if (state is LoadingInitializeMusicState) {
                      return Expanded(
                        child: Center(child: CupertinoActivityIndicator()),
                      );
                    } else if (state is SuccessInitializeMusicState) {
                      return SizedBox(
                        width: size.width,
                        height: size.height - 100,
                        child: ListView.builder(
                          itemCount: state.music.length,
                          physics: BouncingScrollPhysics(),
                          itemBuilder: (context, index) {
                            final data = state.music[index];
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 10),
                              child: GestureDetector(
                                onTap: () {
                                  context.read<PlayingCubit>().playMusic(
                                    state.music,
                                    index,
                                  );
                                },
                                child: Container(
                                  height: 80,
                                  padding: EdgeInsets.all(10),
                                  margin: EdgeInsets.symmetric(horizontal: 10),
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
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          Container(
                                            height: 40,
                                            width: 40,
                                            decoration: BoxDecoration(
                                              color: AppColor.black,
                                              borderRadius:
                                                  BorderRadius.circular(5),
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
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: TextStyle(
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ),
                                              Text(
                                                data.artist.toString(),
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                                style: TextStyle(fontSize: 11),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                      IconButton(
                                        onPressed: () {},
                                        icon: Icon(Icons.more_vert_rounded),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      );
                    }
                    return Text("Data");
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
