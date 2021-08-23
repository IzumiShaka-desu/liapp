import 'package:flutter/material.dart';
import 'package:liapp/consts/color_palette.dart';
import 'package:liapp/screen/page_container.dart';

class Intro extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: ColorPalette.mainWhite,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(20),
              child: Image.asset('images/intro.png'),
            ),
            Text(
              'Organize your to-do list here',
              style: Theme.of(context).textTheme.headline5,
            ),
          ],
        ),
      ),
      bottomNavigationBar: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            child: MaterialButton(
              color: ColorPalette.altBlue,
              padding: EdgeInsets.fromLTRB(25,10,25,10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(' Get Started ',style: Theme.of(context).textTheme.bodyText1?.copyWith(color:ColorPalette.mainWhite),),
                ],
              ),
              onPressed: () => Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (ctx) => PageContainer(),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
