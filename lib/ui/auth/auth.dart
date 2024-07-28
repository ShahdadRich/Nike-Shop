import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nike/data/repo/auth_repository.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    const onBackground = Colors.white;

    return Theme(
      data: themeData.copyWith(
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
              minimumSize: const WidgetStatePropertyAll(
                Size.fromHeight(56),
              ),
              backgroundColor: const WidgetStatePropertyAll(onBackground),
              foregroundColor:
                  WidgetStatePropertyAll(themeData.colorScheme.secondary)),
        ),
        colorScheme: themeData.colorScheme.copyWith(onSurface: onBackground),
        inputDecorationTheme: InputDecorationTheme(
            labelStyle: const TextStyle(color: onBackground),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(color: Colors.white, width: 1))),
      ),
      child: Scaffold(
        backgroundColor: themeData.colorScheme.secondary,
        body: Padding(
          padding: const EdgeInsets.only(left: 48, right: 48),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                'assets/img/nike_logo.png',
                color: Colors.white,
                width: 180,
              ),
              Text(
                isLogin ? 'خوش آمدید' : 'ثبت نام',
                style: TextStyle(color: onBackground, fontSize: 22),
              ),
              const SizedBox(
                height: 16,
              ),
              Text(
                isLogin
                    ? 'لطفا وارد حساب کاربری خود شوید'
                    : 'لطفا ایمیل و رمز عبور خود را تعیین کنید',
                style: TextStyle(color: onBackground),
              ),
              const SizedBox(
                height: 24,
              ),
              const TextField(
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(label: Text('آدرس ایمل')),
              ),
              const SizedBox(
                height: 16,
              ),
              _PassWordTextField(onBackground: onBackground),
              const SizedBox(
                height: 16,
              ),
              ElevatedButton(
                onPressed: () {
                  authRepository.login("test@gmail.com", "123456");
                },
                child: Text(isLogin ? 'ورود' : 'ثبت نام'),
              ),
              const SizedBox(
                height: 24,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    isLogin ? 'حساب کاربری ندارید؟' : 'حساب کاربری دارید؟',
                    style: TextStyle(color: onBackground.withOpacity(.7)),
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        isLogin = !isLogin;
                      });
                    },
                    child: Text(
                      isLogin ? 'ثبت نام' : 'ورود',
                      style: TextStyle(
                          color: themeData.colorScheme.primary,
                          decoration: TextDecoration.underline),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

class _PassWordTextField extends StatefulWidget {
  const _PassWordTextField({
    super.key,
    required this.onBackground,
  });

  final Color onBackground;

  @override
  State<_PassWordTextField> createState() => _PassWordTextFieldState();
}

class _PassWordTextFieldState extends State<_PassWordTextField> {
  bool obscureText = true;
  @override
  Widget build(BuildContext context) {
    return TextField(
      keyboardType: TextInputType.visiblePassword,
      obscureText: obscureText,
      decoration: InputDecoration(
          suffixIcon: IconButton(
            onPressed: () {
              setState(() {
                obscureText = !obscureText;
              });
            },
            icon: Icon(
              obscureText
                  ? Icons.visibility_outlined
                  : Icons.visibility_off_outlined,
              color: widget.onBackground.withOpacity(0.6),
            ),
          ),
          label: const Text('رمز عبور')),
    );
  }
}
