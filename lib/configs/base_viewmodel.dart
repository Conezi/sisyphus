import 'package:flutter/foundation.dart';

enum ViewState { idle, loading, processing, success, failed }

class BaseViewModel extends ChangeNotifier {
  ViewState _state = ViewState.idle;

  ViewState get state => _state;

  void setViewState(ViewState state) {
    _state = state;
    notifyListeners();
  }
}
