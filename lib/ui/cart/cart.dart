import 'package:flutter/material.dart';
import 'package:nike/data/auth_info.dart';
import 'package:nike/data/repo/auth_repository.dart';
import 'package:nike/ui/auth/auth.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('سبد خرید'),
      ),
      body: ValueListenableBuilder<AuthInfo?>(
        valueListenable: AuthRepository.authChangeNotifier,
        builder: (context, authState, child) {
          bool isAuthenticated =
              authState != null && authState!.accessToken.isNotEmpty;
          return SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(isAuthenticated
                    ? 'خوش آمدید '
                    : 'لطفا وارد حساب کاربری خود شوید'),
                isAuthenticated
                    ? ElevatedButton(
                        onPressed: () {
                          authRepository.singOut();
                        },
                        child: const Text('خروج از حساب'),
                      )
                    : ElevatedButton(
                        onPressed: () {
                          Navigator.of(context, rootNavigator: true).push(
                              MaterialPageRoute(
                                  builder: (context) => const AuthScreen()));
                        },
                        child: const Text('ورود'))
              ],
            ),
          );
        },
      ),
    );
  }
}
