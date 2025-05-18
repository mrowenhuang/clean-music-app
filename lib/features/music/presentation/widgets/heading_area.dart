import 'package:clean_music_app/common/cubit/theme_cubit.dart';
import 'package:clean_music_app/common/navigator/app_navigator.dart';
import 'package:clean_music_app/core/config/app_color.dart';
import 'package:clean_music_app/core/config/app_theme.dart';
import 'package:clean_music_app/features/music/presentation/pages/search/search_pages.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Widget headingArea(BuildContext context) {
  return SliverToBoxAdapter(
    child: Padding(
      padding: AppTheme.mocPadding,
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
                alignment: Alignment.centerLeft,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Search', style: TextStyle(fontSize: 16)),
                    Icon(Icons.search),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(width: 10),
          RotatedBox(
            quarterTurns: -1,
            child: BlocBuilder<ThemeCubit, bool>(
              builder: (context, value) {
                return CupertinoSwitch(
                  value: value,
                  onChanged: (value) {
                    context.read<ThemeCubit>().changeTheme(value);
                  },
                  inactiveTrackColor: AppColor.black,
                  activeTrackColor: AppColor.secondary,
                  thumbIcon: WidgetStatePropertyAll(
                    Theme.of(context).brightness == Brightness.dark
                        ? Icon(Icons.dark_mode_rounded)
                        : Icon(Icons.sunny),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    ),
  );
}
