import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nike/ui/home/home.dart';

// in ye navigatore khafane(:(:
const int homeIndex = 0;
const int cartIndex = 1;
const int profileIndex = 2;

class RootScreen extends StatefulWidget {
  const RootScreen({super.key});

  @override
  State<RootScreen> createState() => _RootScreenState();
}

class _RootScreenState extends State<RootScreen> {
  int selectScreenIndex = homeIndex;
  final List<int> _hestory = [];

  GlobalKey<NavigatorState> _homekey = GlobalKey();
  GlobalKey<NavigatorState> _cartkey = GlobalKey();
  GlobalKey<NavigatorState> _profilekey = GlobalKey();
  late final map = {
    homeIndex: _homekey,
    cartIndex: _cartkey,
    profileIndex: _profilekey,
  };

  Future<bool> _onWillPop() async {
    final NavigatorState curentSelectedTabNavigatorState =
        map[selectScreenIndex]!.currentState!;
    if (curentSelectedTabNavigatorState.canPop()) {
      curentSelectedTabNavigatorState.pop();
      return false;
    } else if (_hestory.isNotEmpty) {
      setState(() {
        selectScreenIndex = _hestory.last;
        _hestory.removeLast();
      });
      return false;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        body: IndexedStack(
          index: selectScreenIndex,
          children: [
            _navigator(_homekey, homeIndex, const HomeScreen()),
            _navigator(
                _cartkey,
                cartIndex,
                const Center(
                  child: Text('sabad kharid'),
                )),
            _navigator(
                _profilekey,
                profileIndex,
                const Center(
                  child: Text('safe shakhsi'),
                ))
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: const [
            BottomNavigationBarItem(
                icon: Icon(CupertinoIcons.home), label: 'خانه'),
            BottomNavigationBarItem(
                icon: Icon(CupertinoIcons.cart), label: 'سبد خرید'),
            BottomNavigationBarItem(
                icon: Icon(CupertinoIcons.person), label: 'پروفایل'),
          ],
          currentIndex: selectScreenIndex,
          onTap: (selectedIndex) {
            _hestory.remove(selectScreenIndex);
            _hestory.add(selectScreenIndex);
            setState(() {
              selectScreenIndex = selectedIndex;
            });
          },
        ),
      ),
    );
  }

  Widget _navigator(GlobalKey key, int index, Widget child) {
    return key.currentState == null && selectScreenIndex != index
        ? Container()
        : Navigator(
            key: key,
            onGenerateRoute: (settings) => MaterialPageRoute(
                builder: (context) => Offstage(
                      offstage: selectScreenIndex != index,
                      child: child,
                    )),
          );
  }
}
