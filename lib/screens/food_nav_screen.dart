import 'package:flutter/material.dart';
import 'package:millyshb/screens/food_feed_screen.dart';
import 'package:millyshb/screens/home_screen.dart';
import 'package:millyshb/utills/colors.dart';

class FoodNavScreen extends StatefulWidget {
  final bool isFood;
  const FoodNavScreen({this.isFood = false, super.key});

  @override
  State<FoodNavScreen> createState() => _FoodNavScreenState();
}

class _FoodNavScreenState extends State<FoodNavScreen> {
  int _page = 0;
  late PageController pageController; // for tabs animation

  bool isFood = false;

  @override
  void initState() {
    super.initState();
    pageController = PageController();
  }

  List<Widget> homeScreenItems = [
    FoodFeedscreen(),
  ];
  @override
  void dispose() {
    super.dispose();
    pageController.dispose();
  }

  void onPageChanged(int page) {
    setState(() {
      _page = page;
    });
  }

  void navigationTapped(int page) {
    //Animating Page
    pageController.jumpToPage(page);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: PageView(
        controller: pageController,
        onPageChanged: onPageChanged,
        children: homeScreenItems,
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        type: BottomNavigationBarType.fixed,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(
              size: 30,
              Icons.home_outlined,
              color: (_page == 0)
                  ? Colors
                      .black //Color.fromARGB(255, 243, 136, 172).withOpacity(.5)
                  : Pallete.accentColor,
            ),
            label: 'Home',
            backgroundColor: Pallete.accentColor,
          ),
          BottomNavigationBarItem(
              icon: Icon(
                size: 30,
                Icons.favorite_outline,
                color: (_page == 1) ? Colors.black : Pallete.accentColor,
              ),
              label: 'Wishlist',
              backgroundColor: Pallete.accentColor),
          BottomNavigationBarItem(
            icon: Icon(
              size: 30,
              Icons.food_bank,
              color: (_page == 2) ? Colors.black : Pallete.accentColor,
            ),
            label: '',
            backgroundColor: Pallete.accentColor,
          ),
          BottomNavigationBarItem(
            icon: Icon(
              size: 30,
              Icons.search,
              color: (_page == 3) ? Colors.black : Pallete.accentColor,
            ),
            label: 'Search',
            backgroundColor: Pallete.accentColor,
          ),
          BottomNavigationBarItem(
            icon: Icon(
              size: 30,
              Icons.settings,
              color: (_page == 4) ? Colors.black : Pallete.accentColor,
            ),
            // icon: Image.asset('assets/images/logo.png',
            //     color: Colors
            //         .white //(_page == 2) ? Colors.black : Pallete.accentColor,
            //     ),
            label: 'Setting',
            backgroundColor: Pallete.accentColor,
          ),
        ],
        onTap: navigationTapped,
        currentIndex: _page,
      ),
    );
  }
}
