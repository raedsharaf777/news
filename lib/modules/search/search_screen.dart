import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news/layout/news_app/cubit/cubit.dart';
import 'package:news/layout/news_app/cubit/states.dart';
import 'package:news/shared/componant/componant.dart';

class SearchScreen extends StatelessWidget {
  var searchController = TextEditingController();

  SearchScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var list = NewsCubit.get(context).search;

    return BlocConsumer<NewsCubit, NewsStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return buildSearchList(context, list);
      },
    );
  }

  Widget buildSearchList(context, list) {
    return Scaffold(
      appBar: AppBar(
          //    title: const Text('Search'),
          ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: defaultTextFromField(
              controller: searchController,
              labelText: 'Search',
              prefixIcon: const Icon(Icons.search),
              type: TextInputType.text,
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Search Must Not Be Empty';
                } else {
                  return null;
                }
              },
              onChange: (String value) {
                NewsCubit.get(context).getSearchData(value);
              },
            ),
          ),
          Expanded(child: articleBuilder(list, context, isSearch: true)),
        ],
      ),
    );
  }
}
