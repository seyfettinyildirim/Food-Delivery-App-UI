import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:food_delivery_app/screens/home_screen.dart';
import 'package:food_delivery_app/screens/map_screen.dart';
import 'package:food_delivery_app/screens/mylist_screen.dart';
import 'package:food_delivery_app/screens/search_screen.dart';
import 'package:food_delivery_app/screens/voice_search_screen.dart';
import 'package:food_delivery_app/screens/profile_screen.dart';

void main() {
  Paint.enableDithering = true;
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Food Delivery App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        backgroundColor: Colors.deepOrange,
        primarySwatch: Colors.grey,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        fontFamily: 'Gilroy',
        textTheme: TextTheme(
          bodyText2: TextStyle(color: Colors.white),
        ),
        iconTheme: IconThemeData(color: Colors.white),
      ),
      home: MyAppContainer(),
    );
  }
}

class MyAppContainer extends StatefulWidget {
  MyAppContainer({Key key}) : super(key: key);

  @override
  _MyAppContainerState createState() => _MyAppContainerState();
}

class _MyAppContainerState extends State<MyAppContainer> {
  int _selectedIndex = 0;
  PageController _pageController;
  //TODO: seperate appbars
  List<String> appBarTitles = [
    'Home',
    'Search',
    'My List',
    'Map',
    'Voice Search'
  ];

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        return;
      },
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.bottomRight,
            end: Alignment.topLeft,
            stops: [0.0, 1.0],
            colors: [
              Color(0xff161a1e),
              Color(0xff25292d),
            ],
          ),
        ),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: buildAppBar(_selectedIndex),
          body: PageView(
            controller: _pageController,
            physics: NeverScrollableScrollPhysics(),
            onPageChanged: (index) {
              setState(() {
                _selectedIndex = index;
              });
            },
            children: [
              SafeArea(child: HomeScreen()),
              SafeArea(child: SearchScreen()),
              SafeArea(child: MyListScreen()),
              SafeArea(child: MapScreen()),
              SafeArea(child: VoiceSearchScreen()),
            ],
          ),
          bottomNavigationBar: bottomNavigationBar(),
        ),
      ),
    );
  }

  AppBar buildAppBar(int index) {
    return AppBar(
      backgroundColor: Colors.transparent,
      centerTitle: true,
      title: Text(
        appBarTitles[index],
        style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
      ),
      elevation: 0,
      actions: [
        Padding(
          padding: const EdgeInsets.all(12.0),
          child: InkWell(
            onTap: () {
              return Navigator.push(context,
                  MaterialPageRoute(builder: (context) => ProfileScreen()));
            },
            child: Hero(
              tag: 'avatar',
              child: ClipOval(
                child: Image.asset('assets/images/avatar.png'),
              ),
            ),
          ),
        ),
      ],
    );
  }

  BottomNavigationBar bottomNavigationBar() {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      backgroundColor: Color(0xff2c3136),
      unselectedItemColor: Color(0xff535c65),
      selectedItemColor: Color(0xfffb531a),
      showSelectedLabels: false,
      showUnselectedLabels: false,
      currentIndex: _selectedIndex,
      onTap: (index) {
        if (index != _selectedIndex) {
          setState(() {
            _selectedIndex = index;
            _pageController.jumpToPage(
              index,
            );
          });
        }
      },
      items: [
        BottomNavigationBarItem(
          icon: FaIcon(FontAwesomeIcons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: FaIcon(FontAwesomeIcons.search),
          label: 'Search',
        ),
        BottomNavigationBarItem(
          icon: FaIcon(FontAwesomeIcons.solidHeart),
          label: 'My List',
        ),
        BottomNavigationBarItem(
          icon: FaIcon(FontAwesomeIcons.mapMarker),
          label: 'Location',
        ),
        BottomNavigationBarItem(
          icon: FaIcon(FontAwesomeIcons.microphoneAlt),
          label: 'Mic',
        ),
      ],
    );
  }
}
