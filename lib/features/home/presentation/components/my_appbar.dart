import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todah/features/home/presentation/pages/home_page.dart';
import 'package:todah/features/profile/presentation/pages/profile_page.dart';


class MyAppbar extends StatefulWidget {
  const MyAppbar({super.key});

  @override
  State<MyAppbar> createState() => _MyAppbarState();
}

class _MyAppbarState extends State<MyAppbar> {
  @override
  void initState() {
    super.initState();
    _loadIndex();
  }

  int _selectedIndex = 0;

  Future<void> _loadIndex() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _selectedIndex = (prefs.getInt('selectedIndex') ?? 0);
    });
  }

  void _onItemTapped(int index) async {
    final prefs = await SharedPreferences.getInstance();

    _selectedIndex = index;

    await prefs.setInt('selectedIndex', index);

    setState(() {
      movePage(index);
    });
  }

  void movePage(index) {
    switch (index) {
      case 0:
        Navigator.of(context).push(PageRouteBuilder(
          pageBuilder: (context, _, __) {
            return const HomePage();
          },
        ));
        break;
      case 1:
        Navigator.of(context).push(PageRouteBuilder(
          pageBuilder: (context, _, __) {
            return const HomePage();
          },
        ));
        break;
      case 2:
        Navigator.of(context).push(PageRouteBuilder(
          pageBuilder: (context, _, __) {
            return const HomePage();
          },
        ));
        break;
      case 3:
        Navigator.of(context).push(PageRouteBuilder(
          pageBuilder: (context, _, __) {
            return const ProfilePage();
          },
        ));
        break;
      default:
    }
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      onTap: (int index) {
        _onItemTapped(index);
      },
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: '',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.people_rounded),
          label: '',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.chat_outlined),
          label: '',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.account_circle),
          label: '',
        ),
      ],
      currentIndex: _selectedIndex,
      type: BottomNavigationBarType.fixed,
      selectedItemColor: Colors.black,
      unselectedItemColor: Colors.grey,
    );
  }
}
