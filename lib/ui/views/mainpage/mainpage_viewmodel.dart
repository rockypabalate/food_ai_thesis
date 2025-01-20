import 'package:stacked/stacked.dart';

class MainpageViewModel extends BaseViewModel {
  int _currentIndex = 0;

  int get currentIndex => _currentIndex;

  void onTabTapped(int index) {
    if (index == _currentIndex) return;

    _currentIndex = index;
    notifyListeners();
  }
}
