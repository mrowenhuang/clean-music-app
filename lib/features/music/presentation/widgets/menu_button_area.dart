import 'package:clean_music_app/common/menu_cubit/menu_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Widget menuButtonArea(BuildContext context) {
  return SliverToBoxAdapter(
    child: BlocBuilder<MenuCubit, bool>(
      bloc: context.read<MenuCubit>(),
      builder: (context, value) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Align(
            alignment: Alignment.topRight,
            child: ElevatedButton.icon(
              onPressed: () {
                context.read<MenuCubit>().changeMenu(!value);
              },
              label: Text(
                value ? 'Favorite' : 'My Music',
                style: TextStyle(fontSize: 18),
              ),
              icon: Icon(Icons.screen_rotation_alt_rounded),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ),
        );
      },
    ),
  );
}
