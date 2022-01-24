import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news/constant/constant.dart';
import 'package:news/layout/news_app/cubit/states.dart';
import 'package:flutter/material.dart';
import 'package:news/modules/business/business_screen.dart';
import 'package:news/modules/science/science_Screen.dart';
import 'package:news/modules/setting/setting.dart';
import 'package:news/modules/sports/sport_screen.dart';
import 'package:news/shared/network/remote/dio_helper.dart';

class NewsCubit extends Cubit<NewsStates> {
  NewsCubit() : super(NewInitialState());

  static NewsCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;
  List<BottomNavigationBarItem> bottomItem = [
    const BottomNavigationBarItem(
      icon: Icon(Icons.business),
      label: 'Business',
    ),
    const BottomNavigationBarItem(
      icon: Icon(Icons.sports),
      label: 'Sport',
    ),
    const BottomNavigationBarItem(
      icon: Icon(Icons.science_outlined),
      label: 'Science',
    ),
    // const BottomNavigationBarItem(
    //   icon: Icon(Icons.settings),
    //   label: 'Settings',
    // ),
  ];
  List<Widget> screens = [
    const BusinessScreen(),
    const SportScreen(),
    const ScienceScreen(),
    // const Setting(),
  ];

  void changeBottomNav(int index) {
    currentIndex = index;
    // if (index == 1) {
    //   getSportData();
    // }
    // if (index == 2) {
    //   getScienceData();
    // }
    // if (index == 3) {
    //   getSearchData(value: value);
    // }
    emit(NewBottomNavState());
  }

  List<dynamic> business = [];

  void getBusinessData() {
    emit(NewsGetBusinessLoadedState());
    DioHelper.getData(
      url: urlNews,
      query: {
        'country': 'eg',
        'category': 'business',
        'apiKey': apiKey,
      },
    ).then((value) {
      business = value.data['articles'];
      print(business[0]['title']);
      emit(NewsGetBusinessSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(NewsGetBusinessErrorState(error));
    });
  }

  List<dynamic> sports = [];

  void getSportData() {
    emit(NewsGetSportLoadedState());
    if (sports.length == 0) {
      DioHelper.getData(url: urlNews, query: {
        'country': 'eg',
        'category': 'sports',
        'apiKey': apiKey,
      }).then((value) {
        sports = value.data['articles'];
        emit(NewsGetSportSuccessState());
      }).catchError((error) {
        print(error.toString());
        emit(NewsGetSportErrorState(error));
      });
    } else {
      emit(NewsGetSportSuccessState());
    }
  }

  List<dynamic> science = [];

  void getScienceData() {
    emit(NewsGetScienceLoadedState());
    if (science.length == 0) {
      DioHelper.getData(url: urlNews, query: {
        'country': 'eg',
        'category': 'science',
        'apiKey': apiKey,
      }).then((value) {
        science = value.data['articles'];
        emit(NewsGetScienceSuccessState());
      }).catchError((error) {
        print(error.toString());
        emit(NewsGetScienceErrorState(error));
      });
    } else {
      emit(NewsGetScienceSuccessState());
    }
  }

  List<dynamic> search = [];

  void getSearchData(String value) {
    emit(NewsGetSearchLoadedState());
    search = [];
    DioHelper.getData(url: urlNews, query: {
      'q': value,
      'apiKey': apiKey,
    }).then((value) {
      search = value.data['articles'];
      print(search[0]['title']);

      emit(NewsGetSearchSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(NewsGetSearchErrorState(error));
    });
  }
}
