import 'package:clean_music_app/common/navigator/app_navigator.dart';
import 'package:clean_music_app/common/playing_cubit/playing_cubit.dart';
import 'package:clean_music_app/core/config/app_color.dart';
import 'package:clean_music_app/features/music/presentation/bloc/always_play_music_bloc/always_play_bloc.dart';
import 'package:clean_music_app/features/music/presentation/bloc/favorite_bloc/favorite_bloc.dart';
import 'package:clean_music_app/features/music/presentation/bloc/search_bloc/search_bloc.dart';
import 'package:clean_music_app/features/music/presentation/pages/home_pages.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchPages extends StatelessWidget {
  const SearchPages({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController searchC = TextEditingController();
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text(
          "Search Page",
          style: TextStyle(color: AppColor.black, fontSize: 18),
        ),
        centerTitle: true,
        elevation: 0,
        leading: IconButton(
          splashRadius: 1,
          onPressed: () {
            context.read<SearchBloc>().add(ResetSearchMusicEvent());
            AppNavigator.pushRemove(context, HomePages());
          },
          icon: Icon(Icons.arrow_back_ios_new_rounded, color: AppColor.black),
        ),
      ),
      body: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              Material(
                elevation: 5,
                borderRadius: BorderRadius.circular(15),
                child: TextField(
                  controller: searchC,
                  cursorColor: AppColor.black,
                  decoration: InputDecoration(
                    hintText: 'Search',
                    suffixIcon: Icon(Icons.search, color: AppColor.black),
                    border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                  onSubmitted: (value) {
                    context.read<SearchBloc>().add(
                      GetSearchMusicEvent(data: value),
                    );
                  },
                ),
              ),
              SizedBox(height: 20),
              Expanded(
                child: BlocBuilder<SearchBloc, SearchState>(
                  bloc: context.read<SearchBloc>(),
                  builder: (context, state) {
                    if (state is LoadingSearchMusicState) {
                      return Center(child: CupertinoActivityIndicator());
                    } else if (state is SuccessGetSearchMusicState) {
                      if (state.music.isEmpty) {
                        return Center(child: Text("No Music"));
                      } else {
                        return ListView.builder(
                          itemCount: state.music.length,
                          itemBuilder: (context, index) {
                            final data = state.music[index];
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 10),
                              child: GestureDetector(
                                onTap: () async{
                                  await context.read<PlayingCubit>().playingMusic(
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
                                              SizedBox(
                                                width: size.width / 2,
                                                child: Text(
                                                  data.artist.toString(),
                                                  maxLines: 1,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: TextStyle(
                                                    fontSize: 11,
                                                  ),
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
                                                      style: TextStyle(
                                                        fontSize: 18,
                                                      ),
                                                    ),
                                                    SizedBox(height: 20),
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
                                                            .read<
                                                              AlwaysPlayBloc
                                                            >()
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
                                                      onPressed: () {
                                                        context
                                                            .read<
                                                              FavoriteBloc
                                                            >()
                                                            .add(
                                                              AddFavoriteEvent(
                                                                music: data,
                                                              ),
                                                            );
                                                        Navigator.pop(context);
                                                      },
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
                          },
                        );
                      }
                    } else if (state is FailedGetSearchMusicState) {
                      return Center(child: Text(state.failure));
                    }
                    return SizedBox();
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
