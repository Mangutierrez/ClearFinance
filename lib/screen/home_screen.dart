import 'package:clear_finance/screen/history_content.dart';
import 'package:clear_finance/screen/home_content.dart';
import 'package:clear_finance/screen/category_content.dart';
import 'package:clear_finance/screen/goals_content.dart';
import 'package:clear_finance/screen/new_category_content.dart';
import 'package:clear_finance/screen/perfil_content.dart'; 
import 'package:clear_finance/screen/help_content.dart';
import 'package:clear_finance/screen/welcome_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  final Color _colorBottomItemSelected = const Color(0xFFBA7423);

  static const List<Widget> _widgetOptions = <Widget>[
    HomeContent(),
    HistoryContent(),
    CategoryContent(),
    GoalsContent(),
  ];


  static const List<String> _appBarTitlePages = <String>[
    'Resumen Financiero',
    'Historial',
    'Categorías',
    'Metas',
  ];

  void _onItemTapped(int index) {
    _onPageContentChange(index);
  }

  void _onPageContentChange(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: SvgPicture.asset('assets/images/ic_menu_drawer.svg'),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
            );
          },
        ),
        title: Text(
          _appBarTitlePages.elementAt(_selectedIndex),
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ),
      drawer: Drawer(
          child: Container(
        margin: const EdgeInsets.all(24),
        child: ListView(
          children: <Widget>[
            const SizedBox(height: 20),
            Padding(
                padding: const EdgeInsets.only(right: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Menú',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: const Icon(
                        Icons.close,
                        size: 26,
                        color: Colors.black,
                      ),
                    )
                  ],
                )),
            const SizedBox(height: 20),
            ListTile(
              leading: SvgPicture.asset('assets/images/ic_profile.svg'),
              title: const Text('Perfil', style: TextStyle(fontSize: 16)),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => PerfilContent()), // Redirige a PerfilContent
                );
              },
            ),
            ListTile(
              leading: SvgPicture.asset('assets/images/ic_help.svg'),
              title: const Text('Ayuda',
                  style: TextStyle(
                    fontFamily: 'Inter',
                    fontSize: 16,
                  )),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => HelpContent()), // Redirige a HelpContent
                );
              },
            ),
            ListTile(
              leading: SvgPicture.asset('assets/images/ic_logout.svg'),
              title: const Text('Cerrar Sesión',
                  style: TextStyle(
                    fontFamily: 'Inter',
                    fontSize: 16,
                  )),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => WelcomeScreen()), // Redirige a HelpContent
                );
              },
            ),
          ],
        ),
      )),
      body: Column(
        children: [
          const Divider(height: 1, color: Colors.grey),
          Expanded(
            child: Center(
              child: _widgetOptions.elementAt(_selectedIndex),
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              'assets/images/ic_home.svg',
              color:
                  _selectedIndex == 0 ? _colorBottomItemSelected : Colors.black,
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              'assets/images/ic_history.svg',
              color:
                  _selectedIndex == 1 ? _colorBottomItemSelected : Colors.black,
            ),
            label: 'Historial',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              'assets/images/ic_category.svg',
              color:
                  _selectedIndex == 2 ? _colorBottomItemSelected : Colors.black,
            ),
            label: 'Categorías',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              'assets/images/ic_goals.svg',
              color:
                  _selectedIndex == 3 ? _colorBottomItemSelected : Colors.black,
            ),
            label: 'Metas',
          ),
        ],
        currentIndex: _selectedIndex,
        unselectedItemColor: Colors.black,
        unselectedLabelStyle: const TextStyle(color: Colors.black),
        showUnselectedLabels: true,
        selectedItemColor: const Color(0xFFBA7423),
        onTap: _onItemTapped,
      ),
    );
  }
}
