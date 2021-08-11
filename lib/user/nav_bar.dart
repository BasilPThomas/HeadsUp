import 'package:headsup/user/searchPage.dart';
import 'package:headsup/utilities/constants.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

 late PersistentTabController _controller;

  @override
  void initState() {
    super.initState();
    _controller = PersistentTabController(initialIndex: 0);
  }
  List<Widget> _buildScreens() {
    return [
      SearchPage(),
      MeetupPage(),
      TokenPage(),
      SupportPage(),
      AccountPage()
    ];
  }

  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      PersistentBottomNavBarItem(
        icon: Icon(Icons.home_rounded,color: Colors.white,),
        title: ("Search"),
        // activeColor: Colors.pink[900],
        // inactiveColor: Colors.grey,
      ),
      PersistentBottomNavBarItem(
        icon:Icon(Icons.videocam_outlined ,color: Colors.white,),
        title: ('Meetup'),
        // activeColor: Colors.pink[900],
        // inactiveColor: Colors.grey,
      ),
      PersistentBottomNavBarItem(
        icon: Icon(Icons.dry_outlined,color: Colors.white, ),
        title: ('Token'),
        // activeColor: Colors.pink[900],
        // inactiveColor: Colors.grey,
      ),
      PersistentBottomNavBarItem(
        icon: Icon(Icons.person_add_outlined,color: Colors.white, ),
        title: ('Support'),
        // activeColor: Colors.pink[900],
        // inactiveColor: Colors.grey,
      ),
      PersistentBottomNavBarItem(
        icon: Icon(Icons.person_outline ,color: Colors.white,),
        title: ('AccountPage'),
        // activeColor: Colors.pink[900],
        // inactiveColor: Colors.grey,
      )
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: Container(
        child: PersistentTabView(
          context,
          controller: _controller,
          screens: _buildScreens(),
          items: _navBarsItems(),
          confineInSafeArea: true,
          backgroundColor: Colors.purple.shade800, // Default is Colors.white.
          handleAndroidBackButtonPress: true, // Default is true.
          resizeToAvoidBottomInset: true, // This needs to be true if you want to move up the screen when keyboard appears. Default is true.
          stateManagement: true, // Default is true.
          hideNavigationBarWhenKeyboardShows: true, // Recommended to set 'resizeToAvoidBottomInset' as true while using this argument. Default is true.
          navBarHeight: 70,
          popAllScreensOnTapOfSelectedTab: true,
          popActionScreens: PopActionScreensType.all,
          navBarStyle: NavBarStyle.simple, // Choose the nav bar style with this property
        ),
      ),
    );
  }
}


class MeetupPage extends StatelessWidget {
  const MeetupPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class TokenPage extends StatelessWidget {
  const TokenPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class SupportPage extends StatelessWidget {
  const SupportPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class AccountPage extends StatefulWidget {
  const AccountPage({Key? key}) : super(key: key);

  @override
  _AccountPageState createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Text("hello"),
          RaisedButton(
            onPressed: (){},
            child: Text("Logout"),
          ),
        ],
      ),
    );
  }
}


