import 'package:flutter/material.dart';
import 'package:liapp/consts/color_palette.dart';
import 'package:liapp/model/profile.dart';
import 'package:liapp/provider/main_provider.dart';
import 'package:liapp/screen/home.dart';
import 'package:liapp/screen/login_register.dart';
import 'package:provider/provider.dart';

class PageContainer extends StatefulWidget {
  final ProfileModel user;

  const PageContainer({Key key, this.user}) : super(key: key);

  @override
  _PageContainerState createState() => _PageContainerState();
}

class _PageContainerState extends State<PageContainer> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: ColorPalette.mainWhite,
      child: ChangeNotifierProvider<MainProvider>(
        create: (context) => MainProvider(currentUser: widget.user),
        child: Container(
          child: Consumer<MainProvider>(
            builder: (ctx, provider, _) {
              return (provider.currentUser?.email != null)
                  ? Home()
                  : LoginRegister();
            },
          ),
        ),
      ),
    );
  }
}
