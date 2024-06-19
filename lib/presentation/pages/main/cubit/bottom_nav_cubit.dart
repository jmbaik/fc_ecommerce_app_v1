import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/theme/constant/app_icons.dart';

enum BottomNav { home, category, search, user }

class BottomNavCubit extends Cubit<BottomNav> {
  BottomNavCubit() : super(BottomNav.home);

  void changeIndex(int index) => emit(BottomNav.values[index]);
}

extension BottomNavX on BottomNav {
  String get icon {
    switch (this) {
      case BottomNav.home:
        return AppIcons.navHome;
      case BottomNav.search:
        return AppIcons.navSearch;
      case BottomNav.category:
        return AppIcons.navCategory;
      case BottomNav.user:
        return AppIcons.navUser;
    }
  }

  String get activeIcon {
    switch (this) {
      case BottomNav.home:
        return AppIcons.navHomeOn;
      case BottomNav.search:
        return AppIcons.navSearchOn;
      case BottomNav.category:
        return AppIcons.navCategoryOn;
      case BottomNav.user:
        return AppIcons.navUserOn;
    }
  }

  String get toName {
    switch (this) {
      case BottomNav.home:
        return '홈';
      case BottomNav.search:
        return '검색';
      case BottomNav.category:
        return '카테고리';
      case BottomNav.user:
        return '마이페이지';
    }
  }
}