import 'package:flutter/cupertino.dart';
import 'package:nike/common/http_client.dart';
import 'package:nike/data/auth_info.dart';
import 'package:nike/data/source/auth_data_source.dart';
import 'package:shared_preferences/shared_preferences.dart';

final authRepository = AuthRepository(AuthRemoteDataSource(httpClient));

abstract class IAuthRepository {
  Future<void> login(String username, String password);
  Future<void> singUp(String username, String password);
  Future<void> refreshToken();
}

class AuthRepository implements IAuthRepository {
  static final ValueNotifier<AuthInfo?> authChangeNotifier =
      ValueNotifier(null);
  final IAuthDataSource dataSource;

  AuthRepository(
    this.dataSource,
  );
  @override
  Future<void> login(String username, String password) async {
    final AuthInfo authInfo = await dataSource.login(username, password);
    _persistAuthTokens(authInfo);
  }

  @override
  Future<void> singUp(String username, String password) async {
    final AuthInfo authInfo = await dataSource.singUp(username, password);
    _persistAuthTokens(authInfo);
  }

  @override
  Future<void> refreshToken() async {
    final AuthInfo authInfo = await dataSource.refreshToken(token);
    _persistAuthTokens(authInfo);
  }

  Future<void> _persistAuthTokens(AuthInfo authInfo) async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    sharedPreferences.setString("access_token", authInfo.accessToken);
    sharedPreferences.setString("refresh_token", authInfo.refreshToken);
  }

  Future<void> loadAuthInfo() async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    final String accessToken =
        sharedPreferences.getString("access_token") ?? "";

    final String refreshToken =
        sharedPreferences.getString("refresh_token") ?? "";
    if (accessToken.isNotEmpty && refreshToken.isNotEmpty) {
      authChangeNotifier.value = AuthInfo(accessToken, refreshToken);
    }
  }
}
