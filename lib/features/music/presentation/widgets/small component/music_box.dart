import 'package:clean_music_app/common/playing_cubit/playing_cubit.dart';
import 'package:clean_music_app/core/config/app_color.dart';
import 'package:clean_music_app/features/music/domain/entities/music_entities.dart';
import 'package:clean_music_app/features/music/presentation/bloc/always_play_music_bloc/always_play_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Widget musicBox(
  BuildContext context,
  List<MusicEntities> listMusic,
  int index,
  MusicEntities data,
  VoidCallback favAction,
  String favText,
) {
  final size = MediaQuery.of(context).size;
  return GestureDetector(
    onTap: () {
      context.read<PlayingCubit>().playingMusic(listMusic, index);
    },
    child: Container(
      height: 80,
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color:
            Theme.of(context).brightness == Brightness.dark
                ? AppColor.dark
                : AppColor.secondary,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(blurRadius: 4, color: Colors.black45, offset: Offset(0, 4)),
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
                child: Icon(Icons.music_note, color: AppColor.white),
              ),
              SizedBox(width: 15),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
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
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      children: [
                        Text("Menu", style: TextStyle(fontSize: 18)),
                        SizedBox(height: 20),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                Theme.of(context).brightness == Brightness.dark
                                    ? AppColor.dark
                                    : AppColor.secondary,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            fixedSize: Size(size.width, 50),
                          ),
                          onPressed: () {
                            context.read<AlwaysPlayBloc>().add(
                              AddAlwaysPlayMusicEvent(music: data),
                            );

                            Navigator.pop(context);
                          },
                          child: Text(
                            "Add To Always Play",
                            style: TextStyle(
                              color:
                                  Theme.of(context).brightness ==
                                          Brightness.dark
                                      ? AppColor.white
                                      : AppColor.black,
                            ),
                          ),
                        ),
                        SizedBox(height: 15),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                Theme.of(context).brightness == Brightness.dark
                                    ? AppColor.dark
                                    : AppColor.secondary,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            fixedSize: Size(size.width, 50),
                          ),
                          onPressed: favAction,
                          child: Text(
                            favText,
                            style: TextStyle(
                              color:
                                  Theme.of(context).brightness ==
                                          Brightness.dark
                                      ? AppColor.white
                                      : AppColor.black,
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              );
            },
            icon: Icon(Icons.more_vert_rounded),
          ),
        ],
      ),
    ),
  );
}
