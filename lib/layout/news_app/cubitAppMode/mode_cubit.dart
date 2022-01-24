import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:news/shared/network/local/cache_helper.dart';

part 'mode_state.dart';

class ModeCubit extends Cubit<ModeState> {
  ModeCubit() : super(ModeInitial());

  static ModeCubit get(context) => BlocProvider.of(context);

  bool isDark = false;

  void changeAppMode({ bool? fromShared}) {
    if (fromShared != null) {
      isDark = fromShared;

      CacheHelper.putBooleanData(key: 'isDark', value: isDark).then((value) {
        emit(NewsAppChangeModeState());
      });
    } else {
      isDark = !isDark;
      CacheHelper.putBooleanData(key: 'isDark', value: isDark).then((value) {
        emit(NewsAppChangeModeState());
      });
    }
  }
}
