abstract class SharedPref {
  setUserLoggedIn(bool flag);

  bool isUserLoggedIn();

  setUserEmail(String email);

  String getUserEmail();

  setUserName(String name);

  String getUserName();

  setMobile(String mobile);

  String getMobile();

  setToken(String token);

  String getToken();

  setIsFirstTimeLogin(bool isFirstTime);

  bool getIsFirstTimeLogin();

  setRewardPoints(int points);

  int getRewardPoints();
}
