import 'package:flutter/material.dart';
import 'package:prj_wisatacandisi51/widgets/detail_screen.dart';
import 'package:prj_wisatacandisi51/data/candi_data.dart';
import 'package:prj_wisatacandisi51/widgets/favorite_screen.dart';
import 'package:prj_wisatacandisi51/widgets/home_screen.dart';
import 'package:prj_wisatacandisi51/widgets/profile_screen.dart';
import 'package:prj_wisatacandisi51/widgets/search_screen.dart';
import 'package:prj_wisatacandisi51/widgets/signin_screen.dart';
import 'package:prj_wisatacandisi51/widgets/signup_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Wisata Candi',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        appBarTheme: const AppBarTheme(
            iconTheme: IconThemeData(color: Colors.deepPurple),
            titleTextStyle: TextStyle(
                color: Colors.deepPurple,
                fontSize: 20,
                fontWeight: FontWeight.bold)),
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple)
            .copyWith(
                primary: Colors.deepPurple, surface: Colors.deepPurple[50]),
        useMaterial3: true,
      ),
      home: const SignUpScreen(),
      // const HomeScreen(),
      // const SearchScreen(),
      // const SignUpScreen(),
      // const ProfileScreen(),
      // DetailScreen(candi: candiList[0]),
    );
  }
}

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  // TODO 1. Deklarasikan Variabel
  int _currentIndex = 0;
  final List<Widget> _children = [
    const HomeScreen(),
    const SearchScreen(),
    const FavouriteScreen(),
    const ProfileScreen(),
    DetailScreen(candi: candiList[0]),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // TODO 2. Buat properti  body berupa widget yang ditampilkan
      body: _children[_currentIndex],
      bottomNavigationBar: Theme(
          data: Theme.of(context).copyWith(
            canvasColor: Colors.deepPurple.shade50,
          ),
          child: BottomNavigationBar(
            currentIndex: _currentIndex,
            onTap: (index) {
              setState(() {
                _currentIndex = index;
              });
            },
            items: const [
              BottomNavigationBarItem(
                  icon: Icon(
                    Icons.home,
                    color: Colors.deepPurple,
                  ),
                  label: "Home"),
              BottomNavigationBarItem(
                  icon: Icon(
                    Icons.search,
                    color: Colors.deepPurple,
                  ),
                  label: "Search"),
              BottomNavigationBarItem(
                  icon: Icon(
                    Icons.favorite,
                    color: Colors.deepPurple,
                  ),
                  label: "Favorite"),
              BottomNavigationBarItem(
                  icon: Icon(
                    Icons.person,
                    color: Colors.deepPurple,
                  ),
                  label: "Profile"),
            ],
            selectedItemColor: Colors.deepPurple,
            unselectedItemColor: Colors.deepPurple.shade100,
            showUnselectedLabels: true,
          )),
      // TODO 3. Buat properti  bottomNavigatorBar dengan nilai theme
      // TODO 4. Buat data dan child dari theme
    );
  }
}
