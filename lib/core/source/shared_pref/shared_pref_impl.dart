import 'package:doctor_clinic_token_app/core/source/shared_pref/shared_pref.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefImpl implements SharedPref {
  SharedPreferences _prefs;

  SharedPrefImpl(this._prefs);

  @override
  bool isUserLoggedIn() {
    print("Inside isUserLoggedIn");
    return _prefs.getBool("isLoggedIn") ?? false;
  }

  @override
  setUserLoggedIn(bool flag) async {
    await _prefs.setBool("isLoggedIn", flag);
  }

  @override
  String getToken() {
    return _prefs.getString("authToken") ?? "";
  }

  @override
  setToken(String token) async {
    await _prefs.setString("authToken", token);
  }

  @override
  String getUserEmail() {
    return _prefs.getString("userEmail") ?? "";
  }

  @override
  setUserEmail(String email) async {
    await _prefs.setString("userEmail", email);
  }

  @override
  String getUserName() {
    return _prefs.getString("userName") ?? "";
  }

  @override
  setUserName(String name) async {
    await _prefs.setString("userName", name);
  }

  @override
  bool getIsFirstTimeLogin() {
    return _prefs.getBool("isFirstTime") ?? false;
  }

  @override
  setIsFirstTimeLogin(bool isFirstTime) async {
    await _prefs.setBool("isFirstTime", isFirstTime);
  }

  @override
  int getRewardPoints() {
    return _prefs.getInt("rewardPoints") ?? 0;
  }

  @override
  setRewardPoints(int points) async {
    await _prefs.setInt("rewardPoints", points);
  }

  @override
  String getMobile() {
    return _prefs.getString("mobileNumber") ?? '0';
  }

  @override
  setMobile(String mobile) async{
    await _prefs.setString("mobileNumber", mobile);
  }
}
