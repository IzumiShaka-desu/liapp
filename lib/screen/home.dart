
import 'package:flutter/material.dart';
import 'package:liapp/consts/color_palette.dart';
import 'package:liapp/pages/home_page.dart';
import 'package:liapp/pages/profile_page.dart';
import 'package:liapp/provider/main_provider.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with TickerProviderStateMixin {
  TabController _controller;
  List<Widget> pages = [HomePage(), Profile()];
  bool isMenuOpened = false;
  @override
  void initState() {
    _controller = TabController(length: pages.length, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Consumer<MainProvider>(
          builder: (context, provider, child) => Stack(
            children: [
              Container(
                color: ColorPalette.mainBlue,
              ),
              Container(
                width: size.width * 0.5,
                child: SizedBox(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(height: 15),
                      Container(
                        child:  Container(
                    padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Colors.grey,
                      ),
                    ),
                    child: CircleAvatar(
                      minRadius: 35,
                      maxRadius: 40,
                      backgroundColor: ColorPalette.mainWhite,
                      backgroundImage: provider.photoProfile != null
                          ? FileImage(provider.photoProfile)
                          : AssetImage('images/icon.png'),
                    ),
                  ),
                        height: 75,
                        width: size.width * 0.5,
                      ),
                      VerticalDivider(thickness: 2),
                      Container(
                        padding: EdgeInsets.only(top:20,left:15),
                        child: Text(
                          provider.currentUser.name,
                          style: Theme.of(context).textTheme.headline6.copyWith(
                                color: ColorPalette.mainWhite,
                                
                              ),
                        ),
                      ),
                      ListTile(
                        leading: Icon(
                          Icons.home_outlined,
                          color: ColorPalette.mainWhite,
                        ),
                        onTap: () {
                          setState(() {
                            isMenuOpened = false;
                          });
                          _controller.animateTo(0);
                        },
                        title: Text(
                          'Home',
                          style: Theme.of(context)
                              .textTheme
                              .bodyText1
                              .copyWith(color: ColorPalette.mainWhite),
                        ),
                      ),
                      ListTile(
                        onTap: () {
                          setState(() {
                            isMenuOpened = false;
                          });
                          _controller.animateTo(1);
                        },
                        leading: Icon(
                          Icons.account_circle,
                          color: ColorPalette.mainWhite,
                        ),
                        title: Text(
                          'Profile',
                          style: Theme.of(context)
                              .textTheme
                              .bodyText1
                              .copyWith(color: ColorPalette.mainWhite),
                        ),
                      ),
                      ListTile(
                        onTap: () {
                          
                        },
                        hoverColor: ColorPalette.mainBlue.withOpacity(0.9),
                        leading: Icon(
                          Icons.exit_to_app_outlined,
                          color: ColorPalette.mainWhite,
                        ),
                        title: Text(
                          'Exit',
                          style: Theme.of(context)
                              .textTheme
                              .bodyText1
                              .copyWith(color: ColorPalette.mainWhite),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                top: size.height * 0.1,
                left: size.width * 0.51,
                child: Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                          color: ColorPalette.mainWhite.withOpacity(0.5)),
                    ),
                    child: IconButton(
                      icon: Icon(Icons.chevron_left_outlined),
                      iconSize: 32,
                      onPressed: () {
                        setState(() {
                          isMenuOpened = false;
                        });
                      },
                      color: ColorPalette.mainWhite,
                    )),
              ),
              AnimatedPositioned(
                top: isMenuOpened ? size.height * 0.08 : 0,
                left: isMenuOpened ? size.width * 0.6 : 0,
                duration: Duration(milliseconds: 250),
                child: SizedBox(
                  height: size.height,
                  width: size.width,
                  child: Transform.scale(
                    alignment: Alignment.topRight,
                    scale: isMenuOpened ? 0.85 : 1,
                    child: AnimatedContainer(
                      duration: Duration(milliseconds: 300),
                      padding: EdgeInsets.all(isMenuOpened ? 25 : 0),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: ColorPalette.secondary),
                      child: Scaffold(
                        backgroundColor: ColorPalette.secondary,
                        appBar: AppBar(
                          backgroundColor: Colors.transparent,
                          elevation: 0,
                          leading: IconButton(
                            icon: Icon(
                              Icons.menu_rounded,
                              color: Colors.grey,
                            ),
                            onPressed: () {
                              setState(() {
                                isMenuOpened = !isMenuOpened;
                              });
                            },
                          ),
                          actions: [
                            IconButton(
                              icon: Icon(
                                Icons.search,
                                color: Colors.grey,
                              ),
                              onPressed: () {},
                            ),
                            IconButton(
                              icon: Icon(
                                Icons.notifications_none_outlined,
                                color: Colors.grey,
                              ),
                              onPressed: () {},
                            ),
                          ],
                        ),
                        body: TabBarView(
                          physics: NeverScrollableScrollPhysics(),
                          controller: _controller,
                          children: pages,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
