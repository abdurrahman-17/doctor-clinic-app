import 'package:doctor_clinic_token_app/Utils/common/app_locator.dart';
import 'package:doctor_clinic_token_app/core/domain/repo/api_base_helper.dart';
import 'package:doctor_clinic_token_app/core/entities/response.dart';
import 'package:doctor_clinic_token_app/core/source/shared_pref/shared_pref.dart';
import 'package:flutter/foundation.dart';
import 'loading_state.dart';

abstract class BaseChangeNotifier with ChangeNotifier {
  LoadingState _loadingState = LoadingState.Idle;
  ValueNotifier<String> showToast = ValueNotifier<String>('');
  ApiBaseHelper api = ApiBaseHelper();
  //final SharedPref prefs = locator.get<SharedPref>();

  bool _isLoading = false;


  bool get isLoading => _isLoading;

  set isLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  bool _disposed = false;

  LoadingState get loadingState => this._loadingState;

  void setLoadingState(LoadingState loadingState) {
    _loadingState = loadingState;
    this.notify();
  }

  bool getResponseStatus(Response response) {
    return response != null && Status.SUCCESS == response.status;
  }

  void notify() {
    notifyListeners();
  }

  void showToastMessage(String _stMessage) {
    showToast.value = '';
    showToast.value = _stMessage;
  }

  @override
  void notifyListeners() {
    //to avoid calling listeners after notifier is disposed
    if (!_disposed) {
      super.notifyListeners();
    }
  }

  @override
  void dispose() {
    _disposed = true;
    super.dispose();
  }

  void LogPrint(Object object) async {
    int defaultPrintLength = 1020;
    if (object == null || object.toString().length <= defaultPrintLength) {
      print(object);
    } else {
      String log = object.toString();
      int start = 0;
      int endIndex = defaultPrintLength;
      int logLength = log.length;
      int tmpLogLength = log.length;
      while (endIndex < logLength) {
        print(log.substring(start, endIndex));
        endIndex += defaultPrintLength;
        start += defaultPrintLength;
        tmpLogLength -= defaultPrintLength;
      }
      if (tmpLogLength > 0) {
        print(log.substring(start, logLength));
      }
    }
  }
}
