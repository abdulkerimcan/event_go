
import 'package:eventgo/features/tabs/home/view/home_view.dart';
import 'package:eventgo/features/tabs/profile/view/profile_view.dart';
import 'package:flutter/material.dart';

class BottomTapBar extends StatefulWidget {
  const BottomTapBar({Key? key}) : super(key: key);

  @override
  State<BottomTapBar> createState() => _BottomTapBarState();
}

class _BottomTapBarState extends State<BottomTapBar>
    with TickerProviderStateMixin {
  late final TabController _tabController;
  @override
  void initState() {
    super.initState();
    _tabController =
        TabController(length: _MyTabViews.values.length, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: _MyTabViews.values.length,
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          child: const Icon(
            Icons.add,
            color: Colors.white,
          ),
          onPressed: () {},
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        bottomNavigationBar: BottomAppBar(
            notchMargin: 10,
            color: Colors.white,
            padding: EdgeInsets.zero,
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: _myTabView(),
            )),
        body: _tabbarView(),
      ),
    );
  }

  TabBar _myTabView() {
    return TabBar(controller: _tabController, tabs: const [
      Tab(
        icon: Icon(Icons.home),
        text: "",
        iconMargin: EdgeInsets.only(top: 20),
      ),
      Tab(
        icon: Icon(Icons.calendar_month),
        text: "",
        iconMargin: EdgeInsets.only(top: 20),
      ),
      Tab(
        icon: Icon(Icons.map),
        text: "",
        iconMargin: EdgeInsets.only(top: 20),
      ),
      Tab(
        icon: Icon(Icons.person),
        text: "",
        iconMargin: EdgeInsets.only(top: 20),
      ),
    ]);
  }

  TabBarView _tabbarView() {
    return TabBarView(
        physics: const NeverScrollableScrollPhysics(),
        controller: _tabController,
        children: const [HomeView(), HomeView(), HomeView(), ProfileView()]);
  }
}

enum _MyTabViews { home, settings, favorite, profile }

extension _MyTabViewExtension on _MyTabViews {}
