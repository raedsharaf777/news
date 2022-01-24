abstract class NewsStates {}

class NewInitialState extends NewsStates {}

class NewBottomNavState extends NewsStates {}
//..............................................................................

class NewsGetBusinessLoadedState extends NewsStates {}

class NewsGetBusinessSuccessState extends NewsStates {}

class NewsGetBusinessErrorState extends NewsStates {
  final String error;

  NewsGetBusinessErrorState(this.error);
}
//..............................................................................

class NewsGetSportLoadedState extends NewsStates {}

class NewsGetSportSuccessState extends NewsStates {}

class NewsGetSportErrorState extends NewsStates {
  final String error;

  NewsGetSportErrorState(this.error);
}
//..............................................................................

class NewsGetScienceLoadedState extends NewsStates {}

class NewsGetScienceSuccessState extends NewsStates {}

class NewsGetScienceErrorState extends NewsStates {
  final String error;

  NewsGetScienceErrorState(this.error);
}
//..............................................................................

class NewsGetSearchLoadedState extends NewsStates {}

class NewsGetSearchSuccessState extends NewsStates {}

class NewsGetSearchErrorState extends NewsStates {
  final String error;

  NewsGetSearchErrorState(this.error);
}
//..............................................................................
