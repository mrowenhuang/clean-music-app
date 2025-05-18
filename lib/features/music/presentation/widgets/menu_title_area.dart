import 'package:clean_music_app/common/menu_cubit/menu_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Widget menuTitleArea(BuildContext context) {
  return SliverToBoxAdapter(
    child: BlocBuilder<MenuCubit, bool>(
      bloc: context.read<MenuCubit>(),
      builder: (context, value) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            children: [
              Text(
                value ? 'My Music' : 'Favorite',
                style: TextStyle(fontSize: 18),
              ),
              Icon(Icons.screen_rotation_alt_rounded),
            ],
          ),
        );
      },
    ),
  );
}
