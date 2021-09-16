import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sense_battle/providers/provider_signin.dart';
import 'package:sense_battle/screens/history/screen_make_sentence_history.dart';
import 'package:sense_battle/screens/make_sentence/screen_make_sentence.dart';
import 'package:sense_battle/screens/my/screen_my_info.dart';
import 'package:sense_battle/utils/Print.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedMenuIndex = 0;

  late SignInProvider signInProvider;

  @override
  void initState() {
    if (signInProvider.userCredential != null && signInProvider.userInfo == null) {
      //TODO 로그인 추가해야됨.
    }
    super.initState();
  }

  void _menuSelected(var index) {
    setState(() {
      _selectedMenuIndex = index;
    });
  }

  List _mainWidgetList = [MakeSentenceScreen(), MakeSentenceHistoryScreen(), MyInfoScreen()];

  @override
  Widget build(BuildContext context) {
    signInProvider = Provider.of<SignInProvider>(context);

    Print.e("main screen signInProvider: ${signInProvider.userInfo.toString()}");

    return Scaffold(
      body: SafeArea(
        child: _mainWidgetList.elementAt(_selectedMenuIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        showSelectedLabels: false,
        showUnselectedLabels: false,
        selectedItemColor: Theme.of(context).accentColor,
        unselectedItemColor: Theme.of(context).primaryColor,
        backgroundColor: Theme.of(context).dialogBackgroundColor,
        currentIndex: _selectedMenuIndex,
        onTap: _menuSelected,
        items: [
          BottomNavigationBarItem(
              label: "Sense",
              icon: Icon(
                Icons.message,
              )),
          BottomNavigationBarItem(
              label: "History",
              icon: Icon(
                Icons.list,
              )),
          BottomNavigationBarItem(
              label: "My",
              icon: Icon(
                Icons.account_circle,
              )),
        ],
      ),
    );
  }
}
