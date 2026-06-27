import 'package:shared_preferences/shared_preferences.dart';
import 'helper_methods.dart';
import '../../views/auth/login.dart';

class CacheHelper {
  static late SharedPreferences _prefs;



  static Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  // First time
  static Future<void> setNotFirstTime() async {
    await _prefs.setBool('isFirstTime', false);
  }

  static bool get isFirstTime =>
      _prefs.getBool('isFirstTime') ?? true;

  // Auth
  static String get token =>
      _prefs.getString('token') ?? '';

  static bool get isAuth => token.isNotEmpty;

  // User data (from UserModel)
  static int get id =>
      _prefs.getInt('id') ?? 0;

  static String get email =>
      _prefs.getString('email') ?? '';

  static String get name =>
      _prefs.getString('name') ?? '';

  static String get image {
    final img = _prefs.getString('imageUrl');
    if (img != null && img.isNotEmpty) return img;

    return 'https://via.placeholder.com/150';
  }

  // Save user (ONLY what exists in UserModel)

  static Future<void> saveUser({
    required UserModel user,
  }) async {
    await _prefs.setString('token', user.token);
    await _prefs.setInt('id', user.id);
    await _prefs.setString('email', user.email);
    await _prefs.setString('name', user.name);
    await _prefs.setString('imageUrl', user.imageUrl);
  }

  static Future<void> logout() async {
    await _prefs.remove('token');
    await _prefs.remove('id');
    await _prefs.remove('email');
    await _prefs.remove('name');
    await _prefs.remove('imageUrl');

    goTo(
      LoginView(),
      canPop: false,
    );
  }
}