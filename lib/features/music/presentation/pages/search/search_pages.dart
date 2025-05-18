import 'package:clean_music_app/common/navigator/app_navigator.dart';
import 'package:clean_music_app/core/config/app_color.dart';
import 'package:clean_music_app/core/config/app_theme.dart';
import 'package:clean_music_app/features/music/presentation/bloc/always_play_music_bloc/always_play_bloc.dart';
import 'package:clean_music_app/features/music/presentation/bloc/search_bloc/search_bloc.dart';
import 'package:clean_music_app/features/music/presentation/pages/home/home_pages.dart';
import 'package:clean_music_app/features/music/presentation/widgets/small%20component/music_box.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchPages extends StatelessWidget {
  const SearchPages({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController searchC = TextEditingController();

    return Scaffold(
      // appBar: AppBar(
      //   backgroundColor: Colors.transparent,
      //   title: Text(
      //     "Search Page",
      //     style: TextStyle(
      //       color:
      //           Theme.of(context).brightness == Brightness.dark
      //               ? AppColor.white
      //               : AppColor.black,
      //       fontSize: 18,
      //     ),
      //   ),
      //   centerTitle: true,
      //   elevation: 0,
      //   leading: IconButton(
      //     splashRadius: 1,
      //     onPressed: () {
      //       context.read<SearchBloc>().add(ResetSearchMusicEvent());
      //       AppNavigator.pushRemove(context, HomePages());
      //     },
      //     icon: Icon(
      //       Icons.arrow_back_ios_new_rounded,
      //       color:
      //           Theme.of(context).brightness == Brightness.dark
      //               ? AppColor.white
      //               : AppColor.black,
      //     ),
      //   ),
      // ),
      appBar: AppTheme.customAppbar("Search", context, Colors.white),
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
                  cursorColor:
                      Theme.of(context).brightness == Brightness.dark
                          ? AppColor.white
                          : AppColor.black,
                  decoration: InputDecoration(
                    hintText: 'Search',
                    suffixIcon: Icon(
                      Icons.search,
                      color:
                          Theme.of(context).brightness == Brightness.dark
                              ? AppColor.white
                              : AppColor.black,
                    ),
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
                              child: musicBox(
                                context,
                                state.music,
                                index,
                                data,
                                () {
                                  context.read<AlwaysPlayBloc>().add(
                                    AddAlwaysPlayMusicEvent(music: data),
                                  );

                                  Navigator.pop(context);
                                },
                                "Make Favorite",
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
