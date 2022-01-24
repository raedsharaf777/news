import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news/layout/news_app/cubit/cubit.dart';
import 'package:news/layout/news_app/cubit/states.dart';
import 'package:news/modules/search/search_screen.dart';
import 'package:news/shared/componant/componant.dart';
import 'cubit/cubit.dart';
import 'cubit/states.dart';
import 'cubitAppMode/mode_cubit.dart';

class NewsLayout extends StatelessWidget {
  const NewsLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit, NewsStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = NewsCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: const Text('News'),
            actions: [
              IconButton(
                icon: const Icon(
                  Icons.search,
                ),
                onPressed: () {
                  navigateTo(context: context, widget: SearchScreen());
                },
              ),
              IconButton(
                icon: const Icon(
                  Icons.brightness_4_outlined,
                ),
                onPressed: () {
                  ModeCubit.get(context).changeAppMode();
                },
              ),
            ],
          ),
          body: cubit.screens[cubit.currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: cubit.currentIndex,
            items: cubit.bottomItem,
            onTap: (index) {
              cubit.changeBottomNav(index);
            },
          ),
        );
      },
    );
  }
}
